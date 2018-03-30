//
//  SSTitleView.h
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTitleStyle.h"
#import "UIView+SSExtension.h"
@class SSTitleView;
@protocol SSTitleViewwDelegate <NSObject>
@optional
-(void)titleView:(SSTitleView*)titleView selectedIndex:(NSInteger)index;

@end

@interface SSTitleView : UIView
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) SSTitleStyle *style;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) NSMutableArray *titleLabels;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *splitLineView;
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UIView *coverView;
@property (strong, nonatomic)UIColor* normalColorRGB;
@property (strong, nonatomic)UIColor* selectedColorRGB;
@property (nonatomic,weak)id<SSTitleViewwDelegate> delegate;
- (id)initWithframe:(CGRect)frame titles :(NSArray*)titles style : (SSTitleStyle *)style ;
-(void)setTitleWithProgress:(CGFloat)progress  sourceIndex :(NSInteger)sourceIndex targetIndex :(NSInteger)targetIndex;
-(void)contentViewDidEndScroll;
@end
