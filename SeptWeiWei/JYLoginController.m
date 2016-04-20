//
//  JYLoginController.m
//  SeptWeiWei
//
//  Created by Sept on 16/4/19.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYLoginController.h"
#import "JYSubView.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface JYLoginController ()

@property (strong, nonatomic) JYSubView *subView;

@end

@implementation JYLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (JYSubView *)subView
{
    if (!_subView) {
        
        _subView = [[JYSubView alloc] init];
        
        [self.view addSubview:_subView];
     }
    return _subView;
}

- (void)viewWillLayoutSubviews
{
    self.subView.frame = CGRectMake(20, 0, screenW - 40, (screenW - 40) * 9 / 14);
}

@end
