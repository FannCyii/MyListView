//
//  KIVHomeBrowserVC.m
//  KIVBrowserKit
//
//  Created by Fann on 14/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVHomeBrowserVC.h"
#import "KIVHomeBottomView.h"

@interface KIVHomeBrowserVC ()
@property (weak, nonatomic) IBOutlet KIVHomeBottomView *buttomView;

@end

@implementation KIVHomeBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSBundle *bundle = [[NSBundle mainBundle] URLForResource:@"KIVBrowserKitBundle" withExtension:@"bundle"];
    
    
    
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
