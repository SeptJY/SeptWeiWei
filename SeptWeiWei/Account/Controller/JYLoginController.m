//
//  JYLoginController.m
//  SeptWeiWei
//
//  Created by Sept on 16/4/19.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYLoginController.h"
#import "JYBackgroundView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "JYSignUpController.h"
#import <TencentOpenAPI/TencentOAuth.h>

#define kRotationDuration 4.0
#define rotationViewWidth (screenW - 40)

@interface JYLoginController () <TencentSessionDelegate>
{
    TencentOAuth *tencentOAuth;
}

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

@property (strong, nonatomic) UIImageView *bgView;
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
    
    [self.imageView addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.bgView];
    [self.view addSubview:self.rotationView];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.weixinBtn];
    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.sinaBtn];
    [self.view addSubview:self.othersLabel];
    [self.view addSubview:self.leftLine];
    [self.view addSubview:self.rightLine];
    [self.view addSubview:self.forgetPwdBtn];
    [self.view addSubview:self.signUpBtn];
    [self.bgView addSubview:self.pwdText];
    [self.bgView addSubview:self.centerView];
    [self.bgView addSubview:self.userImgView];
    [self.bgView addSubview:self.pwdImgView];
    [self.bgView addSubview:self.userText];
 
    [self setupConstraints];
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
        
        
     }
    return _backgroundView;
}

- (UIImageView *)rotationView
{
    if (!_rotationView) {
        
        _rotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_rotation_icon"]];
        
        _rotationView.userInteractionEnabled = YES;
    }
    return _rotationView;
}

/** 背景图片 */
- (UIImageView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg_icon"]];
        
        _imageView.userInteractionEnabled = YES;
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
    }
    return _othersLabel;
}

- (UIView *)leftLine
{
    if (!_leftLine) {
        
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = MainBackgroundColor;
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

- (UIImageView *)bgView
{
    if (!_bgView) {
        
        _bgView = [[UIImageView alloc] init];
        
        _bgView.image = [UIImage imageNamed:@"login_small_bg_view"];
    }
    return _bgView;
}

- (UIView *)centerView
{
    if (!_centerView)
    {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor grayColor];
    }
    return _centerView;
}

- (UIImageView *)userImgView
{
    if (!_userImgView) {
        _userImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_landing_nickname"]];
    }
    return _userImgView;
}

- (UIImageView *)pwdImgView
{
    if (!_pwdImgView) {
        _pwdImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mm_normal"]];
    }
    return _pwdImgView;
}

- (UITextField *)userText
{
    if (!_userText) {
        _userText = [[UITextField alloc] init];
        
        _userText.placeholder = @"UserName";
        _userText.textColor = [UIColor blackColor];
    }
    return _userText;
}

- (UITextField *)pwdText
{
    if (!_pwdText) {
        _pwdText = [[UITextField alloc] init];
        
        _pwdText.placeholder = @"PassWord";
        _pwdText.textColor = [UIColor blackColor];
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
//    JYLog(@"登录");
    
}

#pragma mark -------------------------> 代理
#pragma mark -- TencentSessionDelegate
//登陆完成调用
- (void)tencentDidLogin
{
//    resultLable.text = @"登录完成";
    JYLog(@"登录完成");
    
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
//        tokenLable.text = tencentOAuth.accessToken;
        [tencentOAuth getUserInfo];
    }
    else
    {
//        tokenLable.text = @"登录不成功 没有获取accesstoken";
        JYLog(@"登录不成功 没有获取accesstoken");
    }
}

//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
//        resultLable.text = @"用户取消登录";
        JYLog(@"用户取消登录");
    }else{
//        resultLable.text = @"登录失败";
        JYLog(@"登录失败");
    }
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
//    resultLable.text = @"无网络连接，请设置网络";
    JYLog(@"无网络连接，请设置网络");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"respons:%@",response.jsonResponse);
}

- (void)otherLoginBtnOnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 10:
            JYLog(@"微信登录");
            break;
        case 11:
        {
            tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"1105198010"andDelegate:self];
            //4，设置需要的权限列表，此处尽量使用什么取什么。
            NSArray *permissions= [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
            [tencentOAuth authorize:permissions inSafari:NO];
        }
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
    
    return btn;
}

