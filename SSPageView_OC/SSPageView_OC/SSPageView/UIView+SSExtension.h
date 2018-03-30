//
//  UIView+SSExtension.h
//  ComplaintReporting
//
//  Created by 点创科技 on 17/5/18.
//  Copyright © 2017年 点创科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SSExtension)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;
///到圆角
-(void)clipsToBoundsWith:(UIView*)myView byRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius;
///添加渐变色
-(void)setMyGradientColorWithStarColor:(UIColor*)starColor endColor:(UIColor*)endColor;

///画线
-(void)drawLineWith:(UIView*)myView startPiont:(CGPoint)startPiont endPiont:(CGPoint)endPiont  lineWidth:(CGFloat)lineWidth strokeColor:(UIColor*)strokeColor lineDashPattern:(NSArray *)lineDashPattern;
+ (instancetype)viewFromXib;
@end
