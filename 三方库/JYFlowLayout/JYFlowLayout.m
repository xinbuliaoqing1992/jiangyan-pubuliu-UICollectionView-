//
//  JYFlowLayout.m
//  瀑布流（UICollectionView）实现
//
//  Created by James on 16/3/16.
//  Copyright © 2016年 James. All rights reserved.
//

#import "JYFlowLayout.h"

@interface JYFlowLayout()

//储存items的Y(高度)值的数组
@property (strong, nonatomic) NSMutableArray *itemsYArr;

//储存items属性的数组
@property (strong, nonatomic) NSMutableArray *attributeArr;

@end

@implementation JYFlowLayout

//准备布局
- (void)prepareLayout {
    //初始化储存items的Y(高度)值的数组
    _itemsYArr = [NSMutableArray arrayWithCapacity:_columnCount];
    
    _attributeArr = [NSMutableArray array];
    
    //初始化最开始items的Y(高度)值, 其实就是之前设定的与屏幕最上方的间距值
    for (int i = 0; i < _columnCount; i++) {
        _itemsYArr[i] = @(_cvEdgeInsets.top);
    }
    
    CGFloat itemsW = (self.collectionView.frame.size.width - _cvEdgeInsets.left - _cvEdgeInsets.right - _itemsSpace *(_columnCount-1))/_columnCount;
    
    //拿到所有item的个数
    NSInteger totalItemsNumber = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < totalItemsNumber; i++) {
        NSInteger columnCount = [self currentColumnCount];
        
        CGFloat itemsX = _cvEdgeInsets.left + (_itemsSpace + itemsW) * columnCount;
        
        CGFloat itemsY = [_itemsYArr[columnCount] floatValue];
        
        CGFloat itemsH = 0.0;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        if (_delegate && [_delegate respondsToSelector:@selector(itemsHeightLayout:andIndexPath:)]) {
            itemsH = [_delegate itemsHeightLayout:self andIndexPath:indexPath];
        }
        
        CGRect itemsFrame = CGRectMake(itemsX, itemsY, itemsW, itemsH);
        
        //取出所在indexPath下的items属性
        UICollectionViewLayoutAttributes *itemsAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        itemsAttributes.frame = itemsFrame;
        
        //把属性存进数组里
        [_attributeArr addObject:itemsAttributes];

        
        //CGFloat updateY = [_itemsYArr[columnCount] floatValue] + itemsH + _itemsSpace;
        
        //把当前对应列的item的最大Y(高度)值＋空隙(高度)值赋给储存items的Y(高度)值的数组
        _itemsYArr[columnCount] = @([_itemsYArr[columnCount] floatValue] + itemsH + _itemsSpace);
        
    }
}

//CollectionView的滚动区域
- (CGSize)collectionViewContentSize {
    
    CGFloat totalWidth = self.collectionView.frame.size.width;
    
    NSInteger maxColumnCount = [self currentMaxColumnCount];
    
    CGFloat maxHeight = [_itemsYArr[maxColumnCount] floatValue];
    
    //返回最大Y(高度)值
    return CGSizeMake(totalWidth, maxHeight);
    
}


//确定拥有最大Y(高度)值的item在哪列中
- (NSInteger)currentMaxColumnCount {
    CGFloat maxY = 0;
    
    NSInteger columnCount = 0;
    
    for (int i = 0; i < _itemsYArr.count; i++) {
        CGFloat itemsY = [_itemsYArr[i] floatValue];
        
        if (itemsY > maxY) {
            maxY = itemsY;
            columnCount = i;
        }
        
    }
    return columnCount;
}


//确定items在哪列中
- (NSInteger)currentColumnCount {
    CGFloat maxY = MAXFLOAT;
    
    NSInteger columnCount = 0;
    
    for (int i = 0; i < _itemsYArr.count; i++) {
        CGFloat itemsY = [_itemsYArr[i] floatValue];
        
        if (itemsY < maxY) {
            maxY = itemsY;
            columnCount = i;
        }
        
    }
    return columnCount;
}


//CGRectIntersectsRect这个方法遍历判断有哪些attributes的frame在这个区域里,然后返回给collectionView
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attributes in _attributeArr) {
        CGRect rect1 = attributes.frame;
        if (CGRectIntersectsRect(rect1, rect)) {
            [resultArray addObject:attributes];
        }
    }
    
    return resultArray;
}


@end
