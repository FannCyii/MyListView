//
//  KIVFloatViewController.m
//  Demolibrarys
//
//  Created by Fann on 20/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "KIVFloatViewController.h"

@interface KIVFloatViewController ()

@end

@implementation KIVFloatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 150)];
    [self.view addSubview:tempView];
    self.view.backgroundColor = [UIColor clearColor];
    tempView.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor greenColor];
    
    [button addTarget:self action:@selector(dissmissVC:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dissmissVC:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
