//
//  settingViewController.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/22.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
@interface settingViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property UserInfoModel* model;
@property (weak, nonatomic) IBOutlet UIImageView *UserPortrait;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)saveuserInfo:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *password;
@end
