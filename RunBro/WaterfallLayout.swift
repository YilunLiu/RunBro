//
//  WaterfallLayout.swift
//  RunBro
//
//  Created by Yilun Liu on 3/17/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

enum CollectionViewWaterfallLayoutItemRenderDirection : Int {
    case ShortestFirst
    case LeftToRight
    case RightToLeft
}


@objc protocol WaterfallLayoutDelegate {
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, columnCountForSecition section: Int) -> Int
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, heightForHeaderInSection section: Int) ->CGFloat
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, heightForFooterInSection section: Int) ->CGFloat
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, insetForHeaderInSection section: Int) -> UIEdgeInsets
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, insetForFooterInSection section: Int) -> UIEdgeInsets
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, minimunInteritemSpacingForSectionAtIndex section: Int) -> CGFloat

}

let WaterfallLayoutElementKindSectionHeader = "WaterfallLayoutElementKindSectionHeader"
let WaterfallLayoutElementKindSectionFooter = "WaterfallLayoutElementKindSectionFooter"


class WaterfallLayout: UICollectionViewLayout {
    

    let unionSize = 20
    
    var columnCount : NSInteger{
        didSet{
            invalidateLayout()
        }}
    
    var minimumColumnSpacing : CGFloat{
        didSet{
            invalidateLayout()
        }}
    
    var minimumInteritemSpacing : CGFloat{
        didSet{
            invalidateLayout()
        }}
    
    var headerHeight : CGFloat{
        didSet{
            invalidateLayout()
        }}
    
    var headerInset : UIEdgeInsets {
        didSet {
            invalidateLayout()
        }
    }
    
    var footerHeight : CGFloat{
        didSet{
            invalidateLayout()
        }}
    
    var footerInset: UIEdgeInsets {
        didSet{
            invalidateLayout()
        }
    }
    
    var sectionInset : UIEdgeInsets{
        didSet{
            invalidateLayout()
        }}
    
    
    var itemRenderDirection : CollectionViewWaterfallLayoutItemRenderDirection{
        didSet{
            invalidateLayout()
        }}
    

    weak var delegate : WaterfallLayoutDelegate? {
        get {
           return self.collectionView?.delegate as? WaterfallLayoutDelegate
        }
    }
    


    private var headersAttribute = [String : UICollectionViewLayoutAttributes]()
    private var footersAttribute = [String : UICollectionViewLayoutAttributes]()
    private var unionRects = [CGRect]()
    private var columnHeights = [[CGFloat]]()
    private var allItemAttributes = [UICollectionViewLayoutAttributes]()
    private var sectionItemAttributes = [[UICollectionViewLayoutAttributes]]()
    
    
    
    //MAKR: Init
    
