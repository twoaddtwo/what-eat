//
//  LeanCloudTool.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/19.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "LeanCloudTool.h"
static LeanCloudTool* dataTool;

@implementation LeanCloudTool
+ (instancetype)sharedNetworkMng
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dataTool = [[LeanCloudTool alloc]init];
    });
    return dataTool;
}
-(void)UserInfoWithParamenters:(NSString *)parameters forView:(UIView *)view Result:(NetBlockModel)block{
 
    AVQuery *query = [AVQuery queryWithClassName:@"UserList"];
    [query whereKey:@"email" equalTo:parameters];
    
    
    [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if(object != nil){
            UserInfoModel *model = [UserInfoModel UserInfoModelWithDict:object];
               block(model);
          
        }
        else{
            NSLog(@"%@",error);
        }
        
    }];

}


-(void)DiyMenuWithParamenters:(NSString *)parameters forView:(UIView *)view Result:(NetBlockDiyModel)block{
    
    AVQuery *query = [AVQuery queryWithClassName:@"DiyMenuList"];
        [query orderByDescending:@"createdAt"];
    [query includeKey:@"stepimgarray"];
    NSMutableArray* array = [[NSMutableArray alloc]init];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects != nil) {
    
            for(int i=0; i<objects.count; i++){
            
               
                DiyMenuModel *model = [DiyMenuModel DiyMenuModelWithAVObject:objects[i]];
                [array addObject:model];
              }
            
            block(array);

        }
        else{
            NSLog(@"%@",error);
        }
    }];


    
}





-(void)MyDiyMenuWithParamenters:(NSString *)parameters forView:(UIView *)view Result:(NetBlockDiyModel)block{
    NSString* useremail = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    AVQuery *query = [AVQuery queryWithClassName:@"DiyMenuList"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"stepimgarray"];
    [query whereKey:@"email" equalTo:useremail];
    NSMutableArray* array = [[NSMutableArray alloc]init];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects != nil) {
            
            for(int i=0; i<objects.count; i++){
                
                
                DiyMenuModel *model = [DiyMenuModel DiyMenuModelWithAVObject:objects[i]];
                [array addObject:model];
            }
            
            block(array);
            
        }
        else{
            NSLog(@"%@",error);
        }
    }];
    
    
    
}

-(void)DiyMenuWithId:(NSString *)parameters forView:(UIView *)view Result:(NetModel)block{
    
    AVQuery *query = [AVQuery queryWithClassName:@"DiyMenuList"];
  
    [query includeKey:@"stepimgarray"];

    [query whereKey:@"objectId" equalTo:parameters];
    
    
    [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if(object != nil){
         DiyMenuModel *model = [DiyMenuModel DiyMenuModelWithAVObject:object];
            block(model);
            
        }
        else{
            NSLog(@"%@",error);
        }
        
    }];

    
    
    
}



@end
