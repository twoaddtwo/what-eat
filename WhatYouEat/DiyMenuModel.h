//
//  DiyMenuModel.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/19.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UserInfoModel.h"

@interface DiyMenuModel : NSObject
@property UserInfoModel* userinfomodel;
@property NSMutableArray *stepimg;
@property NSMutableArray *stepname;
@property NSString *experience;
@property NSString *menuName;
@property NSString* material;
@property NSString *menuId;
+(instancetype)DiyMenuModelWithAVObject:(AVObject*)avobject;
@end
