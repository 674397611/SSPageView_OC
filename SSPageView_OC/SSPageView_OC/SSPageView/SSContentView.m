//
//  SSContentView.m
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import "SSContentView.h"
@interface SSContentView()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
static NSString* kContentCellID = @"kContentCellID";
@implementation SSContentView
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
     
        collectionView.scrollsToTop = false;
        collectionView.bounces = false;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.frame = self.bounds;
        collectionView.pagingEnabled = true;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
   
        collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView=collectionView;
    }
    return _collectionView;
    
}
- (id)initWithframe:(CGRect)frame childVcs:(NSArray *)childVcs parentVc :(UIViewController*)parentVc{
    if (self = [super initWithFrame:frame])
    {
    
        self.childVcs = childVcs;
        self.parentVc = parentVc;
     
        
        [self setupUI];
        
    }
    
    return self;
}
-(void)setupUI{
    // 1.将所有的控制器添加到父控制器中
    for (UIViewController *vc in self.childVcs) {
        [_parentVc addChildViewController:vc];
    }
  
    
    // 2.添加UICollectionView
    [self addSubview:self.collectionView];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _childVcs.count;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    
    
    // 2.设置cell的内容
    for (UIView * subview in cell.contentView.subviews ){
        [subview removeFromSuperview];
    }
    
    UIViewController * childVc = _childVcs[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview: childVc.view ];
    
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isForbidScrollDelegate = false;
    
    self.startOffsetX = scrollView.contentOffset.x;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 0.判断是否是点击事件
    if (self.isForbidScrollDelegate) {
        return;
    }
    // 1.定义获取需要的数据
    CGFloat  progress  = 0;
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    
    // 2.判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.width;
    if (currentOffsetX > self.startOffsetX ){ // 左滑
        // 1.计算progress
       
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);

        // 2.计算sourceIndex
        sourceIndex = (NSInteger)(currentOffsetX / scrollViewW);
        
        // 3.计算targetIndex
        targetIndex = sourceIndex + 1;
        if (targetIndex >= self.childVcs.count) {
            targetIndex = self.childVcs.count - 1;
        }
        
        // 4.如果完全划过去
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = sourceIndex;
        }
    } else { // 右滑
        // 1.计算progress
         progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        
        // 2.计算targetIndex
        targetIndex = (NSInteger)(currentOffsetX / scrollViewW);
        
        // 3.计算sourceIndex
        sourceIndex = targetIndex + 1;
        if( sourceIndex >= self.childVcs.count ){
            sourceIndex = self.childVcs.count - 1;
        }
        // 4.如果完全划过去
        if( currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1;
            sourceIndex = targetIndex;
        }
        
    }
    
    // 3.将progress/sourceIndex/targetIndex传递给titleView
    [self.delegate contentView:self progress:progress sourceIndex:(NSInteger)sourceIndex targetIndex:targetIndex];
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.delegate contentViewEndScroll:self];
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self.delegate contentViewEndScroll:self];
    }
}
-(void)setCurrentIndex:(NSInteger)currentIndex{
    
    // 1.记录需要进制执行代理方法
    self.isForbidScrollDelegate = true;
    
    // 2.滚动正确的位置
    CGFloat offsetX = (CGFloat)currentIndex * self.collectionView.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:false];
    
}


@end
