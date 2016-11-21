//
//  AddStepCollectionViewCell.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/17.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "AddStepCollectionViewCell.h"

@implementation AddStepCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _addButton.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width/2, 50);
        [_addButton setTitle:@"添加步骤" forState:normal];
        
        
        _cutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _cutButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 50);
        
        [_cutButton setTitle:@"减少步骤" forState:normal];


        [self.contentView addSubview:self.addButton];
        [self.contentView addSubview:self.cutButton];
        
    }
    
    return self;
}
@end
