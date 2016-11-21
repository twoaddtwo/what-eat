//
//  MenuMakeTableViewCell.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MenuMakeTableViewCell.h"

@implementation MenuMakeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
 


   _nameLabel.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5];
    _nameLabel.font = [UIFont boldSystemFontOfSize:20];
    _nameLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(36.0)];
   _nameLabel.textAlignment =  UITextAlignmentCenter;
    //设置文本是否高亮和高亮时的颜色
    _nameLabel.highlighted = YES;
    _nameLabel.highlightedTextColor = [UIColor whiteColor];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
   
    static NSString *ID = @"makemenuCell";
    //先从缓存池中找可重用的cell
    MenuMakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //没找到就创建
    if (cell == nil) {
      return [[[NSBundle mainBundle] loadNibNamed:@"MenuMakeTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
