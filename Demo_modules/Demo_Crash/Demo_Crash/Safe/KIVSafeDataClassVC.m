//
//  KIVSafeDataClassVC.m
//  Demo_AOP_Crash
//
//  Created by kivan on 31/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVSafeDataClassVC.h"

@interface KIVSafeDataClassVC ()

@end

@implementation KIVSafeDataClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4"];
    NSLog(@"%@",array[0]);
    NSLog(@"%@",array[1]);
    NSLog(@"%@",array[2]);
    NSLog(@"%@",array[3]);
    NSLog(@"%@",array[4]);
    
    NSLog(@"%@",[array objectAtIndex:5]);
    
    
    NSLog(@"%@",[array subarrayWithRange:NSMakeRange(0,10)]);
    NSLog(@"%@",[array subarrayWithRange:NSMakeRange(0,3)]);
    NSLog(@"%@",[array subarrayWithRange:NSMakeRange(2,10)]);
    NSLog(@"%@",[array subarrayWithRange:NSMakeRange(4,10)]);
    NSLog(@"%@",[array subarrayWithRange:NSMakeRange(5,10)]);
    NSLog(@"%@",[array subarrayWithRange:NSMakeRange(5,2)]);
    
    NSString *str[3];
    str[0] = @"abc";
    str[1] = @"abc";
    str[2] = @"abc";
    NSLog(@"%@",[NSArray arrayWithObject:nil]);
    
//    NSLog(@"%@",[NSArray arrayWithObjects:str count:5]);
    
    NSLog(@"%lu",(unsigned long)[array indexOfObject:nil]);
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

@end
