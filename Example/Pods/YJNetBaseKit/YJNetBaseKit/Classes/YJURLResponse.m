//
//  YJURLResponse.m
//  YJNetworking
//
//  Created by yj on 17/2/9.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJURLResponse.h"

@interface YJURLResponse ()

@property (assign,nonatomic,readwrite) YJURLResponseStatus status;
@property (strong,nonatomic,readwrite) id responseObject;
@property (strong,nonatomic,readwrite) NSError *error;
@end

@implementation YJURLResponse

- (instancetype)initWithResponseObject:(id)responseObject status:(YJURLResponseStatus)status{

    
    if (self = [super init]) {
        
        self.responseObject = responseObject;
        self.status = status;
        self.error = nil;
    }
    
    return self;
}


- (instancetype)initWithError:(NSError*)error Status:(YJURLResponseStatus)status {

    
    if (self = [super init]) {
        
        self.responseObject = nil;
        self.status = status;
        self.error = error;
    }
    
    return self;
    
}


@end
