//
//  YJGlobleNetworkConfig.m
//  YJNetworking
//
//  Created by yj on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJGlobleNetworkConfig.h"

@implementation YJGlobleNetworkConfig
+ (instancetype)sharedGlobeNetworkConfig {

    static YJGlobleNetworkConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    
    return instance;
}
@end
