//
//  TestObject.m
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/03/28.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject
-(HKResponse*)requestURI:(NSString*)URIstr query:(NSDictionary*)query json:(NSDictionary*)json{
    NSLog(@"TestObject");
    HKResponse* response = [[HKResponse alloc] init];
    NSMutableDictionary* dic = [[NSMutableDictionary dictionary]init];
    [dic setValue:@"あいうえ" forKey:@"test"];
    [dic setValue:[NSNumber numberWithInt:100] forKey:@"test2"];
    response.responseDic = dic;
    
    return response;
}

@end
