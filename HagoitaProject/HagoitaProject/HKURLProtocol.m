//
//  HKURLProtocol.m
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/03/27.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import "HKURLProtocol.h"
#import "HKRESTServer.h"

@implementation HKURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    return [HKRESTServer isListen:request];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        @try {
            NSString *query = self.request.URL.query;
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
            NSArray *pairs = [query componentsSeparatedByString:@"&"];
            
            for (NSString *pair in pairs) {
                NSArray *elements = [pair componentsSeparatedByString:@"="];
                NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [dict setObject:val forKey:key];
            }
            
            NSError* error;
            id body;
            if(self.request.HTTPBody!=nil){
                body = [NSJSONSerialization JSONObjectWithData:self.request.HTTPBody options:NSJSONReadingAllowFragments error:&error];
                if(error){
                    NSLog(@"JSON ERROR");
                    @throw [NSException exceptionWithName:@"JSON" reason:nil userInfo:nil];
                }
            }else{
                body = nil;
            }
            
            HKResponse* result = [HKRESTServer mappingURI:self.request.URL.path query:dict json:body];
            NSData* data = [NSJSONSerialization dataWithJSONObject:result.responseDic options:NSJSONWritingPrettyPrinted error:&error];
            if(error){
                NSLog(@"JSON ERROR %@",error);
                @throw [NSException exceptionWithName:@"JSON" reason:nil userInfo:nil];
            }
            [self responseJSONWithHttpStatusCode:result.httpStatusCode data:data];
        }
        @catch (NSException *exception) {
            NSLog(@"NSException %@",exception);
            [self responseJSONWithHttpStatusCode:500 data:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        @finally {
        }
    });

}

- (void) responseJSONWithHttpStatusCode:(int)statusCode data:(NSData*) data{
    NSDictionary*headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"Content-Type",
               [NSString stringWithFormat:@"%ld",[data length]], @"Content-Length",
               nil];
    NSHTTPURLResponse* response = [[NSHTTPURLResponse alloc] initWithURL:[self.request URL]
                                           statusCode:statusCode
                                          HTTPVersion:@"1.1"
                                         headerFields:headers];

    [self.client URLProtocol:self
          didReceiveResponse:response
          cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading
{
}

@end
