//
//  HKResponse.h
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/03/28.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKResponse : NSObject

@property(assign,nonatomic)int httpStatusCode;
@property(strong,nonatomic)NSDictionary* responseDic;

+(id)resonseError;
@end
