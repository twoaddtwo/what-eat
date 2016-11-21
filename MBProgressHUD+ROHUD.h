//
//  MBProgressHUD+ROHUD.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/22.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (ROHUD)
+(void)showDelayHUDToView:(UIView *)view message:(NSString*)message;
@end
