//
//  JYCollectionViewCell.h
//  瀑布流（UICollectionView）实现
//
//  Created by James on 16/3/16.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *JYImageView;

+ (JYCollectionViewCell *)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end