    override init(){
        columnCount = 2
        minimumColumnSpacing = 10
        minimumInteritemSpacing = 10
        headerHeight = 0
        footerHeight = 0
        sectionInset = UIEdgeInsetsZero
        headerInset = UIEdgeInsetsZero
        footerInset = UIEdgeInsetsZero
        itemRenderDirection = .ShortestFirst
        super.init()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : PrepareLayout
    override func prepareLayout() {
        super.prepareLayout()
        
        var numberOfSections = self.collectionView!.numberOfSections()
        if numberOfSections == 0 {
            return;
        }
        
        
        self.headersAttribute.removeAll(keepCapacity: false)
        self.footersAttribute.removeAll(keepCapacity: false)
        self.unionRects.removeAll(keepCapacity: false)
        self.columnHeights.removeAll(keepCapacity: false)
        self.allItemAttributes.removeAll(keepCapacity: false)
        self.sectionItemAttributes.removeAll(keepCapacity: false)
        
        
        for section in 0 ..< numberOfSections {
            var columnCount = self.columnCountForSection(section)
            var sectionColumnHeights = [CGFloat]()
            for i in 0 ..< columnCount {
                sectionColumnHeights.append(0)
            }
            self.columnHeights.append(sectionColumnHeights)
        }
        
        
        //prepare attributes
        var top:CGFloat = 0
        var attribute: UICollectionViewLayoutAttributes
        
        for section in 0 ..< numberOfSections {
            //section attributes - minimumInteritemSpacing sectionInset
            var minimunInteritemSpacing: CGFloat = self.delegate?.collectionView?(self.collectionView!, layout: self, minimunInteritemSpacingForSectionAtIndex: section) ?? self.minimumInteritemSpacing
            var sectionInset = self.delegate?.collectionView?(self.collectionView!, layout: self, insetForSectionAtIndex: section) ?? self.sectionInset
            
            var width: CGFloat = self.collectionView!.frame.width - sectionInset.left - sectionInset.right
            var columnCount = self.columnCountForSection(section)
            var itemWidth:CGFloat = floor((width - (CGFloat(columnCount) - 1.0) * self.minimumInteritemSpacing)/CGFloat(columnCount))
            
            //section header
            var headerHeight = self.delegate?.collectionView?(self.collectionView!, layout: self, heightForHeaderInSection: section) ?? self.headerHeight
            var headerInset = self.delegate?.collectionView?(self.collectionView!, layout: self, insetForHeaderInSection: section) ?? self.headerInset
            
            top += headerInset.top
            
            if headerHeight > 0 {
                attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: WaterfallLayoutElementKindSectionHeader, withIndexPath: NSIndexPath(forItem: 0, inSection: section))
                attribute.frame = CGRectMake(headerInset.left, top, self.collectionView!.frame.size.width - headerInset.left - headerInset.right, headerHeight)
                self.headersAttribute["\(section)"] = attribute
                self.allItemAttributes.append(attribute)
                top = sectionInset.bottom + CGRectGetMaxY(attribute.frame)
            }
            
            top += sectionInset.top
            for idx in 0 ..< columnCount {
                self.columnHeights[section][idx] = top
            }
            
            //section items
            var itemCount = self.collectionView!.numberOfItemsInSection(section)
            var itemAttributes = [UICollectionViewLayoutAttributes]()
            
            for idx in 0 ..< itemCount {
                let indexPath = NSIndexPath(forItem: idx, inSection: section)
                let columnIndex = self.nextColumnIndexForItem(idx, inSection: section)
                let xOffset: CGFloat = sectionInset.left + (itemWidth + self.minimumInteritemSpacing) * CGFloat(columnIndex)
                let yOffset = self.columnHeights[section][columnIndex]
                var itemSize = self.delegate!.collectionView(self.collectionView!, layout: self, sizeForItemAtIndexPath: indexPath)
                var itemHeight: CGFloat = 0
                if (itemSize.height > 0 && itemSize.width > 0){
                    itemHeight = floor(itemSize.height * itemWidth / itemSize.width)
                }
                attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attribute.frame = CGRectMake(xOffset, yOffset, itemWidth, itemHeight)
                itemAttributes.append(attribute)
                self.allItemAttributes.append(attribute)
                self.columnHeights[section][columnIndex] = CGRectGetMaxY(attribute.frame) + minimumInteritemSpacing
                
            }
            self.sectionItemAttributes.append(itemAttributes)
            
            
            //section footer
            var columnIndex = self.longestColumnIndexInSection(section)
            top = self.columnHeights[section][columnIndex] - minimumInteritemSpacing + sectionInset.bottom
            var footerHeight = self.delegate?.collectionView?(self.collectionView!, layout: self, heightForFooterInSection: section) ?? self.footerHeight
            var footInset = self.delegate?.collectionView?(self.collectionView!, layout: self, insetForFooterInSection: section) ?? self.footerInset
            top += footInset.top
            
            if footerHeight > 0 {
                attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: WaterfallLayoutElementKindSectionFooter, withIndexPath: NSIndexPath(forItem: 0, inSection: section))
                attribute.frame = CGRectMake(footerInset.left, top, self.collectionView!.frame.width - footerInset.left - footInset.right, footerHeight)
                self.footersAttribute["\(section)"] = attribute
                self.allItemAttributes.append(attribute)
            }
            
            for idx in 0 ..< columnCount {
                self.columnHeights[section][idx] = top
            }
            
        }
        
