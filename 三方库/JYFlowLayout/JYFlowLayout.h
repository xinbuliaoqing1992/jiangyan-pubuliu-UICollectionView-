//
//  JYFlowLayout.h
//  瀑布流（UICollectionView）实现
//
//  Created by James on 16/3/16.
//  Copyright © 2016年 James. All rights reserved.
//


#import <UIKit/UIKit.h>

@class JYFlowLayout;

@protocol JYFlowLayoutDelegate <NSObject>

- (CGFloat)itemsHeightLayout:(JYFlowLayout *)Layout andIndexPath:(NSIndexPath *)IndexPath;

@end

@interface JYFlowLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) NSInteger columnCount;

@property (assign, nonatomic) CGFloat itemsSpace;

@property (assign, nonatomic) UIEdgeInsets cvEdgeInsets;

@property (assign, nonatomic) id <JYFlowLayoutDelegate> delegate;

@end
