//
//  CustomLayoutCollection.swift
//  testLayoutCollection
//
//  Created by oneweek on 10/12/18.
//  Copyright © 2018 Harry Nguyen. All rights reserved.
//

import UIKit


protocol CustomLayoutDelegate {
    //Method to ask the delegate for the height of the image
    func heightOfRows()->CGFloat
    
}

class CustomLayoutCollection: UICollectionViewLayout {
    let attributeArray = NSMutableDictionary()
    var contentSize:CGSize!
    var delegate:CustomLayoutDelegate!
    var marginItem : CGFloat = 10
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var collectionViewContentSize: CGSize{
        // Trả về ContentSize của CollectionView đã tính được ở hàm prepare
        return self.contentSize
    }
    override func prepare()
    {
        super.prepare()
        guard let collectionView = self.collectionView else {
            return
        }
        self.attributeArray.removeAllObjects()
        
        let rowHeight:CGFloat = delegate.heightOfRows()
        let collectionViewWidth = collectionView.frame.size.width
        let widthSmallItem : CGFloat = (rowHeight - self.marginItem) / 2
        let widthLargeItem : CGFloat = collectionViewWidth - widthSmallItem - self.marginItem*3
        var contentHeight:CGFloat = 0.0
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let numberItemInLastRow = numberOfItems % 3
        
        //Tính toán kích thước và vị trí của từng cell trong CollectionView
        for i in 0 ... numberOfItems - 1 {
            var tempX : CGFloat = 0.0
            var tempY : CGFloat = 0.0
            var heightItem : CGFloat = 0.0
            var widthItem : CGFloat = 0.0
            let indexPath = NSIndexPath(item: i, section: 0)
            let mainItemLeftSide = (i / 3) % 2 == 0
            let position = (i + 1) % 3
            let rowY = (CGFloat(i / 3) * rowHeight) + (CGFloat(i / 3) * self.marginItem) + self.marginItem
            
            //tinh toan vi tri cua cell
            if numberItemInLastRow == 1 && i == (numberOfItems - 1) {
                tempX = self.marginItem
                tempY = rowY
                widthItem = collectionViewWidth - self.marginItem - self.marginItem
                heightItem = rowHeight
            }else if numberItemInLastRow == 2 && i == (numberOfItems - 2) {
                tempX = self.marginItem
                tempY = rowY
                widthItem = (collectionViewWidth - (self.marginItem*3.0))/2
                heightItem = rowHeight
            }else if numberItemInLastRow == 2 && i == (numberOfItems - 1) {
                widthItem = (collectionViewWidth - (self.marginItem*3.0))/2
                heightItem = rowHeight
                tempX = (self.marginItem*2.0) + widthItem
                tempY = rowY
            }else{
                if position == 0 {
                    tempX = self.marginItem
                    tempY = rowY
                    if mainItemLeftSide {
                        heightItem = rowHeight
                        widthItem = widthLargeItem
                    }else{//main item in right side
                        heightItem = (rowHeight - self.marginItem) / 2
                        widthItem = widthSmallItem
                    }
                }else if position == 1 {
                    heightItem = (rowHeight - self.marginItem) / 2
                    widthItem = widthSmallItem
                    if mainItemLeftSide {
                        tempX = self.marginItem + self.marginItem + widthLargeItem
                        tempY = rowY
                    }else{
                        tempX = self.marginItem
                        tempY = rowY + self.marginItem + heightItem
                    }
                }else{
                    if mainItemLeftSide {
                        tempX = self.marginItem + self.marginItem + widthLargeItem
                        heightItem = (rowHeight - self.marginItem) / 2
                        widthItem = widthSmallItem
                        tempY = rowY + self.marginItem + heightItem
                    }else{
                        heightItem = rowHeight
                        tempY = rowY
                        widthItem = widthLargeItem
                        tempX = self.marginItem + self.marginItem + widthSmallItem
                    }
                }
            }
            
            //Bổ sung  cell mới vào mảng attr
            let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath as IndexPath)
            attributes.frame = CGRect(x: tempX, y: tempY, width: widthItem, height: heightItem)
            self.attributeArray.setObject(attributes, forKey: indexPath)
            
            //Tính toán lại chiều cao Content Size của CollectionView
            if i % 3 != 0 {
                let newContentHeight:CGFloat = tempY + rowHeight
                if (newContentHeight > contentHeight){
                    contentHeight = newContentHeight
                }
            }
        }
        
        self.contentSize = CGSize(width: collectionView.frame.size.width, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Duyệt các đối tượng trong attributeArray để tìm ra các cell nằm trong khung nhìn rect
        for attributes  in self.attributeArray {
            if (attributes.value as! UICollectionViewLayoutAttributes).frame.intersects(rect ) {
                layoutAttributes.append((attributes.value as! UICollectionViewLayoutAttributes))
            }
        }
        return layoutAttributes
    }

}
