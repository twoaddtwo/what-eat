//
//  LeanCloudTool.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/19.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiyMenuModel.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UserInfoModel.h"

@interface LeanCloudTool : NSObject

typedef void(^NetBlockModel) (UserInfoModel* userInfo);
typedef void(^NetBlockDiyModel) (NSMutableArray* DiyMenuInfoList);
typedef void(^NetModel) (DiyMenuModel* IdInfo);

+(instancetype)sharedNetworkMng;

-(void)UserInfoWithParamenters:(NSString *)parameters forView:(UIView *)view Result:(NetBlockModel)block;

-(void)DiyMenuWithParamenters:(NSString *)parameters forView:(UIView *)view Result:(NetBlockDiyModel)block;
-(void)MyDiyMenuWithParamenters:(NSString *)parameters forView:(UIView *)view Result:(NetBlockDiyModel)block;
-(void)DiyMenuWithId:(NSString *)parameters forView:(UIView *)view Result:(NetModel)block;
@end
