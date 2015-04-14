//
//  DebugHane.m
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/04/14.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import "DebugHane.h"

@implementation DebugHane

/*
 queryをそのままログに返す
 */
-(HKResponse*)requestURI:(NSString*)URIstr query:(NSDictionary*)query json:(NSDictionary*)json{
    
    NSLog(@"log:%@", URIstr);
    
    HKResponse* response = [[HKResponse alloc] init];
    NSMutableDictionary* dic = [[NSMutableDictionary dictionary]init];
    response.responseDic = dic;
    
    return response;
}

@end
