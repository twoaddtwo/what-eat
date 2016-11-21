//
//  CustomCollectionViewCell.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/14.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *portraitimag;
@property (weak, nonatomic) IBOutlet UILabel *dishname;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UILabel *experience;
@end
