//
//  CustomCollectionViewCell.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/14.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_portraitimag.layer setCornerRadius:CGRectGetHeight([_portraitimag bounds]) / 2];
    _portraitimag.layer.masksToBounds = YES;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CustomCollectionViewCell" owner:self options:nil];
        
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
