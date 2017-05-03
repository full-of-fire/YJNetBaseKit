//
//  YJBaseNetManager.m
//  YJNetworking
//
//  Created by yj on 17/1/16.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJBaseNetManager.h"
#import "AFNetworking.h"
#import "YJNetMonitorManger.h"
#import "YJURLResponse.h"
#import "YJGlobleNetworkConfig.h"

NSDictionary *RequestParams (NSDictionary*originParams) {

    YJGlobleNetworkConfig *config = [YJGlobleNetworkConfig sharedGlobeNetworkConfig];
    
    __block  NSMutableDictionary *mutbleParams = [originParams mutableCopy];
    
    [config.universalParams enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        mutbleParams[key] = obj;
    }];
    
    return [mutbleParams copy];
}

@interface YJBaseNetManager()

@property (strong,nonatomic) NSMutableDictionary *requestDic;

@property (strong,nonatomic) AFHTTPSessionManager *sessionManger;

@end


@implementation YJBaseNetManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
        [manager.requestSerializer setTimeoutInterval:kYJNetworkingTimeoutSeconds]; // 设置请求超时时间
        
    
        _sessionManger = manager;
        
        _requestDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}
+ (instancetype)sharedBaseNetManager {

    static YJBaseNetManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    
    return instance;
}



- (NSNumber*)netWorkGetWithURLString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(YJCallBack)success fail:(YJCallBack)fail {
    
  
    
//    BOOL isReach = [[YJNetMonitorManger sharedNetMonitorManager] isReachable];
//
//    if (!isReach) {
//       
//       // 没有网咯
//        if (fail) {
//            YJURLResponse *response = [[YJURLResponse alloc] initWithError:nil Status:YJURLResponseStatusNoNetwork];
//            fail(response);
//        }
//        return @(0);
//    }

    NSDictionary *requestParams = RequestParams(parameter);
    
    NSURLSessionDataTask* task= [self.sessionManger GET:urlString parameters:requestParams progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
       
        
        if (success) {
             YJURLResponse *response = [[YJURLResponse alloc] initWithResponseObject:responseObject status:YJURLResponseStatusSuccess];
            success(response);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (fail) {
            
            YJURLResponse *response = [[YJURLResponse alloc] initWithError:error Status:YJURLResponseStatusFail];
            fail(response);
        }
        
        
    }];
    
    NSNumber *taskIdentifier = @([task taskIdentifier]);
    
    self.requestDic[taskIdentifier] = task;
    
    
    return @([task taskIdentifier]);
}


- (NSNumber*)netWorkPostWithURLString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(YJCallBack)success fail:(YJCallBack)fail {
    
    
//    BOOL isReach = [[YJNetMonitorManger sharedNetMonitorManager] isReachable];
//    if (!isReach) {
//        
//        // 没有网咯
//        if (fail) {
//            YJURLResponse *response = [[YJURLResponse alloc] initWithError:nil Status:YJURLResponseStatusNoNetwork];
//            fail(response);
//        }
//        return @(0);
//    }

    NSDictionary *requestParams = RequestParams(parameter);
    NSURLSessionDataTask* task= [self.sessionManger POST:urlString parameters:requestParams progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (success) {
            YJURLResponse *response = [[YJURLResponse alloc] initWithResponseObject:responseObject status:YJURLResponseStatusSuccess];
            success(response);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        if (fail) {
            
            YJURLResponse *response = [[YJURLResponse alloc] initWithError:error Status:YJURLResponseStatusFail];
            fail(response);
        }
        
    }];
    
    NSNumber *taskIdentifier = @([task taskIdentifier]);
    
    self.requestDic[taskIdentifier] = task;
    
    
    return @([task taskIdentifier]);
}


- (void)cancelRequestWithRequestId:(NSNumber*)requestId {

    NSURLSessionDataTask *task = self.requestDic[requestId];
    if (!task) {
        
        return;
    }
    
    [task cancel];
    
    [self.requestDic removeObjectForKey:requestId];
}


- (void)cancelRequestWithRequestIdArray:(NSArray *)requestIdArray {


    if (!requestIdArray.count) {
        return;
    }
    
    for (NSNumber* reuqestId in requestIdArray) {
        
        
        [self cancelRequestWithRequestId:reuqestId];
    }
}


- (void)cancelAllRequests {

    if(!self.requestDic.allValues.count) return;
    for (NSURLSessionDataTask *task in self.requestDic.allValues) {
        [task cancel];
    }
    
    [self.requestDic removeAllObjects];
}






@end
