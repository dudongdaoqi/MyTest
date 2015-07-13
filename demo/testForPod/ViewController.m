//
//  ViewController.m
//  testForPod
//
//  Created by lc on 15/7/13.
//  Copyright (c) 2015年 xulicheng. All rights reserved.
//

#import "ViewController.h"
#import "LCVersionCompare.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LCVersionCompare *v = [LCVersionCompare new];
    [v versionDataParse:nil];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
