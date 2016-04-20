//
//  JYSubView.m
//  SeptWeiWei
//
//  Created by Sept on 16/4/19.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYSubView.h"

#define W self.frame.size.width
#define H self.frame.size.height

@implementation JYSubView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //1.获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGPoint aPoints1[2];//坐标点
    aPoints1[0] =CGPointMake(1, 1);//坐标1
    aPoints1[1] =CGPointMake(1, H);//坐标2
    CGContextAddLines(ctx, aPoints1, 2);//添加线
    
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    // 底部长线
    CGPoint aPoints2[2];//坐标点
    aPoints2[0] =CGPointMake(1, H);//坐标1
    aPoints2[1] =CGPointMake(W, H);//坐标2
    CGContextAddLines(ctx, aPoints2, 2);//添加线
    
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    // 右边竖线
    CGPoint aPoints3[2];//坐标点
    aPoints3[0] =CGPointMake(W, 0);//坐标1
    aPoints3[1] =CGPointMake(W, H);//坐标2
    CGContextAddLines(ctx, aPoints3, 2);//添加线
    
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    // 左边横线
    CGPoint aPoints4[2];//坐标点
    aPoints4[0] =CGPointMake(0, 1);//坐标1
    aPoints4[1] =CGPointMake( (W - (W * 5 / 14 - 10)) / 2, 0);//坐标2
    CGContextAddLines(ctx, aPoints4, 2);//添加线
    
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
}

@end
