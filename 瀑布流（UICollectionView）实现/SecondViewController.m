//
//  SecondViewController.m
//  瀑布流（UICollectionView）实现
//
//  Created by James on 16/3/17.
//  Copyright © 2016年 James. All rights reserved.
//

#import "SecondViewController.h"
#import "JYButton.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    JYButton *backBtn = [JYButton buttonWithType:UIButtonTypeCustom Frame:CGRectMake(JYWindowsWidth/2 - 75, JYWindowsHeight - 90, 150, 50) ButtonTitle:@"返回上一页" ButtonBackgroundColor:[UIColor orangeColor] ButtonTitleColor:[UIColor whiteColor] CornerRadius:5.0 ButtonTitleSize:17 andClickJYButtonBlock:^(UIButton *sender) {
       
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    

    UIImageView *huoyingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(JYWindowsWidth/2-_huoyingImage.size.width/2, 0, _huoyingImage.size.width, _huoyingImage.size.height)];
    
    [huoyingImageView setImage:_huoyingImage];
    
    [self.view addSubview:huoyingImageView];
    
    [self.view addSubview:backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
