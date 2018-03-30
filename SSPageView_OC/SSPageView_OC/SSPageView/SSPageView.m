//
//  SSPageView.m
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import "SSPageView.h"
@interface SSPageView ()<SSTitleViewwDelegate,SSContentViewDelegate>

@end

@implementation SSPageView
- (id)initWithframe:(CGRect)frame titles :(NSArray*)titles style : (SSTitleStyle *)style childVcs:(NSArray *)childVcs parentVc :(UIViewController*)parentVc{
    if (self = [super initWithFrame:frame])
    {
        self.style = style;
        self.titles = titles;
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        parentVc.automaticallyAdjustsScrollViewInsets = false;
        
        [self setupUI];

    }
    
    return self;
}
-(void)setupUI{
    CGFloat titleH =44;
    CGRect  titleFrame =CGRectMake(0, 0, self.frame.size.width, titleH);
    SSTitleView* titleView = [[SSTitleView alloc] initWithframe:titleFrame titles:self.titles style:self.style];
    titleView.delegate = self;
    [self addSubview:titleView];
    self.titleView=titleView;
    
    
    CGRect contentFrame = CGRectMake(0, titleH, self.frame.size.width, self.frame.size.height-titleH);
    SSContentView* contentView = [[SSContentView alloc] initWithframe:contentFrame childVcs:self.childVcs parentVc:self.parentVc];
    self.contentView=contentView;
 
    contentView.delegate = self;
      [self addSubview:contentView];
}
-(void)titleView:(SSTitleView*)titleView selectedIndex:(NSInteger)index;{
    [self.contentView setCurrentIndex:index];
}
-(void)contentView:(SSContentView*)contentView  progress:(CGFloat)progress sourceIndex : (NSInteger)sourceIndex targetIndex :(NSInteger)targetIndex{
    [self.titleView setTitleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}
-(void)contentViewEndScroll:(SSContentView*)contentView{
    [self.titleView contentViewDidEndScroll];
}
@end
