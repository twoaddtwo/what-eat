//
//  DetailMakeModel.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "DetailMakeModel.h"

@implementation DetailMakeModel
+(instancetype)DetailMakeModelWithDict:(NSMutableDictionary *)dict{
    if(dict==nil){
        return nil;
    }
    DetailMakeModel *model = [[DetailMakeModel alloc]init];
    if(model!=nil){
        model.Name = [dict objectForKey:@"name"];
        model.Material = [dict objectForKey:@"food"];
        model.ImageUrl = [dict objectForKey:@"img"];
        model.message = [dict objectForKey:@"message"];
        model.message = [model.message stringByReplacingOccurrencesOfString:@"<h2>" withString:@"\n"];
         model.message = [model.message stringByReplacingOccurrencesOfString:@"</h2>" withString:@"\n"];
         model.message = [model.message stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
           model.message = [model.message stringByReplacingOccurrencesOfString:@"<p>" withString:@" "];
              model.message = [model.message stringByReplacingOccurrencesOfString:@"<hr>" withString:@"\n"];
        
    
    }
        return model;
}
@end
