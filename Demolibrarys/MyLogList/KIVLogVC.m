//
//  KIVLogVC.m
//  Demolibrarys
//
//  Created by kivan on 24/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVLogVC.h"
#import "KIVDSDataSource.h"
#import "PureLayout.h"

#import "KIVWebVC.h"

@interface KIVLogVC ()

@property (nonatomic, strong) UITableView *mainListTV;
@property (nonatomic, strong) KIVDSDataSource *dataSouce;

@end

@implementation KIVLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
    [self dataConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configeration
- (void)viewConfig
{
    [self.view addSubview:self.mainListTV];
    self.mainListTV.backgroundColor = [UIColor grayColor];
    [self.mainListTV autoPinEdgesToSuperviewEdges];
}

- (void)dataConfig
{
    KIVDSBaseSection *section = [KIVDSBaseSection new];
    //这里可以优化成indexPath
    section.didSelectedBlock = ^(UITableView *tableView, KIVDSBaseSection *section, NSUInteger index) {
        KIVWebVC *webVc = [[KIVWebVC alloc] init];
        [self.navigationController pushViewController:webVc animated:YES];
    };
    
    for (int i  =10; i > 0; --i) {
        KIVDSBaseRow *row = [KIVDSBaseRow new];
        row.cellClassName = @"KIVLogMainCell";
        row.rowHeight = 90;
        [section insertRow:row];
    }
    
    [self.mainListTV addSection:section];
    
    [self.mainListTV refreshData];
}

#pragma mark - Accessor
- (UITableView *)mainListTV
{
    if(!_mainListTV){
        _mainListTV = [[UITableView alloc] initWithFrame:CGRectZero];
        _dataSouce = [KIVDSDataSource new];
        [_mainListTV registerKivDataSource:_dataSouce];
    }
    return _mainListTV;
}



@end
