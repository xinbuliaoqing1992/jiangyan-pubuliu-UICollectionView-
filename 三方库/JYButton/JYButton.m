//
//  JYButton.m
//  代理，通知，单例，通知反向传值练习。
//
//  Created by 新不了情1992 on 16/2/25.
//  Copyright © 2016年 新不了情1992. All rights reserved.
//

#import "JYButton.h"

@interface JYButton()

@property (copy, nonatomic) ClickJYButtonBlock clickJYButtonBlock;

@end

@implementation JYButton

+ (JYButton *)buttonWithType:(UIButtonType)type Frame:(CGRect)frame ButtonTitle:(NSString *)buttonTitle ButtonBackgroundColor:(UIColor *)buttonBackgroundColor ButtonTitleColor:(UIColor *)buttonTitleColor CornerRadius:(double)cornerRadius ButtonTitleSize:(NSInteger)buttonTitleSize andClickJYButtonBlock:(ClickJYButtonBlock)clickJYButtonBlock {
    
    JYButton *jyButton = [JYButton buttonWithType:UIButtonTypeCustom];
    
    jyButton.frame = frame;
    
    [jyButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    [jyButton setBackgroundColor:buttonBackgroundColor];
    
    [jyButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    
    jyButton.layer.cornerRadius = cornerRadius;
    
    [jyButton.titleLabel setFont:[UIFont systemFontOfSize:buttonTitleSize]];
    
    jyButton.clickJYButtonBlock = clickJYButtonBlock;
    
    [jyButton addTarget:jyButton action:@selector(clickJYButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return jyButton;
    
}

- (void)clickJYButton:(UIButton *)sender {
    _clickJYButtonBlock(sender);
}

@end
