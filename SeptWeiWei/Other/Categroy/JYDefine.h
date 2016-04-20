//
//  JYDefine.h
//  SeptWeiWei
//
//  Created by Sept on 16/4/20.
//  Copyright © 2016年 九月. All rights reserved.
//

#ifndef JYDefine_h
#define JYDefine_h

#ifdef DEBUG // 调试状态, 打开LOG功能
#define JYLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define JYLog(...)
#endif

// 颜色设置
#define setColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define JYRandomColor UIColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 字体大小设置
#define setFont(r) [UIFont systemFontOfSize:(r)]
#define setBoldFont(r) [UIFont boldSystemFontOfSize:(r)]

// 背景主颜色
#define MainBackgroundColor setColor(95, 226, 241)

// 屏幕宽高
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height


#endif /* JYDefine_h */
