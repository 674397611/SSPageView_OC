//
//  SSPageView.h
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTitleStyle.h"
#import "SSTitleView.h"
#import "SSContentView.h"

@interface SSPageView : UIView
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) SSTitleStyle *style;
@property (strong, nonatomic) NSArray *childVcs;
@property (strong, nonatomic) UIViewController *parentVc;

@property (strong, nonatomic) SSTitleView *titleView;
@property (strong, nonatomic) SSContentView *contentView;
- (id)initWithframe:(CGRect)frame titles :(NSArray*)titles style : (SSTitleStyle *)style childVcs:(NSArray *)childVcs parentVc :(UIViewController*)parentVc;
@end
