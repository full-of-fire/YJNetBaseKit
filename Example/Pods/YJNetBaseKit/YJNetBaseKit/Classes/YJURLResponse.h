//
//  YJURLResponse.h
//  YJNetworking
//
//  Created by yj on 17/2/9.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNetworkCofig.h"
@interface YJURLResponse : NSObject

@property (assign,nonatomic,readonly) YJURLResponseStatus status;

@property (strong,nonatomic,readonly) id responseObject;

@property (strong,nonatomic,readonly) NSError *error;


- (instancetype)initWithResponseObject:(id)reponseObject status:(YJURLResponseStatus)status;

- (instancetype)initWithError:(NSError*)error Status:(YJURLResponseStatus)status;

@end
