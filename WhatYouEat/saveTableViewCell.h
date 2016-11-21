//
//  saveTableViewCell.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/27.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface saveTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
