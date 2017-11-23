//
//  DemoTVC.m
//  Demolibrarys
//
//  Created by kivan on 16/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "DemoTVC.h"
#import "KIVDSDataSource.h"
#import "DemoTVC+DataHandle.h"
#import "PureLayout/PureLayout.h"

@interface DemoTVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) KIVDSDataSource *dataSrouce;

@end

@implementation DemoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dataHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
