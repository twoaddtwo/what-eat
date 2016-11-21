//
//  NetworkingTool.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/11.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MenuList.h"
#import "DetailMakeModel.h"
@interface NetworkingTool : NSObject
typedef void(^NetBlockModel) (MenuList* menulist);
typedef void(^NetBlockDetailModel) (DetailMakeModel* menumake);
+(instancetype)sharedNetworkMng;

-(void)MenuTypeRequestWithParamenters:(NSDictionary *)parameters forView:(UIView *)view Result:(NetBlockModel)block;
-(void)MenuMakeRequestWithParamenters:(NSDictionary *)parameters forView:(UIView *)view Result:(NetBlockDetailModel)block;

@end