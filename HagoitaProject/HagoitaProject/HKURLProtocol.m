//
//  HKURLProtocol.m
//  HagoitaProject
//
//  Created by 君田 佑介 on 2015/03/27.
//  Copyright (c) 2015年 YUSUKE KIMITA. All rights reserved.
//

#import "HKURLProtocol.h"

@implementation HKURLProtocol

//TODO: 外部に条件を委譲する
+ (BOOL)canInitWithRequest:(NSURLRequest *)request{

    if(7777 == [request.URL.port intValue]){
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    
//    self.request.URL.path
//    /test/teat.json
   // po self.request.URL.query
    //fileter=1234&test=%E3%81%82%E3%81%84%E3%81%86%E3%81%88

    
    NSString *query = self.request.URL.query;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    
    NSLog(@"query %@",dict);
    
    NSLog(@"query %@",[dict objectForKey:@"test"]);
    
    //
    //[self.request.URL.pathExtension];
    NSError* error;
    id body = [NSJSONSerialization JSONObjectWithData:self.request.HTTPBody options:NSJSONReadingAllowFragments error:&error];
    if(error){
        NSLog(@"JSON ERROR");
    }
    
    NSLog(@"%@",[[NSString alloc]initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding]);
    int statusCode=200;
    NSString *json = @"{'teae':1,'test':'test'}";
    // NSData型にNSStringから変換します。
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"Content-Type",
                             [NSString stringWithFormat:@"%ld",[jsonData length]], @"Content-Length",
                             nil];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[self.request URL]
                                                              statusCode:statusCode
                                                             HTTPVersion:@"1.1"
                                                            headerFields:headers];
    [self.client URLProtocol:self
          didReceiveResponse:response
          cacheStoragePolicy:NSURLCacheStorageNotAllowed];

    [self.client URLProtocol:self didLoadData:jsonData];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading
{
}

@end
