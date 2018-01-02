//
//  VC1.m
//  KIVDispatchCenterDemo
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "VC1.h"
#import "KIVRouter.h"

@interface VC1 ()

@end

@implementation VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.routerParamsDir) {
        NSLog(@"self.routerhandleBlock:%@",self.routerParamsDir);
    }
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
