//
//  MyTableViewCell.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/16.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *portrait;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *email;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
