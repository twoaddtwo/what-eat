//
//  DetailMakeModel.h
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailMakeModel : NSObject
@property NSString *Material;
@property NSString *Name;
@property NSString *ImageUrl;
@property NSString *message;

+(instancetype)DetailMakeModelWithDict:(NSMutableDictionary *)dict;
@end
