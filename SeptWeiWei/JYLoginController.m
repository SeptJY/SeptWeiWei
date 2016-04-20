//
//  JYLoginController.m
//  SeptWeiWei
//
//  Created by Sept on 16/4/19.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYLoginController.h"
#import "JYBackgroundView.h"
#import "JYDefine.h"
#import "UIView+Extension.h"
#import "JYNSString+Extension.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface JYLoginController ()

@property (strong, nonatomic) JYBackgroundView *backgroundView;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIImageView *rotationView;

@property (strong, nonatomic) UIButton *weixinBtn;
@property (strong, nonatomic) UIButton *qqBtn;
@property (strong, nonatomic) UIButton *sinaBtn;

@property (strong, nonatomic) UILabel *othersLabel;
@property (strong, nonatomic) UIView *leftLine;
@property (strong, nonatomic) UIView *rightLine;

@property (strong, nonatomic) UIButton *loginBtn;

@end

@implementation JYLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (JYBackgroundView *)backgroundView
{
    if (!_backgroundView) {
        
        _backgroundView = [[JYBackgroundView alloc] init];
        
        [self.imageView addSubview:_backgroundView];
     }
    return _backgroundView;
}

- (UIImageView *)rotationView
{
    if (!_rotationView) {
        
        _rotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_rotation_icon"]];
        
        _rotationView.userInteractionEnabled = YES;
        
        [self.view addSubview:_rotationView];
    }
    return _rotationView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg_icon"]];
        
        _imageView.userInteractionEnabled = YES;
        
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)weixinBtn
{
    if (!_weixinBtn) {
        
        _weixinBtn = [[UIButton alloc] init];
        
        [_weixinBtn setImage:[UIImage imageNamed:@"ic_landing_wechat"] forState:UIControlStateNormal];
        [_weixinBtn addTarget:self action:@selector(otherLoginBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _weixinBtn.tag = 10;
        
        [self.view addSubview:_weixinBtn];
    }
    return _weixinBtn;
}

- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        
        _qqBtn = [[UIButton alloc] init];
        
        [_qqBtn setImage:[UIImage imageNamed:@"ic_landing_qq"] forState:UIControlStateNormal];
        [_qqBtn addTarget:self action:@selector(otherLoginBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _qqBtn.tag = 11;
        
        [self.view addSubview:_qqBtn];
    }
    return _qqBtn;
}

- (UIButton *)sinaBtn
{
    if (!_sinaBtn) {
        
        _sinaBtn = [[UIButton alloc] init];
        
        [_sinaBtn setImage:[UIImage imageNamed:@"ic_landing_microblog"] forState:UIControlStateNormal];
        [_sinaBtn addTarget:self action:@selector(otherLoginBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _sinaBtn.tag = 12;
        
        [self.view addSubview:_sinaBtn];
    }
    return _sinaBtn;
}

- (UILabel *)othersLabel
{
    if (!_othersLabel) {
        
        _othersLabel = [[UILabel alloc] init];
        
        _othersLabel.text = @"第三方登录";
        _othersLabel.textColor = [UIColor grayColor];
        _othersLabel.font = setFont(12);
        
        [self.view addSubview:_othersLabel];
    }
    return _othersLabel;
}

- (UIView *)leftLine
{
    if (!_leftLine) {
        
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = MainBackgroundColor;
        
        [self.view addSubview:_leftLine];
    }
    return _leftLine;
}

- (UIView *)rightLine
{
    if (!_rightLine) {
        
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = MainBackgroundColor;
        
        [self.view addSubview:_rightLine];
    }
    return _rightLine;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setAdjustsImageWhenHighlighted:NO];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_nolmal_icon"] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_seletect_icon"] forState:UIControlStateSelected];
        [_loginBtn setTitleColor:MainBackgroundColor forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [_loginBtn addTarget:self action:@selector(loginBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (void)loginBtnOnClick
{
    self.loginBtn.selected = !self.loginBtn.selected;
}

- (void)otherLoginBtnOnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 10:
            JYLog(@"微信登录");
            break;
        case 11:
            JYLog(@"QQ登录");
            break;
        case 12:
            JYLog(@"新浪登录");
            break;
    }
}

- (void)viewWillLayoutSubviews
{
    self.imageView.frame = self.view.bounds;
    
    self.backgroundView.frame = CGRectMake(20, 150, screenW - 40, (screenW - 40) * 9 / 14);
    
    CGFloat rotationW = self.backgroundView.width * 5 / 14 - 10;
    CGFloat rotationH = rotationW;
    self.rotationView.frame = CGRectMake((screenW - rotationW) * 0.5, self.backgroundView.y - rotationW * 0.5, rotationW, rotationH);
    
    CGFloat btnW = (screenW - 2 * 70 - 2 * 50) / 3;
    CGFloat btnH = btnW;
    
    self.weixinBtn.frame = CGRectMake(70, screenH - 15 - btnW, btnW, btnH);
    self.qqBtn.frame = CGRectMake(70 + 50 + btnW, screenH - 15 - btnW, btnW, btnH);
    self.sinaBtn.frame = CGRectMake(70 + 50 * 2 + btnW * 2, screenH - 15 - btnW, btnW, btnH);
    
    CGSize labelSize = [NSString sizeWithText:self.othersLabel.text font:self.othersLabel.font maxSize:CGSizeMake(screenW, 50)];
    
    self.othersLabel.frame = CGRectMake((screenW - labelSize.width) * 0.5, self.weixinBtn.y - 10 - labelSize.height, labelSize.width, labelSize.height);
    
    self.leftLine.frame = CGRectMake(20, self.othersLabel.y + ((self.othersLabel.height - 1) * 0.5), self.othersLabel.x - 30, 1);
    
    self.rightLine.frame = CGRectMake(self.othersLabel.x + self.othersLabel.width + 10, self.othersLabel.y + ((self.othersLabel.height - 1) * 0.5), self.othersLabel.x - 30, 1);
    
    self.loginBtn.frame = CGRectMake(20, self.backgroundView.y + self.backgroundView.height + 30, screenW - 40, 35);
}

@end
