//
//  YJBaseApi.m
//  YJNetworking
//
//  Created by yj on 17/1/16.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJBaseApi.h"

#import "YJURLResponse.h"
@interface YJBaseApi ()

@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (copy,nonatomic) YJCallBack successCallBack;
@property (copy,nonatomic) YJCallBack failCallBack;
@end


@implementation YJBaseApi

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        
        if ([self conformsToProtocol:@protocol(YJBaseApiDelegate) ]) {
            
            self.child = (id<YJBaseApiDelegate>) self;
        }
        else{
        
            NSException *exception = [NSException exceptionWithName:@"为遵守和实现协议" reason:@"网络请求子类必须遵守和实现YJBaseApiDelegate" userInfo:nil];
            
            @throw exception;
        }
    }
    return self;
}


- (void)dealloc {

    
    [self cancelAllRequest];
    
    self.requestIdList = nil;
    
}



- (void)cancelRequestWithRequestId:(NSNumber*)requestId {

    [[YJBaseNetManager sharedBaseNetManager] cancelRequestWithRequestId:requestId];
    [self.requestIdList removeObject:requestId];
}


- (void)cancelAllRequest {

    [[YJBaseNetManager sharedBaseNetManager] cancelRequestWithRequestIdArray:self.requestIdList];
    
    [self.requestIdList removeAllObjects];
}



- (NSNumber*)loadData {

    NSNumber *requestId =  [self loadDataWithParams:[self.child params]];
    [self.requestIdList addObject:requestId];
    return requestId;
    
}

- (NSNumber*)loadDataSuccess:(YJCallBack)success fail:(YJCallBack)fail{

    self.successCallBack = [success copy];
    self.failCallBack = [fail copy];
    return [self loadData];
}



- (NSNumber*)loadDataWithParams:(NSDictionary*)params {

    switch ([self.child requestType]) {
        case YJBaseApiRequestTypeGet:
            
           return  [self netGetWithParams:params];
            break;
        case YJBaseApiRequestTypePost:
           return  [self netPostWithParams:params];
            break;
        default:
            break;
    }
    
   
    
}

- (NSNumber*)loadDataWithParams:(NSDictionary *)params success:(YJCallBack)success fail:(YJCallBack)fail {

    self.successCallBack = [success copy];
    self.failCallBack = [fail copy];
    return [self loadDataWithParams:params];
}


#pragma mark -private

- (NSNumber*)netGetWithParams:(NSDictionary*)params {

   return  [[YJBaseNetManager sharedBaseNetManager] netWorkGetWithURLString:[self.child baseURLString] parameter:params success:^(YJURLResponse *response) {
        
        if ([self.delegate respondsToSelector:@selector(baseApiDidSuccess:response:)]) {
            
            [self.delegate baseApiDidSuccess:self response:response];
        }
       
       if (self.successCallBack) {
           
           self.successCallBack(response);
       }
    } fail:^(YJURLResponse *response) {
       
        
        if (self.failCallBack) {
            
            self.failCallBack(response);
        }
        
        if ([self.delegate respondsToSelector:@selector(baseApiDidFail:response:)]) {
            
            [self.delegate baseApiDidFail:self response:response];
        }
        
    }];
    
    
}


- (NSNumber*)netPostWithParams:(NSDictionary*)params {

   return  [[YJBaseNetManager sharedBaseNetManager] netWorkPostWithURLString:[self.child baseURLString] parameter:params success:^(YJURLResponse *response) {
        
        if ([self.delegate respondsToSelector:@selector(baseApiDidSuccess:response:)]) {
            
            [self.delegate baseApiDidSuccess:self response:response];
        }
       if (self.successCallBack) {
           
           self.successCallBack(response);
       }
    } fail:^(YJURLResponse *response) {
        
        if (self.failCallBack) {
            
            self.failCallBack(response);
        }
        if ([self.delegate respondsToSelector:@selector(baseApiDidFail:response:)]) {
            
            [self.delegate baseApiDidFail:self response:response];
        }
        
    }];
}


#pragma mark - gettes
- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}
@end
