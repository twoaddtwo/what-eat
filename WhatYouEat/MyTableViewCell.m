//
//  MyTableViewCell.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/16.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_portrait.layer setCornerRadius:CGRectGetHeight([_portrait bounds]) / 2];
    _portrait.layer.masksToBounds = YES;
    
   
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"myCell";
    //先从缓存池中找可重用的cell
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //没找到就创建
    if (cell == nil) {
        return [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
