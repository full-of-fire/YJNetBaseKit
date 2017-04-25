//
//  YJNetworkCofig.h
//  YJNetworking
//
//  Created by yj on 17/2/9.
//  Copyright © 2017年 yj. All rights reserved.
//

#ifndef YJNetworkCofig_h
#define YJNetworkCofig_h

typedef NS_ENUM(NSUInteger, YJURLResponseStatus)
{
    YJURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的YJBaseApi来决定。
    YJURLResponseStatusFail,  //请网络失败具体失败原因根据由YJBaseApi根据errorCode去判断
    YJURLResponseStatusNoNetwork // 无网络错误。
};

static NSTimeInterval kYJNetworkingTimeoutSeconds = 4.5f; //设置超时时间

#endif /* YJNetworkCofig_h */
