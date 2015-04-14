//
//  HKRESTServer.m
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/03/27.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import "HKRESTServer.h"
#import "HKURLProtocol.h"


@implementation HKRESTServer

static HKRESTServer* _insetance = nil;

- (id)init{
    self=[super init];
    if(self){
        self.mappingDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

+ (BOOL)isListen:(NSURLRequest *)request{
    if (!_insetance)return NO;
    if(7777 == [request.URL.port intValue]){
        return YES;
    }
    return NO;
}

+ (void)registURIMapping:(NSString*)uriStr Listener:(NSObject<HKURIMappingListenerProtocol>*)listenObj{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _insetance = [[HKRESTServer alloc] init];
    });
    [_insetance.mappingDic setValue:listenObj forKey:uriStr];
}

+ (void)unregistURLMapping:(NSString*)uriStr {
    if (!_insetance)return;
    [_insetance.mappingDic removeObjectForKey:uriStr];
}

+ (HKResponse*)mappingURI:(NSString*)URIstr query:(NSDictionary*)query json:(NSDictionary*)json {
    if (!_insetance)return [HKResponse resonseError];
    for (NSString* mappingURI in [_insetance.mappingDic keyEnumerator]) {
        if ([URIstr hasPrefix:mappingURI]){
            NSObject<HKURIMappingListenerProtocol>* listenObj = (NSObject<HKURIMappingListenerProtocol>*)[_insetance.mappingDic objectForKey:mappingURI];
            return [listenObj requestURI:URIstr query:query json:json];
        }
    }
    return [HKResponse resonseError];;
}

+ (void)start{
    [NSURLProtocol registerClass:HKURLProtocol.class];
}

+ (void)end{
    [NSURLProtocol unregisterClass:HKURLProtocol.class];
}



@end
