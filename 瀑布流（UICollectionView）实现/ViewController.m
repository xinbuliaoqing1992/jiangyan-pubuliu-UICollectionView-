//
//  ViewController.m
//  瀑布流（UICollectionView）实现
//
//  Created by James on 16/3/16.
//  Copyright © 2016年 James. All rights reserved.
//

#import "ViewController.h"
#import "JYFlowLayout.h"
#import "JYCollectionViewCell.h"
#import "SecondViewController.h"
#import "JYButton.h"
#import "MBProgressHUD.h"

//本地一共有17张图片
int _imageCount = 22;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JYFlowLayoutDelegate, UITextFieldDelegate>

//存放图片的数组
@property (strong, nonatomic) NSMutableArray *imageDataArr;

//存放图片高度的数组
@property (strong, nonatomic) NSMutableArray *imageHeightArr;

//列数
@property (assign, nonatomic) NSInteger columnCount;

//items之间的间隙
@property (assign, nonatomic) CGFloat itemsSpace;

//UICollectionView的间隙
@property (assign, nonatomic) UIEdgeInsets cvEdgeInsets;

//UICollectionView
@property (strong, nonatomic) UICollectionView *jyCollectionView;

//提示框
@property (strong, nonatomic) UIView *alertView;

//输入框
@property (strong, nonatomic) UITextField *numberTextField;

//提示Label
@property (strong, nonatomic) UILabel *alertLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化AlertView
    [self initAlertView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

//初始化AlertView
- (void)initAlertView {
    
    //初始化提醒文字
    _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(JYWindowsWidth/2-100, 50, 200, 30)];
    
    _alertLabel.text = @"欢迎使用姜岩瀑布流，哈哈";
    
    [_alertLabel setFont:[UIFont systemFontOfSize:15]];
    
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    
    _alertLabel.textColor = [UIColor brownColor];
    
    [self.view addSubview:_alertLabel];
    
    
    //初始化提醒框
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(JYWindowsWidth/2-100, JYWindowsHeight, 200, JYWindowsHeight-80)];
    
    _alertView.layer.cornerRadius = 10.0;
    _alertView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_alertView];
    
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:optind animations:^{
        
        _alertView.frame = CGRectMake(JYWindowsWidth/2-110, JYWindowsHeight/2-(JYWindowsHeight/2)/2, 220, JYWindowsHeight/2);
        
    } completion:^(BOOL finished) {
      
    }];
    
    //初始化输入框
    _numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, _alertView.frame.size.width-20, 50)];
    
    _numberTextField.backgroundColor = [UIColor whiteColor];
    _numberTextField.layer.cornerRadius = 5.0;
    _numberTextField.delegate = self;
    _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_numberTextField setFont:[UIFont systemFontOfSize:10.5]];
    _numberTextField.placeholder = @"请输入列数, 尽量小于5，不然图片会很小";
    [_alertView addSubview:_numberTextField];
    
    //初始化确认按钮
    JYButton *currentBtn = [JYButton buttonWithType:UIButtonTypeCustom Frame:CGRectMake(_alertView.frame.size.width/2-30, CGRectGetMaxY(_numberTextField.frame)+25, 60, 30) ButtonTitle:@"确认" ButtonBackgroundColor:[UIColor greenColor] ButtonTitleColor:[UIColor whiteColor] CornerRadius:5.0 ButtonTitleSize:15 andClickJYButtonBlock:^(UIButton *sender) {
        
        if ([_numberTextField.text length] != 0) {
            
            [_numberTextField resignFirstResponder];
            
            //自定义列数
            _columnCount = [_numberTextField.text integerValue];
            
            //初始化UI
            [self initUI];
            
            //初始化数据
            [self initData];
            
        } else {
            
            [self showMBProgressHUD:@"请输入列数"];
            
        }

    }];
    
    [_alertView addSubview:currentBtn];
    
  }

//显示缺省提示
- (void)showMBProgressHUD:(NSString *)showText {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = showText;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:1];
}


//初始化各项数据
- (void)initData {
    
    _imageDataArr = [NSMutableArray array];
    
    _imageHeightArr = [NSMutableArray array];
    
    for (int i = 0; i < _imageCount; i++) {
        
        UIImage *huoyingImage = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d", i]];
        
        [_imageDataArr addObject:huoyingImage];
        
        //按比例求出图片的高度（图片宽度自定：屏幕宽除以列数减去空隙即是自定的宽，列数自定）
        CGFloat huoyingImageHeight = (JYWindowsWidth/_columnCount -  _itemsSpace - _itemsSpace - _cvEdgeInsets.left) * huoyingImage.size.height/huoyingImage.size.width;
        
        NSNumber *huoyingNumber = [NSNumber numberWithFloat:huoyingImageHeight];
        
        [_imageHeightArr addObject:huoyingNumber];
    }
    
    [_jyCollectionView reloadData];
}


- (void)initUI {
    
    //自定义图片间的空隙
    _itemsSpace = 5;
    
    //自定义UICollectionView的空隙
    _cvEdgeInsets = UIEdgeInsetsMake(20, 5, 5, 5);
    
    //自定义布局
    JYFlowLayout *jyFlowLayout = [[JYFlowLayout alloc] init];
    
    jyFlowLayout.columnCount = _columnCount;
    jyFlowLayout.itemsSpace = _itemsSpace;
    jyFlowLayout.cvEdgeInsets = _cvEdgeInsets;
    jyFlowLayout.delegate = self;
    

    //创建CollectionView
    _jyCollectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout: jyFlowLayout];
    
    _jyCollectionView.delegate = self;
    _jyCollectionView.dataSource = self;
    
    _jyCollectionView.backgroundColor = [UIColor whiteColor];
    
    [_jyCollectionView registerClass:[JYCollectionViewCell class] forCellWithReuseIdentifier:@"ident"];
    
    [self.view addSubview:_jyCollectionView];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //输入时对缺省文字的处理
    if ([textField.text length] >= 1 || [string integerValue] == 0 || [string integerValue] > 5) {
        
        if ([string integerValue] == 0) {
            [self showMBProgressHUD:@"不可以输入0"];
        } else if ([string integerValue] > 5) {
            [self showMBProgressHUD:@"列数需小于5"];

        }
        
        return NO;
    }
    
    return YES;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _imageDataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYCollectionViewCell *cell = [JYCollectionViewCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    
    [cell.JYImageView setImage:_imageDataArr[indexPath.row]];
    
    return cell;
}


- (CGFloat)itemsHeightLayout:(JYFlowLayout *)Layout andIndexPath:(NSIndexPath *)IndexPath {
    
    if (_imageHeightArr[IndexPath.row] != 0) {
        return [_imageHeightArr[IndexPath.row] floatValue];
    } else {
        return 270;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondViewController *sc = [[SecondViewController alloc] init];
    
    sc.huoyingImage = _imageDataArr[indexPath.row];
    
    [self presentViewController:sc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
