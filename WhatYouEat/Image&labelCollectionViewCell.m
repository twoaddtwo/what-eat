//
//  Image&labelCollectionViewCell.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/12.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "Image&labelCollectionViewCell.h"

@implementation Image_labelCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.imagess = [[UIImageView alloc]init];
        self.label = [[UILabel alloc]init];
        self.imagess.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        
        self.label.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,200);

        self.label.font = [UIFont boldSystemFontOfSize:20];
        self.label.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(36.0)];
        self.label.textAlignment =  UITextAlignmentCenter;
        //设置文本是否高亮和高亮时的颜色
       self.label.highlighted = YES;
        self.label.highlightedTextColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imagess];
        [self.contentView addSubview:self.label];
        
    }
    
    return self;
}
@end
