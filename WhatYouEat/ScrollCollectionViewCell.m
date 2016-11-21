//
//  ScrollCollectionViewCell.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/12.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "ScrollCollectionViewCell.h"

@implementation ScrollCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        //采用本地图片
           NSArray *imageNames = @[@"h1.jpg",@"h2.jpg",@"h3.jpg",@"h4.jpg"];
        SDCycleScrollView *cyclescroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,200) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        cyclescroll.autoScrollTimeInterval = 1;
        cyclescroll.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        [self.contentView addSubview:cyclescroll];
        }
    
    return self;
}
@end
