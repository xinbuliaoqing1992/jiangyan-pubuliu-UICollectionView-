//
//  JYButton.h
//  代理，通知，单例，通知反向传值练习。
//
//  Created by 新不了情1992 on 16/2/25.
//  Copyright © 2016年 新不了情1992. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickJYButtonBlock)(UIButton *sender);

@interface JYButton : UIButton


+ (JYButton *)buttonWithType:(UIButtonType)type Frame:(CGRect)frame ButtonTitle:(NSString *)buttonTitle ButtonBackgroundColor:(UIColor *)buttonBackgroundColor ButtonTitleColor:(UIColor *)buttonTitleColor CornerRadius:(double)cornerRadius ButtonTitleSize:(NSInteger)buttonTitleSize andClickJYButtonBlock:(ClickJYButtonBlock)clickJYButtonBlock;

@end
