//
//  HKRESTServer.h
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/03/27.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKURIMappingListenerProtocol.h"
#import "HKResponse.h"

@interface HKRESTServer : NSObject
@property(strong,nonatomic) NSMutableDictionary *mappingDic;
+ (void)start;
+ (void)end;
+ (void)registURIMapping:(NSString*)uriStr Listener:(NSObject<HKURIMappingListenerProtocol>*)listenObj;
+ (void)unregistURLMapping:(NSString*)uriStr;
+ (HKResponse*)mappingURI:(NSString*)URIstr query:(NSDictionary*)query json:(NSDictionary*)json;
+ (BOOL)isListen:(NSURLRequest *)request;
@end
