//
//  YJBaseApi.h
//  YJNetworking
//
//  Created by yj on 17/1/16.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJBaseApi;
@class YJURLResponse;

typedef NS_ENUM(NSInteger,YJBaseApiRequestType) {

    YJBaseApiRequestTypeGet,  // get请求
    YJBaseApiRequestTypePost // post请求
};

// 请求结果的回调
@protocol YJBaseApiCallBackDelegate <NSObject>
@optional
- (void)baseApiDidSuccess:(YJBaseApi*)baseApi response:(YJURLResponse*)response;

- (void)baseApiDidFail:(YJBaseApi *)baseApi response:(YJURLResponse*)response;

@end

// 网络请求的子类必须遵守的协议
@protocol YJBaseApiDelegate <NSObject>

@required
- (NSString*)baseURLString;
- (YJBaseApiRequestType)requestType;


@optional
- (NSDictionary*)params;



@end


@interface YJBaseApi : NSObject

@property (weak,nonatomic) id<YJBaseApiCallBackDelegate> delegate;

@property (weak,nonatomic) NSObject<YJBaseApiDelegate> *child;


// 注意使用该方法，子类必须实现YJBaseApiDelegate协议中的- (NSDictionary*)params;
- (NSNumber*)loadData;

- (NSNumber*)loadDataWithParams:(NSDictionary*)params;

- (void)cancelRequestWithRequestId:(NSNumber*)requestId;

- (void)cancelAllRequest;

@end
