//
//  MakeMenuCollectionViewCell.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/17.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeMenuCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *AddImg;

@property (weak, nonatomic) IBOutlet UITextField *MenuName;
@property (weak, nonatomic) IBOutlet UITextField *experience;
@property (weak, nonatomic) IBOutlet UITextField *material;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
