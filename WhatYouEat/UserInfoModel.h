//
//  UserInfoModel.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/19.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import <AVOSCloud/AVOSCloud.h>
@interface UserInfoModel : NSObject
@property NSString* username;
@property NSString* userId;
@property NSString* email;
@property NSString* password;
@property AVFile* portrait;
+(instancetype)UserInfoModelWithDict:(AVObject*)avobject;
@end
