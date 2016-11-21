//
//  MenuList.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MenuList.h"
#import "MenuListModel.h"
@implementation MenuList
+(instancetype)MenuListWithDict:(NSMutableDictionary*)dict{
    if(dict == nil){
        return nil;
    }
    MenuList *model = [[MenuList alloc]init];
    if(model!=nil){
        
        NSMutableArray* array=[dict objectForKey:@"tngou"];
        NSMutableArray *arraytest = [NSMutableArray array];
        
        for(int i=0;i<array.count;i++){
            
            MenuListModel *model = [MenuListModel MenuListModelWithDict:array[i]];
            [arraytest addObject:model];
            }
        model.MenuList = arraytest;
    }
    return model;
}
@end
