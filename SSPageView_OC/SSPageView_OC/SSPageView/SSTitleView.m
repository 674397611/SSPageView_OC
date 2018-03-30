//
//  SSTitleView.m
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import "SSTitleView.h"

@implementation SSTitleView
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView=[UIScrollView new];
        NSLog(@"%f",self.frame.size.width);
        _scrollView.frame = self.bounds;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.scrollsToTop = false;
    }
    return _scrollView;
    
}
-(UIView*)splitLineView{
    if (!_splitLineView) {
        _splitLineView= [UIView new];
        _splitLineView.backgroundColor = [UIColor lightGrayColor];
   
        _splitLineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
    }
    return _splitLineView;
    
}
-(UIView*)bottomLine{
    if (!_bottomLine) {
        _bottomLine= [UIView new];
        _bottomLine.backgroundColor = self.style.bottomLineColor;
    }
    return _bottomLine;
    
}
-(UIView*)coverView{
    if (!_coverView) {
        _coverView= [UIView new];
        _coverView.backgroundColor = self.style.coverBgColor;
        _coverView.alpha = 0.7;
    }
    return _coverView;
    
}

- (id)initWithframe:(CGRect)frame titles :(NSArray*)titles style : (SSTitleStyle *)style{
    if (self = [super initWithFrame:frame])
    {
        self.titles = titles;
        self.style = style;
        self.selectedColorRGB=style.selectedColor;
        self.normalColorRGB=style.normalColor;
        
        [self  setupUI];
        
    }
    
    return self;
}
-(void)setupUI{
    // 1.添加Scrollview
    [self addSubview:self.scrollView];
 
    
    // 2.添加底部分割线
     [self addSubview:self.splitLineView];

    
    // 3.设置所有的标题Label
    [self setupTitleLabels];

    
    // 4.设置Label的位置
     [self setupTitleLabelsPosition];


    // 5.设置底部的滚动条
    if (self.style.isShowBottomLine) {
         [self setupBottomLine];

    }

    // 6.设置遮盖的View
    if (self.style.isShowCover) {
        [self setupCoverView];

    }
   
}
-(void)setupTitleLabels{
    self.titleLabels=[NSMutableArray new];
    for (NSInteger index=0; index<self.titles.count; index++) {
     
        UILabel* label = [UILabel new];
        label.tag = index;
        label.text = self.titles[index];
        label.textColor = index == 0 ? self.style.selectedColor : self.style.normalColor;
        label.font = self.style.font;
        label.textAlignment =NSTextAlignmentCenter;
        
        label.userInteractionEnabled = true;
        UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tapGes];
        [self.titleLabels addObject:label];
    
        
        [self.scrollView addSubview:label];
    }
}





