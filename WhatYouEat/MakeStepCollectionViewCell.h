//
//  MakeStepCollectionViewCell.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/17.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeStepCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *AddImg;


@property (weak, nonatomic) IBOutlet UITextField *stepname;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
