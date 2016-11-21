//
//  SignViewController.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/14.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSAnimatedImagesView/JSAnimatedImagesView.h"
@interface SignViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,JSAnimatedImagesViewDataSource>
- (IBAction)backToLogin:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *userPortrait;



@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;

- (IBAction)sign:(id)sender;

@end
