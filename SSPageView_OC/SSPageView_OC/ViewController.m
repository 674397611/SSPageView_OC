//
//  ViewController.m
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import "ViewController.h"
#import "SSPageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 创建主题内容
    SSTitleStyle *style = [SSTitleStyle new];
    [style setBaseData];
    style.isScrollEnable = true;
    style.isShowBottomLine = true;
    style.isNeedScale = true;
    CGRect pageFrame =CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20);
 
    
    NSArray* titles = @[@"热门", @"呆萌", @"高颜值", @"好声音", @"好声音燃舞蹈", @"高颜值", @"好声音",@"热门", @"呆萌", @"高颜值", @"好声音", @"好声音燃舞蹈",@ "高颜值",@ "好声音"];
    NSMutableArray * childVcs =[NSMutableArray new];
    for (NSString* type in titles ){
        UIViewController* anchorVc = [UIViewController new];
        anchorVc.view.backgroundColor=SSColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
        [childVcs addObject:anchorVc];
        NSLog(@"%@",type);
    }
    SSPageView * pageView=[[SSPageView alloc] initWithframe:pageFrame titles:titles style:style childVcs:childVcs parentVc:self];
    [self.view addSubview:pageView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
