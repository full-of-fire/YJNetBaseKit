//
//  YJTestApi.m
//  YJNetworking
//
//  Created by yj on 17/1/16.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJTestApi.h"

@implementation YJTestApi

- (NSString*)baseURLString {

    return @"http://api.myxianwen.cn/live/commonservice/get";
}

- (NSDictionary*)params {

    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    json[@"app_id"] = @"5000";
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *pas = [NSMutableDictionary dictionary];
    pas[@"action"] = @"showroomlist";
    pas[@"params"] = jsonString;
    
    return pas;
}

- (YJBaseApiRequestType)requestType {

    return YJBaseApiRequestTypeGet;
}
@end
