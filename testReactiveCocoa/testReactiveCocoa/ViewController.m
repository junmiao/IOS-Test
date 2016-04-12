//
//  ViewController.m
//  testReactiveCocoa
//
//  Created by jun on 16/4/12.
//  Copyright © 2016年 jun. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (nonatomic,strong) NSString * text;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //leak?
    [self performSelector:NSSelectorFromString(@"aaaaa")];
    
    NSLog(@"testfun %@",[self performSelector:@selector(testFun)]);
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
    
    btn.center = CGPointMake(100, 100);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"touch up inside");
    }];
    
    self.text = @"hello";
    [RACObserve(self, text) subscribeNext:^(id x) {
        NSLog(@"text change %@",x);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)testFun
{
    return [UIView new];
}

@end
