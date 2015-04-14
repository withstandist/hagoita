//
//  HKURIMappingListenerProtocol.h
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/03/28.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKResponse.h"

@protocol HKURIMappingListenerProtocol <NSObject>
-(HKResponse*)requestURI:(NSString*)URIstr query:(NSDictionary*)query json:(NSDictionary*)json;
@end
