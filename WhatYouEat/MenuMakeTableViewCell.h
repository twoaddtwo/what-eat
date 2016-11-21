//
//  MenuMakeTableViewCell.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuMakeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextView *MenuMakeText;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
