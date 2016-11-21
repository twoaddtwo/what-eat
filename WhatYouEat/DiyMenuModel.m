//
//  DiyMenuModel.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/19.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "DiyMenuModel.h"
#import "LeanCloudTool.h"

@implementation DiyMenuModel
+(instancetype)DiyMenuModelWithAVObject:(AVObject*)avobject{
    if (avobject == nil){
        return nil;
    }
   DiyMenuModel *model = [[DiyMenuModel alloc]init];
    if(model != nil){
     
        model.experience = [avobject objectForKey:@"experience"];
        model.material = [avobject objectForKey:@"material"];
        model.menuName = [avobject objectForKey:@"menuname"];
        model.stepimg = [avobject objectForKey:@"stepimgarray"];
        model.stepname = [avobject objectForKey:@"stepnamearray"];
        model.menuId = [avobject objectForKey:@"objectId"];
        
        
        
   LeanCloudTool* tool = [LeanCloudTool sharedNetworkMng];
        [tool UserInfoWithParamenters:[avobject objectForKey:@"email"] forView:nil Result:^(UserInfoModel *userInfo) {
            model.userinfomodel = userInfo;
        }];
        

      
        
       
    }
    return  model;
}
@end
