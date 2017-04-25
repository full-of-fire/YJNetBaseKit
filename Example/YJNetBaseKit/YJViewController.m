//
//  YJViewController.m
//  YJNetBaseKit
//
//  Created by full-of-fire on 04/25/2017.
//  Copyright (c) 2017 full-of-fire. All rights reserved.
//

#import "YJViewController.h"
#import "YJTestNetApiViewController.h"

@interface YJViewController ()

@end

@implementation YJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)presentTestApi:(id)sender {
    
    [self presentViewController:[YJTestNetApiViewController new] animated: YES completion:nil];
    
}

@end
