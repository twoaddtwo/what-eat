//
//  MenuListModel.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuListModel : NSObject
@property NSString *Id;
@property NSString *Name;
@property NSString *ImageUrl;

+(instancetype)MenuListModelWithDict:(NSMutableDictionary *)dict;
@end
