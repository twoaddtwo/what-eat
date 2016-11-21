//
//  UserInfoModel.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/19.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
+(instancetype)UserInfoModelWithDict:(AVObject*)avobject{
    if(avobject == nil){
        return  nil;
    }
    UserInfoModel *model = [[UserInfoModel alloc]init];
    if(model!=nil){
        model.userId = [avobject objectForKey:@"objectId"];
        model.username = [avobject objectForKey:@"username"];
        model.portrait = [avobject objectForKey:@"portrait"];
        model.password = [avobject objectForKey:@"password"];
        model.email = [avobject objectForKey:@"email"];
        
    }
    return  model;
}
@end
