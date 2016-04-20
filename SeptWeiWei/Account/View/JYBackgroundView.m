//
//  JYSubView.m
//  SeptWeiWei
//
//  Created by Sept on 16/4/19.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYBackgroundView.h"
#import "JYDefine.h"

#define W self.frame.size.width
#define H self.frame.size.height

@implementation JYBackgroundView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.backgroundColor = [setColor(216, 216, 216) colorWithAlphaComponent:0.5];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
//    CGContextSetRGBStrokeColor(ctx, 95, 226, 241, 1.0);//画笔线的颜色
    CGContextSetStrokeColorWithColor(ctx, MainBackgroundColor.CGColor);//线框颜色
    
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
    aPoints3[0] =CGPointMake(W, H);//坐标1
    aPoints3[1] =CGPointMake(W, 1);//坐标2
    CGContextAddLines(ctx, aPoints3, 2);//添加线
    
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    // 右边横线
    CGPoint aPoints5[2];//坐标点
    aPoints5[0] =CGPointMake(W, 1);//坐标1
    aPoints5[1] =CGPointMake( (W - W * 5 / 14) / 2 + W * 5 / 14 - 0.5, 1);//坐标2
    CGContextAddLines(ctx, aPoints5, 2);//添加线
    
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    //画下半圆弧
    CGFloat bottomRadius = W * 5 / 14 / 2;
    CGFloat bottomX = W * 0.5;
    CGFloat bottomY = 1;
    CGContextAddArc(ctx, bottomX, bottomY, bottomRadius, 0, M_PI, 0);
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    // 左边横线
    CGPoint aPoints4[2];//坐标点
    aPoints4[0] =CGPointMake(1, 1);//坐标1
    aPoints4[1] =CGPointMake( (W - W * 5 / 14) / 2, 1);//坐标2
    CGContextAddLines(ctx, aPoints4, 2);//添加线
    
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
}

@end
