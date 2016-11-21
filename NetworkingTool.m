//
//  NetworkingTool.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/11.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "NetworkingTool.h"
#import <AFNetworking.h>
#import<MBProgressHUD.h>
#import "MBProgressHUD+ROHUD.h"
static NetworkingTool* netTool;

@implementation NetworkingTool
+ (instancetype)sharedNetworkMng
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        netTool = [[NetworkingTool alloc]init];
    });
    return netTool;
}

-(void)MenuTypeRequestWithParamenters:(NSDictionary *)parameters forView:(UIView *)view Result:(NetBlockModel)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
  [manager POST:@"http://www.tngou.net/api/cook/list"parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              MenuList *model = [MenuList MenuListWithDict:responseObject];
              block(model);
}
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              
              NSLog(@"%@",error);
              
          }];
}
-(void)MenuMakeRequestWithParamenters:(NSDictionary *)parameters forView:(UIView *)view Result:(NetBlockDetailModel)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    [manager POST:@"http://www.tngou.net/api/cook/show"parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
            [MBProgressHUD hideHUDForView:view animated:YES];
              DetailMakeModel *model = [DetailMakeModel DetailMakeModelWithDict:responseObject];
           
      
              block(model);
          }
     
          failure:^(AFHTTPRequestOperation *operation,NSError *error) {
            [MBProgressHUD hideHUDForView:view animated:YES];
              
              NSLog(@"%@",error);
              
          }];
}

@end

