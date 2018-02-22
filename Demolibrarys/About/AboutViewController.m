//
//  AboutViewController.m
//  Demolibrarys
//
//  Created by Fann on 22/02/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [[KIVRouter sharedInstance] routeToModulesOfKey:@"mainvc"];
}


@end
