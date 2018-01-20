//
//  KIVBrowserTBC.m
//  KIVBrowserKit
//
//  Created by Fann on 14/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVBrowserTBC.h"

@interface KIVBrowserTBC ()

@end

@implementation KIVBrowserTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *vcarray = [NSMutableArray array];
    for (int i = 10; i > 0; --i) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor colorWithWhite:0.1*i alpha:1];
        vc.title = [NSString stringWithFormat:@"%f",0.1*i];
        [vcarray addObject:vc];
    }
    self.viewControllers = vcarray;
    
    
    
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
