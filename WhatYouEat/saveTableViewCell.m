//
//  saveTableViewCell.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/27.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "saveTableViewCell.h"

@implementation saveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"mysaveCell";
    //先从缓存池中找可重用的cell
    saveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //没找到就创建
    if (cell == nil) {
        return [[[NSBundle mainBundle] loadNibNamed:@"saveTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
