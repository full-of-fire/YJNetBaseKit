//
//  YJBaseNetManager.h
//  YJNetworking
//
//  Created by yj on 17/1/16.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJURLResponse;
typedef void(^YJCallBack)(YJURLResponse*response);

@interface YJBaseNetManager : NSObject

+ (instancetype)sharedBaseNetManager;


- (NSNumber*)netWorkGetWithURLString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(YJCallBack)success fail:(YJCallBack)fail;


- (NSNumber*)netWorkPostWithURLString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(YJCallBack)success fail:(YJCallBack)fail;


- (void)cancelRequestWithRequestId:(NSNumber*)requestId;

- (void)cancelRequestWithRequestIdArray:(NSArray*)requestIdArray;

- (void)cancelAllRequests;

@end
