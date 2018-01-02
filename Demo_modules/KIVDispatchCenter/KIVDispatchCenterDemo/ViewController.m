//
//  ViewController.m
//  KIVDispatchCenterDemo
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "ViewController.h"
#import "KIVDispatchCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[KIVRouter sharedInstance] registeRootVC:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)button1Action:(UIButton *)button
{
    NSString *class = [[KIVRouter sharedInstance] routeClassNameForkey:@"test1vc"];
    UIViewController *vc = [NSClassFromString(class) new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)buttonAction2:(UIButton *)sender {
    NSDictionary *dir = @{@"aaa":@"bbb"};
    [[KIVRouter sharedInstance] routeToModulesOfKey:@"test1vc" withParams:dir];
}

@end
