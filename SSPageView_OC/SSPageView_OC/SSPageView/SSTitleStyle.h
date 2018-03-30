//
//  SSTitleStyle.h
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface SSTitleStyle : NSObject
/// 是否是滚动的Title
@property (assign, nonatomic) BOOL isScrollEnable;
/// 普通Title颜色
@property (strong, nonatomic) UIColor *normalColor;
/// 选中Title颜色
@property (strong, nonatomic) UIColor *selectedColor;

/// Title字体大小
@property (strong, nonatomic) UIFont *font;
/// 滚动Title的字体间距
@property (assign, nonatomic) CGFloat titleMargin;


/// 是否显示底部滚动条
@property (assign, nonatomic) BOOL isShowBottomLine;

/// 底部滚动条的颜色
@property (strong, nonatomic) UIColor *bottomLineColor;

/// 底部滚动条的高度
@property (assign, nonatomic) CGFloat bottomLineH;


/// 是否进行缩放
@property (assign, nonatomic) BOOL isNeedScale;
///缩放比例
@property (assign, nonatomic) CGFloat scaleRange;

/// 是否显示遮盖
@property (assign, nonatomic) BOOL isShowCover;

/// 遮盖背景颜色
@property (strong, nonatomic) UIColor *coverBgColor;


/// 文字&遮盖间隙
@property (assign, nonatomic) CGFloat coverMargin;

/// 遮盖的高度
@property (assign, nonatomic) CGFloat coverH;
///  设置圆角大小
@property (assign, nonatomic) CGFloat coverRadius;
-(void)setBaseData;

@end
