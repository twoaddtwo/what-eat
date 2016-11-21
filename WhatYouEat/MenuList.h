//
//  MenuList.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuList : NSObject
@property NSMutableArray* MenuList;
+(instancetype)MenuListWithDict:(NSMutableDictionary*)dict;
@end