        var idx = 0
        var itemCounts = self.allItemAttributes.count
        while idx < itemCounts {
            var rect1 = self.allItemAttributes[idx].frame
            idx = min(idx + unionSize, itemCounts) - 1
            var rect2 = self.allItemAttributes[idx].frame
            self.unionRects.append(CGRectUnion(rect1,rect2))
            idx++
        }
        
        
        
    }
    
    //MARK: UICollectionViewLayout Methods
    override func collectionViewContentSize() -> CGSize {
        var numberOfSections = self.collectionView?.numberOfSections()
        if (numberOfSections == 0){
            return CGSizeZero
        }
        
        var contentSize = self.collectionView!.bounds.size
        contentSize.height = columnHeights.last!.first!
        return contentSize
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        if indexPath.section >= self.sectionItemAttributes.count {
            return nil
        }
        if (indexPath.item >=  self.sectionItemAttributes[indexPath.section].count){
            return nil
        }
        return self.sectionItemAttributes[indexPath.section][indexPath.item]
    }

    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        if elementKind == WaterfallLayoutElementKindSectionHeader {
            if let headerAttribute = self.headersAttribute["\(indexPath.section)"]{
                return headerAttribute
            }
        }
        else if elementKind == WaterfallLayoutElementKindSectionFooter{
            if let footerAttribute = self.footersAttribute["\(indexPath.section)"]{
                return footerAttribute
            }
        }
        return nil
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var begin = 0, end = self.unionRects.count
        
        for i in 0 ..< self.unionRects.count {
            if (CGRectIntersectsRect(rect, self.unionRects[i])){
                begin = i * unionSize
                break
            }
        }
        for var i = self.unionRects.count - 1; i >= 0 ; i-- {
            if (CGRectIntersectsRect(rect, self.unionRects[i])){
                end = min((i+1) * unionSize, self.allItemAttributes.count)
                break
            }
        }
        
        var found = false
        
        var attrs = [UICollectionViewLayoutAttributes]()
        for i in begin ..< end {
            var attr = self.allItemAttributes[i]
            if (CGRectIntersectsRect(rect, attr.frame)){
                attrs.append(attr)
            }
        }
        
        return attrs
    }
    
//    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
//        return true
//    }
    
    //MARK: helper
    func columnCountForSection(section: Int) ->Int{
        var columnCount = self.delegate?.collectionView?(self.collectionView!, layout: self, columnCountForSecition: section) ?? self.columnCount
        return columnCount
    }
    
    func itemWidthInSectionAtIndex(section: Int) -> Int {
        var sectionInset : UIEdgeInsets = self.delegate?.collectionView?(self.collectionView!, layout: self, insetForSectionAtIndex: section) ?? self.sectionInset
        var width:CGFloat = self.collectionView!.frame.width - sectionInset.left - sectionInset.right
        var columnCount: Int = self.columnCountForSection(section)
        var itemWith:CGFloat = (width - (CGFloat(columnCount) - 1.0) * self.minimumColumnSpacing) / CGFloat(columnCount)
        return Int(floor(itemWith))
        
    }
    
    //find the shortest column
    private func shortestColumnIndexInSection(section: Int) -> Int{
        var index = 0
        var shortestHeight:CGFloat = CGFloat.max
        for (i, obj) in enumerate(columnHeights[section]){
            let height = CGFloat(obj)
            if (height < shortestHeight) {
                shortestHeight = height
                index = i
            }
        }
        return index
    }
    
    
    //find the longest column
    private func longestColumnIndexInSection(section : Int)-> Int{
        var index: Int = 0
        var longestHeight: CGFloat = 0
        for (i, obj) in enumerate(columnHeights[section]){
            let height = CGFloat(obj)
            if(height > longestHeight){
                longestHeight = height
                index = i
            }
            
        }
        return index
        
    }
    
    //find the index fo the next column
    private func nextColumnIndexForItem(item: Int, inSection section:Int) ->Int{
        var index = 0;
        var columnCount = self.columnCountForSection(section)
        switch (self.itemRenderDirection) {
        case .ShortestFirst:
            index = self.shortestColumnIndexInSection(section)
        case .LeftToRight:
            index = item % columnCount
        case .RightToLeft:
            index = (columnCount - 1) - (item % columnCount)
        }
        
        return index
    }
    

}
