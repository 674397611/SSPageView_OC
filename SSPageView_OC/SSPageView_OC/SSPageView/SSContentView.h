//
//  SSContentView.h
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SSExtension.h"
@class SSContentView;
@protocol SSContentViewDelegate <NSObject>
@optional
-(void)contentView:(SSContentView*)contentView  progress:(CGFloat)progress sourceIndex : (NSInteger)sourceIndex targetIndex :(NSInteger)targetIndex;
-(void)contentViewEndScroll:(SSContentView*)contentView;
@end
@interface SSContentView : UIView
@property (strong, nonatomic) NSArray *childVcs;
@property (strong, nonatomic) UIViewController *parentVc;
@property (assign, nonatomic) BOOL isForbidScrollDelegate;
@property (assign, nonatomic) CGFloat startOffsetX;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,weak)id<SSContentViewDelegate> delegate;
- (id)initWithframe:(CGRect)frame childVcs:(NSArray *)childVcs parentVc :(UIViewController*)parentVc;

-(void)setCurrentIndex:(NSInteger)currentIndex;
@end
