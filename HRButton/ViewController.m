//
//  ViewController.m
//  HRButton
//
//  Created by 王凯 on 2016/10/21.
//  Copyright © 2016年 王凯. All rights reserved.
//

#import "ViewController.h"
#import "HRButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HRButton *control = [[HRButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)
                                                    img:[UIImage imageNamed:@"demoImg"]
                                                    txt:@"哈哈"
                                         forControlType:HRControlTypeForNormal];
    [control setBackgroundColor:[UIColor blackColor]];
    [control setClearance:5];
    [control setTxtFont:[UIFont systemFontOfSize:10]];
//    [control setLeftSpace:5];
//    [control setRightSpace:5];
//    [control addTarget:self action:@selector(ddddddddddddd)];
    [control addAction:^(id obj) {
        NSLog(@"dddddddd");
    }];

//    [control setBackgroundImage:[UIImage imageNamed:@"demoImg"]];
    [self.view addSubview:control];
}
- (void)ddddddddddddd {
    NSLog(@"cccccccccc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
