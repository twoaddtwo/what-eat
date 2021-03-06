//
//  diysaveCollectionViewCell.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/11/9.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "diysaveCollectionViewCell.h"

@implementation diysaveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"diysaveCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end
