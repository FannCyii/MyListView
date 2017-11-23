//
//  ViewController.m
//  Demolibrarys
//
//  Created by kivan on 16/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController.h"
#import "DemoTVC.h"
#import "KIVLogVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToTVCAction:(UIButton *)sender {
    DemoTVC *tvc = [DemoTVC new];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (IBAction)goToListLogAction:(UIButton *)sender {
    KIVLogVC *tvc = [KIVLogVC new];
    [self.navigationController pushViewController:tvc animated:YES];
}

@end
