//
//  MBProgressHUD+ROHUD.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/22.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MBProgressHUD+ROHUD.h"

@implementation MBProgressHUD (ROHUD)

+(void)showDelayHUDToView:(UIView *)view message:(NSString*)message{
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:view];
    [view addSubview:HUD];
    [HUD setOffset:CGPointMake(0, view.frame.size.height*1.0/4)];
    HUD.customView = [[UIImageView alloc]initWithFrame:CGRectZero];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text = message;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.f];
    
}


@end


