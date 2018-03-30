//
//  UIView+SSExtension.m
//  ComplaintReporting
//
//  Created by 点创科技 on 17/5/18.
//  Copyright © 2017年 点创科技. All rights reserved.
//

#import "UIView+SSExtension.h"

@implementation UIView (SSExtension)
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
  
}
-(void)clipsToBoundsWith:(UIView*)myView byRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:myView.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = myView.bounds;
 
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    
    myView.layer.mask = maskLayer;
    
}
-(void)setMyGradientColorWithStarColor:(UIColor*)starColor endColor:(UIColor*)endColor{
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:
                              (__bridge id)starColor.CGColor,
                              (__bridge id)endColor.CGColor,
                              nil]];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [self.layer addSublayer:gradientLayer];
    
    
}
#pragma mark -画线

-(void)drawLineWith:(UIView*)myView startPiont:(CGPoint)startPiont endPiont:(CGPoint)endPiont  lineWidth:(CGFloat)lineWidth strokeColor:(UIColor*)strokeColor lineDashPattern:(NSArray *)lineDashPattern{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:startPiont];
    // 其他点
    [linePath addLineToPoint:endPiont];
    
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
    lineLayer.lineWidth = lineWidth;
    lineLayer.strokeColor = strokeColor.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.lineDashPattern=lineDashPattern;
    lineLayer.fillColor = nil; // 默认为blackColor
    
    [myView.layer addSublayer:lineLayer];
    
}
+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end
