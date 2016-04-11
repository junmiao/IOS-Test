//
//  ViewController.m
//  testMasonry
//
//  Created by jun on 16/4/8.
//  Copyright © 2016年 jun. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic,strong) UIButton * addButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self test1];
    //[self test2];
    [self test3];
    
}

- (void)test1
{
    UIView * v = [UIView new];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.center.mas_equalTo(self.view);
        //make.size.mas_equalTo(CGSizeMake(200, 100));
        
        //make.edges.mas_equalTo(self.view).width.insets(UIEdgeInsetsMake(10, 10, 20, 10));
        
        /*
         
         make.left.mas_equalTo(self.view).with.offset(10);
         make.top.mas_equalTo(self.view).with.offset(20);
         make.right.mas_equalTo(self.view).with.offset(-20);
         make.bottom.mas_equalTo(self.view).with.offset(-40);
         */
        
        make.top.left.bottom.right.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(5,5,5, 5));
    }];

}

- (void)test2
{
    UIView * v1 = [UIView new];
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];
    UIView * v2 = [UIView new];
    v2.backgroundColor = [UIColor redColor];
    [self.view addSubview:v2];
    
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).with.offset(10);
        make.right.mas_equalTo(v2.mas_left).with.offset(-30);
        make.height.mas_equalTo(self.view).with.offset(-100);
    
    }];
    
    [v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view).with.offset(-10);
        //make.left.mas_equalTo(v1.mas_right).
        make.height.mas_equalTo(@100);
        make.width.mas_equalTo(v1);
        
    }];
    
}

- (void)test3
{
    UIScrollView * sv = [UIScrollView new];
    sv.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        
    }];
    
    UIView * container = [UIView new];
    container.backgroundColor = [UIColor blueColor];
    [sv addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(sv);
        make.width.mas_equalTo(sv);
    }];
    
    UIView * lastV = nil;
    for(int i = 0;i<10;i++)
    {
        UIView * v = [UIView new];
        v.backgroundColor = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];
        [container addSubview:v];
        if(lastV)
        {
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(container);
                make.top.mas_equalTo(lastV.mas_bottom);
                make.height.mas_equalTo(@(20*(i+1)));
            }];
            
        }
        else
        {
            [v mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(container);
                make.top.mas_equalTo(@0);
                make.height.mas_equalTo(@(20*(i+1)));
            }];
            
        }
        lastV = v;
        
    }
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [lastV addSubview:self.addButton];
    [self.addButton addTarget:self action:@selector(onButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastV.mas_bottom);
    }];
    
    
}

- (void)onButtonDown:(UIView *)btn
{

    
    [btn.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(arc4random()%500));
    }];
    
    CGRect r = btn.frame;
    r.size.width = arc4random()%500;
    r.size.height = arc4random()%500;
    btn.frame = r;
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:1.3 animations:^{
        [self.view layoutIfNeeded];
        
    }];


    
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

@end
