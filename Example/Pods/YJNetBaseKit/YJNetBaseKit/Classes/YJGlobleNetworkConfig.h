//
//  YJGlobleNetworkConfig.h
//  YJNetworking
//
//  Created by yj on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJGlobleNetworkConfig : NSObject
+ (instancetype)sharedGlobeNetworkConfig;
@property (copy,nonatomic) NSDictionary *universalParams;

@end