- (void)setupConstraints
{
    __weak JYLoginController *weakSelf = self;
    // 图片背景
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.leading.equalTo(weakSelf.view);
        make.trailing.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
    
    // 自定义画图的背景view
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(rotationViewWidth, rotationViewWidth * 9/ 14));
    }];
    
    // 旋转的图片
    [self.rotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(rotationViewWidth * 5 / 14 - 10, rotationViewWidth * 5 / 14 - 10));
        make.top.equalTo(weakSelf.view).offset(100 - (rotationViewWidth * 5 / 14 - 10) * 0.5);
    }];
    
    // 输入框的背景view
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.backgroundView).offset(-20);
        make.leading.equalTo(weakSelf.backgroundView).offset(20);
        make.trailing.equalTo(weakSelf.backgroundView).offset(-20);
        make.top.mas_equalTo(weakSelf.rotationView.mas_bottom).offset(30);
    }];
    
    // 背景view的中心线
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
        make.leading.equalTo(weakSelf.bgView).offset(10);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(weakSelf.bgView);
    }];
    
    // 用户名的图标
    [self.userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(10);
        make.centerY.mas_equalTo(weakSelf.userText);
        make.size.mas_equalTo(CGSizeMake(22.0, 22.0));
    }];
    
    // 用户名的输入框
    [self.userText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.centerView.mas_top).offset(5);
        make.top.equalTo(weakSelf.bgView).offset(5);
        make.trailing.equalTo(weakSelf.bgView).offset(-5);
        make.left.mas_equalTo(weakSelf.userImgView.mas_right).offset(5);
    }];
    
    // 密码的图标
    [self.pwdImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(7);
        make.centerY.mas_equalTo(weakSelf.pwdText);
        make.size.mas_equalTo(CGSizeMake(28.0, 28.0));
    }];
    
    // 密码的输入框
    [self.pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bgView).offset(-5);
        make.top.equalTo(weakSelf.centerView.mas_bottom).offset(5);
        make.trailing.equalTo(weakSelf.userText);
        make.left.mas_equalTo(weakSelf.pwdImgView.mas_right).offset(5);
    }];
    
    // 登录按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.backgroundView.mas_bottom).offset(25);
        make.height.mas_equalTo(40);
        make.leading.equalTo(weakSelf.view).offset(20);
        make.trailing.equalTo(weakSelf.view).offset(-20);
    }];
    
    // 忘记密码
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.loginBtn);
        make.top.mas_equalTo(weakSelf.loginBtn.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    // 注册按钮
    [self.signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(weakSelf.loginBtn);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.top.mas_equalTo(weakSelf.forgetPwdBtn);
    }];
    
    // qq登录
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view).offset(50);
        make.bottom.equalTo(weakSelf.view).offset(-20);
        make.width.mas_equalTo(weakSelf.qqBtn.mas_height);
    }];
    
    // 微信登录
    [self.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.qqBtn.mas_right).offset(60);
        make.right.mas_equalTo(weakSelf.sinaBtn.mas_left).offset(-60);
        make.height.bottom.width.mas_equalTo(weakSelf.qqBtn);
    }];
    
    // 新浪登录
    [self.sinaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.view).offset(-50);
        make.width.height.bottom.mas_equalTo(weakSelf.qqBtn);
    }];
    
    // 第三方label
    [self.othersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.weixinBtn.mas_top).offset(-10);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    // lable 左边的线
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view).offset(20);
        make.right.mas_equalTo(weakSelf.othersLabel.mas_left).offset(-20);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(weakSelf.othersLabel);
    }];
    
    // lable 左边的线
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.view).offset(20);
        make.left.mas_equalTo(weakSelf.othersLabel.mas_right).offset(20);
        make.height.centerY.mas_equalTo(weakSelf.leftLine);
    }];
}

/**
- (void)viewWillLayoutSubviews
{
    self.imageView.frame = self.view.bounds;
    
    self.backgroundView.frame = CGRectMake(20, 150, rotationViewWidth, rotationViewWidth * 9 / 14);
    
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
*/

@end
