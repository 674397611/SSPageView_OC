//
//  SSTitleStyle.m
//  SSPageView_OC
//
//  Created by newings_mac on 2018/3/28.
//  Copyright © 2018年 newings_mac. All rights reserved.
//

#import "SSTitleStyle.h"


@implementation SSTitleStyle
-(void)setBaseData{
    self.normalColor=SSColor(0, 0, 0);
    self.selectedColor=SSColor( 255,  127, 0);
    self.font=[UIFont systemFontOfSize:14];
    self.titleMargin=20;
    self.bottomLineColor=self.selectedColor;
    self.bottomLineH=2;
    self.scaleRange=1.2;
    self.coverBgColor=[UIColor lightGrayColor];
    self.coverMargin=5;
    self.coverH=25;
    self.coverRadius=12;
}
@end
