//
//  JYCollectionViewCell.m
//  瀑布流（UICollectionView）实现
//
//  Created by James on 16/3/16.
//  Copyright © 2016年 James. All rights reserved.
//

#import "JYCollectionViewCell.h"

@implementation JYCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        _JYImageView = [[UIImageView alloc] init];
        
        _JYImageView.backgroundColor = [UIColor orangeColor];
        
        _JYImageView.layer.cornerRadius = 5;
        
        [self.contentView addSubview:_JYImageView];
    
    }

    return self;
}

+ (JYCollectionViewCell *)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath {
    JYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ident" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[JYCollectionViewCell alloc] init];
    }
    
    return cell;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    _JYImageView.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height);
}

@end
