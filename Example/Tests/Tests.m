//
//  YJNetBaseKitTests.m
//  YJNetBaseKitTests
//
//  Created by full-of-fire on 04/25/2017.
//  Copyright (c) 2017 full-of-fire. All rights reserved.
//

@import XCTest;
#import "YJTestApi.h"
#import <YJNetBaseKit/YJNetworking.h>
@interface Tests : XCTestCase<YJBaseApiCallBackDelegate>
@property (strong,nonatomic) YJTestApi *testApi;

@property (strong,nonatomic) XCTestExpectation *exp;
@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _testApi = [[YJTestApi alloc] init];
    
    _testApi.delegate = self;
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
    //测试用例的编写
    //1.设置变量和设置预期值
    int a = 10;
    int b = 14;
    int expected = 24;
    
    //2.获取实际的预期值
    int actual = [self add:a and:b];
    
    //3.断言
    
    XCTAssertEqual(expected, actual,@"测试不通过");
    
}

- (int)add:(int )a and:(int)b {

    return a + b;
}


// 异步测试的例子
- (void)testAsynExample1 {

    XCTestExpectation *exp = [self expectationWithDescription:@"异步测试失败"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        //模拟网络请求，需要两秒获取到数据
        sleep(2);
        
        // 2.获取到数据后的结果比较
        XCTAssertEqual(@"a", @"a");
        
        
        //3.如果断言没有问题就执行下面的方法
        [exp fulfill];
        
    });
    
    
    
    // 设置超时时间
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
       
        
        if (error) {
            
            NSLog(@"---error = %@",error);
        }
    }];
    
}


- (void)testNet {

    _exp = [self expectationWithDescription:@"异步网络情"];
    [_testApi loadData];
    
    // 设置超时时间
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        
        
        if (error) {
            
            NSLog(@"---error = %@",error);
        }
    }];
}

- (void)baseApiDidSuccess:(YJBaseApi*)baseApi response:(YJURLResponse*)response {

    
    XCTAssertNotNil(response);
    
    int code = [response.responseObject[@"code"] intValue];
    XCTAssertEqual(code , 0,@"测试不通过");
    
    [_exp fulfill];
    
    NSLog(@"---result = %@",response.responseObject);
}

- (void)baseApiDidFail:(YJBaseApi *)baseApi response:(YJURLResponse*)response {

    
}

@end

