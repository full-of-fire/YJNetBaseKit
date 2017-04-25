//
//  YJTestNetApiViewController.m
//  YJNetworking
//
//  Created by yj on 17/2/9.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJTestNetApiViewController.h"
#import <YJNetBaseKit/YJNetworking.h>
#import "YJTestApi.h"
@interface YJTestNetApiViewController ()<YJBaseApiCallBackDelegate>
@property (strong,nonatomic) YJTestApi *testApi;
@end

@implementation YJTestNetApiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //配置全局参数
    [YJGlobleNetworkConfig sharedGlobeNetworkConfig].universalParams = @{@"key":@"value"};
    
}



#pragma mark - YJBaseApiCallBackDelegate
- (void)baseApiDidSuccess:(YJBaseApi*)baseApi response:(YJURLResponse *)response {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功回调" message:@"请求成功" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    
    [alert show];
    NSLog(@"-----请求成功==%@",response.responseObject);
}

- (void)baseApiDidFail:(YJBaseApi *)baseApi response:(YJURLResponse *)response {
    
    
    if (response.status == YJURLResponseStatusNoNetwork) {
        
        NSLog(@"当前无网络");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败回调" message:@"当前无网络连接" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else{
        
        NSLog(@"-----请求失败==%@",response.error);
        
    }
    
}

- (IBAction)startApiAction:(id)sender {
    
    [self.testApi loadData];
}

- (IBAction)dismissAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark -  getters

- (YJTestApi*)testApi {
    
    if (_testApi  == nil) {
        
        YJTestApi *api = [[YJTestApi alloc] init];
        
        api.delegate = self;
        _testApi = api;
    }
    return _testApi;
}

@end
