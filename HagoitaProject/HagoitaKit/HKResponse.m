//
//  HKResponse.m
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/03/28.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import "HKResponse.h"

@implementation HKResponse

+(id)resonseError{
    HKResponse* response = [[HKResponse alloc]init];
    response.httpStatusCode=500;
    response.responseDic=[[NSDictionary alloc]init];
    return response;
}

@end
