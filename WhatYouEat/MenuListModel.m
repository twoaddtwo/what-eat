//
//  MenuListModel.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MenuListModel.h"

@implementation MenuListModel
+(instancetype)MenuListModelWithDict:(NSMutableDictionary *)dict{
    if (dict == nil){
        return nil;
    }
    MenuListModel *model = [[MenuListModel alloc]init];
    if(model !=nil){

        model.Id = [dict objectForKey:@"id"];
        model.Name = [dict objectForKey:@"name"];
        model.ImageUrl = [dict objectForKey:@"img"];
    }
    return  model;
}
@end
