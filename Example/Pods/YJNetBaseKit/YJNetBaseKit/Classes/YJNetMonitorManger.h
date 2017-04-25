//
//  YJNetMonitorManger.h
//  YJNetworking
//
//  Created by yj on 17/2/9.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,YJNetStatusType)
{
    YJNetStatusTypeUnkonw =-1,
    YJNetStatusTypeNotReachable,
    YJNetStatusTypeViaWWAN,
    YJNetStatusTypeViaWiFi
    
    
};
@interface YJNetMonitorManger : NSObject
// 通过下面属性获取前，保证start方法被调用
@property (assign,nonatomic,readonly,getter=isReachable) BOOL reachable;

@property (copy,nonatomic) void(^netChangeBlock)(YJNetStatusType status);
- (void)setNetChangeBlock:(void (^)(YJNetStatusType status))netChangeBlock;

+ (instancetype)sharedNetMonitorManager;

- (void)start;

- (void)stop;

@end
