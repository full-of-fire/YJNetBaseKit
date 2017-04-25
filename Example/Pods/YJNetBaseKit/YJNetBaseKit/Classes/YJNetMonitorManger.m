//
//  YJNetMonitorManger.m
//  YJNetworking
//
//  Created by yj on 17/2/9.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJNetMonitorManger.h"
#import "AFNetworking.h"
@interface YJNetMonitorManger ()<UIAlertViewDelegate>

@property (strong,nonatomic) AFNetworkReachabilityManager *reachabiltyManger;
@end

@implementation YJNetMonitorManger

+ (instancetype)sharedNetMonitorManager {

    static YJNetMonitorManger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
        
    });
    
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.reachabiltyManger = [AFNetworkReachabilityManager sharedManager];
    }
    return self;
}

- (void)start {

    [self.reachabiltyManger startMonitoring];
    
    __weak typeof(self) weakSelf = self;
    [self.reachabiltyManger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        if (weakSelf.netChangeBlock) {
            
            weakSelf.netChangeBlock((NSInteger)status);
        }
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
        
                [weakSelf showWarningView];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"未知wifi");
            {
                NSArray *subviewArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
                int type = 0;
                for (id subview in subviewArray)
                {
                    if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")])
                    {
                        type = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
                    }
                }
                switch (type) {
                    case 1:
                        NSLog(@"2G网络");
                        break;
                    case 2:
                        NSLog(@"3G网络");
                        break;
                        
                    case 3:
                        NSLog(@"4G网络");
                        break;
                        
                    default:
                        break;
                }
                
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机网络");
                break;
                
            default:
                break;
        }

        
    }];
}


- (void)stop {

    [self.reachabiltyManger stopMonitoring];
}


- (BOOL)isReachable {

    return [self.reachabiltyManger isReachable];
}



- (void)dealloc{

    [self stop];
}

#pragma mark - private
-(void)showWarningView
{
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络断开，请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
    [alter show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSLog(@"取消");
    }else{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

@end