-(void)setupTitleLabelsPosition {
    
    CGFloat titleX = 0.0;
    CGFloat titleW = 0.0;
    CGFloat titleY = 0.0;
    CGFloat titleH  = self.height;
    
    NSInteger count = _titles.count;
    

        for (NSInteger index=0; index<self.titleLabels.count; index++) {
            
            UILabel* label = self.titleLabels[index];
        if(_style.isScrollEnable)  {
          CGRect rect=  [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_style.font} context:nil];
          
            titleW = rect.size.width;
            if (index == 0 ){
                titleX = _style.titleMargin * 0.5;
            } else {
                UILabel *preLabel = _titleLabels[index - 1];
                titleX = preLabel.x+preLabel.width + _style.titleMargin;
            }
            
        } else {
            titleW = self.width / (CGFloat)count;
            titleX = titleW * (CGFloat)index;
        }
        
            label.frame = CGRectMake(titleX, titleY, titleW, titleH);
        
        // 放大的代码
        if (index == 0 ){
            CGFloat scale = _style.isNeedScale ? _style.scaleRange : 1.0;
            label.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
    
    if (_style.isScrollEnable ){
       UILabel *lastLab= [_titleLabels lastObject];
        _scrollView.contentSize = CGSizeMake(lastLab.x+lastLab.width + _style.titleMargin * 0.5, 0);
    }
}

-(void)setupBottomLine {
    [_scrollView addSubview:self.bottomLine];
    UILabel *firetLab= [_titleLabels firstObject];
    _bottomLine.frame = firetLab.frame;
    _bottomLine.height = _style.bottomLineH;
    _bottomLine.y = self.height - _style.bottomLineH;
  
    NSLog(@"%@",NSStringFromCGRect(_bottomLine.frame));
}

-(void)setupCoverView {
    [_scrollView insertSubview:_coverView atIndex:0];
 
    UILabel* firstLabel = _titleLabels[0];
    CGFloat coverW = firstLabel.width;
    CGFloat coverH = _style.coverH;
    CGFloat coverX = firstLabel.x;
    CGFloat coverY = (self.height - coverH) * 0.5;
    
    if (_style.isScrollEnable) {
        coverX -= _style.coverMargin;
        coverW += _style.coverMargin * 2;
    }
    _coverView.frame = CGRectMake(coverX, coverY, coverW, coverH);
    
    _coverView.layer.cornerRadius = _style.coverRadius;
    _coverView.layer.masksToBounds = true;
}


-(void)titleLabelClick:(UITapGestureRecognizer*)tap {
    // 0.获取当前Label
    UILabel * currentLabel;
    if ([tap.view isKindOfClass:[UILabel class]]) {
        currentLabel=( UILabel *)tap.view;
    }else{
        return;
    }

    
    // 1.如果是重复点击同一个Title,那么直接返回
    if (currentLabel.tag == self.currentIndex ){
        return;
        
    }
    
    // 2.获取之前的Label
    UILabel * oldLabel = self.titleLabels[self.currentIndex];
    
    // 3.切换文字的颜色
    currentLabel.textColor = self.style.selectedColor;
    oldLabel.textColor = self.style.normalColor;
    
    // 4.保存最新Label的下标值
    self.currentIndex = currentLabel.tag;
    
    // 5.通知代理
    [self.delegate titleView:self selectedIndex:self.currentIndex];

    
    // 6.居中显示
    [self contentViewDidEndScroll];

    // 7.调整bottomLine
    if (self.style.isShowBottomLine ){
        [UIView animateWithDuration:0.15 animations:^{
            self.bottomLine.x = currentLabel.x;
            self.bottomLine.width = currentLabel.width;
        }];
     
    }
    
    // 8.调整比例
    if(self.style.isNeedScale ){
        oldLabel.transform =CGAffineTransformIdentity;
        currentLabel.transform =CGAffineTransformMakeScale( self.style.scaleRange, self.style.scaleRange);
    
    }
    
    // 9.遮盖移动
    if (self.style.isShowCover) {
        CGFloat coverX = self.style.isScrollEnable ? (currentLabel.frame.origin.x - self.style.coverMargin) : currentLabel.frame.origin.x;
        CGFloat coverW =  self.style.isScrollEnable ? (currentLabel.width + self.style.coverMargin * 2) : currentLabel.width;
        [UIView animateWithDuration:0.15 animations:^{
            self.coverView.x = coverX;
            self.coverView.width = coverW;
        }];
       
    }
}


-(void)setTitleWithProgress:(CGFloat)progress  sourceIndex :(NSInteger)sourceIndex targetIndex :(NSInteger)targetIndex{
    // 1.取出sourceLabel/targetLabel
    UILabel* sourceLabel = _titleLabels[sourceIndex];
    UILabel* targetLabel = _titleLabels[targetIndex];
    

    const CGFloat *selectedComponents = CGColorGetComponents(self.selectedColorRGB.CGColor);
     const CGFloat *normalComponents = CGColorGetComponents(self.normalColorRGB.CGColor);
    // 3.颜色的渐变(复杂)
    // 3.1.取出变化的范围
    NSArray *colorDelta =@[@(selectedComponents[0] - normalComponents[0]), @(selectedComponents[1] - normalComponents[1]), @(selectedComponents[2] - normalComponents[2])];
 NSLog(@"%@",colorDelta[1]);

    // 3.2.变化sourceLabel
   
    sourceLabel.textColor =  [UIColor colorWithRed:selectedComponents[0] - [colorDelta[0] floatValue] * progress green:selectedComponents[1] - [colorDelta[1] floatValue] * progress blue:selectedComponents[2] - [colorDelta[2] floatValue]* progress alpha:1];
    
    // 3.2.变化targetLabel
  
    targetLabel.textColor =   [UIColor colorWithRed:normalComponents[0] +[colorDelta[0] floatValue] * progress green:normalComponents[1] + [colorDelta[1] floatValue]* progress blue:normalComponents[2] + [colorDelta[2] floatValue]* progress alpha:1];;
    
    // 4.记录最新的index
    self.currentIndex = targetIndex;
    if( progress==1.0) {
        sourceLabel.textColor=self.style.normalColor;
        targetLabel.textColor=self.style.selectedColor;
        
     
    }
    
    
    CGFloat moveTotalX = targetLabel.x - sourceLabel.x;
    CGFloat moveTotalW = targetLabel.width - sourceLabel.width;
    
    // 5.计算滚动的范围差值
    if (self.style.isShowBottomLine) {
        self.bottomLine.width = sourceLabel.width + moveTotalW * progress;
        self.bottomLine.x = sourceLabel.x + moveTotalX * progress;
    }
    
    // 6.放大的比例
    if (self.style.isNeedScale ){
        CGFloat scaleDelta = (self.style.scaleRange - 1.0) * progress;
        sourceLabel.transform=CGAffineTransformMakeScale(_style.scaleRange - scaleDelta, _style.scaleRange - scaleDelta);
       
        targetLabel.transform = CGAffineTransformMakeScale( 1.0 + scaleDelta,1.0 + scaleDelta);
    }
    
    // 7.计算cover的滚动
    if (self.style.isShowCover ){
        self.coverView.width = self.style.isScrollEnable ? (sourceLabel.width + 2 * _style.coverMargin + moveTotalW * progress) : (sourceLabel.width + moveTotalW * progress);
        self.coverView.x = _style.isScrollEnable ? (sourceLabel.x - _style.coverMargin + moveTotalX * progress) : (sourceLabel.x + moveTotalX * progress);
    }
}
-(void)contentViewDidEndScroll{
    // 0.如果是不需要滚动,则不需要调整中间位置
    if (!_style.isScrollEnable) {
        return;
    }

    
    // 1.获取获取目标的Label
        UILabel* targetLabel = self.titleLabels[self.currentIndex];
    
    // 2.计算和中间位置的偏移量
        CGFloat offSetX = targetLabel.center.x - self.width * 0.5;
    if (offSetX < 0 ){
        offSetX = 0;
    }
    
        CGFloat maxOffset = self.scrollView.contentSize.width - self.width;
    if  (offSetX > maxOffset){
        offSetX = maxOffset;
    }
    
    // 3.滚动UIScrollView
    [self.scrollView setContentOffset:CGPointMake(offSetX, 0) animated:true];

}
@end
