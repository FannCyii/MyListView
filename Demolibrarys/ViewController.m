//
//  ViewController.m
//  Demolibrarys
//
//  Created by kivan on 16/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController.h"
#import "DemoTVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToTVCAction:(UIButton *)sender {
    DemoTVC *tvc = [DemoTVC new];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (void)test1
{
//    NSArray *array = @[@"1",@"ab",@"cdddds",@"ddasdd",@"eaaaaaa"];
//    ;
//    NSLog(@"%@",[array valueForKeyPath:@"length"]);
    
    NSDictionary *dir = @{@"ab":@"123",@"cd":@"3435",@"abc":@{@"a1b":@"abcahah"}};
    NSLog(@"===:%@",dir);
    NSLog(@"===:%@",[dir valueForKeyPath:@"@count"]);
    NSLog(@"===:%@",dir[@"a1b"]);
}

@end
