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

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "JYSignUpController.h"

#define kRotationDuration 4.0

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
@property (strong, nonatomic) UIButton *forgetPwdBtn;
@property (strong, nonatomic) UIButton *signUpBtn;

//转圈速度
@property (assign, nonatomic) float rotationDuration;

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIView *centerView;


@property (strong, nonatomic) UIImageView *userImgView;
@property (strong, nonatomic) UIImageView *pwdImgView;

@property (strong, nonatomic) UITextField *userText;
@property (strong, nonatomic) UITextField *pwdText;

@end

@implementation JYLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initRound];
    [self startRotation];
}

- (void)initRound
{
    //Rotation
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    
    //default RotationDuration value
    if (self.rotationDuration == 0) {
        self.rotationDuration = kRotationDuration;
    }
    
    rotationAnimation.duration = self.rotationDuration;
    rotationAnimation.repeatCount = FLT_MAX;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO; //No Remove
    [self.rotationView.layer addAnimation:rotationAnimation forKey:@"rotation"];
}

- (void)startRotation
{
    self.view.layer.speed = 1.0;
    self.view.layer.beginTime = 0.0;
    CFTimeInterval pausedTime = [self.view.layer timeOffset];
    CFTimeInterval timeSincePause = [self.view.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.view.layer.beginTime = timeSincePause;
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
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_nolmal_icon"] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_seletect_icon"] forState:UIControlStateHighlighted];
        [_loginBtn setTitleColor:MainBackgroundColor forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_loginBtn addTarget:self action:@selector(loginBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (UIButton *)forgetPwdBtn
{
    if (!_forgetPwdBtn) {
        
        _forgetPwdBtn = [self createBtnWithTitle:@"忘记密码?"];
        _forgetPwdBtn.tag = 13;
    }
    return _forgetPwdBtn;
}

- (UIButton *)signUpBtn
{
    if (!_signUpBtn) {
        
        _signUpBtn = [self createBtnWithTitle:@"快速注册"];
        _signUpBtn.tag = 14;
    }
    return _signUpBtn;
}

- (UIView *)bgView
{
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        
        _bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        
        [self.backgroundView addSubview:_bgView];
    }
    return _bgView;
}

- (UIView *)centerView
{
    if (!_centerView)
    {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor grayColor];
        
        [self.bgView addSubview:_centerView];
    }
    return _centerView;
}

- (UIImageView *)userImgView
{
    if (!_userImgView) {
        _userImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_landing_nickname"]];
        [self.bgView addSubview:_userImgView];
    }
    return _userImgView;
}

- (UIImageView *)pwdImgView
{
    if (!_pwdImgView) {
        _pwdImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mm_normal"]];
        [self.bgView addSubview:_pwdImgView];
    }
    return _pwdImgView;
}

- (UITextField *)userText
{
    if (!_userText) {
        _userText = [[UITextField alloc] init];
        
        _userText.placeholder = @"UserName";
        _userText.textColor = [UIColor blackColor];
        
        [self.bgView addSubview:_userText];
    }
    return _userText;
}

- (UITextField *)pwdText
{
    if (!_pwdText) {
        _pwdText = [[UITextField alloc] init];
        
        _pwdText.placeholder = @"PassWord";
        _pwdText.textColor = [UIColor blackColor];
        
        [self.bgView addSubview:_pwdText];
    }
    return _pwdText;
}

- (void)forgetPwdBtnAndSignUpBtnOnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 13:
            NSLog(@"%@", btn.currentTitle);
            break;
        case 14:
            [self.navigationController pushViewController:[[JYSignUpController alloc] init] animated:YES];
            break;
    }
}

- (void)loginBtnOnClick
{
    JYLog(@"登录");
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

- (UIButton *)createBtnWithTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setTitleColor:setColor(176, 187, 220) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = setFont(14);
    
    [btn addTarget:self action:@selector(forgetPwdBtnAndSignUpBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    return btn;
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
    
    self.forgetPwdBtn.frame = CGRectMake(20, self.loginBtn.y + self.loginBtn.height, 70, 30);
    
    self.signUpBtn.frame = CGRectMake(screenW - 70 - 20, self.forgetPwdBtn.y, 70, 30);
    
    self.bgView.frame = CGRectMake(10, rotationW * 0.5 + 25, self.backgroundView.width - 20, self.backgroundView.height - (rotationW * 0.5 + 15) - 25);
    
    self.centerView.frame = CGRectMake(15, (self.bgView.height - 1) * 0.5, self.bgView.width - 30, 1);
    
    CGFloat imgH = self.centerView.y - 16;
    
    self.userImgView.frame = CGRectMake(15, 8, imgH, imgH);
    self.pwdImgView.frame = CGRectMake(15, self.centerView.y + 8, imgH, imgH);
    
    self.userText.frame = CGRectMake(self.userImgView.x + self.userImgView.width + 8, 8, self.bgView.width - (self.userImgView.x + self.userImgView.width + 8) - 15, imgH);
    
    self.pwdText.frame = CGRectMake(self.userImgView.x + self.userImgView.width + 8, self.pwdImgView.y, self.bgView.width - (self.userImgView.x + self.userImgView.width + 8) - 15, imgH);
}

@end
