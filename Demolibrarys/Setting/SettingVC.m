//
//  SettingVC.m
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "SettingVC.h"
#import "KIVCVDataSource.h"

#import "KIVWebVC.h"
#import "KIVLogVC.h"
#import "DemoWebServerVC.h"
#import "HomeVC.h"
#import <PureLayout/PureLayout.h>

@interface SettingVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KIVDSDataSource *dataSource;
@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdges];
    
    [self settingData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        [_tableView registerKivDataSource:self.dataSource];
    }
    return _tableView;
}

- (KIVDSDataSource *)dataSource
{
    if(!_dataSource){
        _dataSource = [KIVDSDataSource new];
    }
    return _dataSource;
}

- (void)settingData
{
    KIVDSBaseSection *settingList = [KIVDSBaseSection new];
    KIVDSBaseRow *logListRow = [KIVDSBaseRow new];
    logListRow.selectedBlock = ^(id listView, NSIndexPath *indexPath) {
        KIVLogVC *vc = [KIVLogVC new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    logListRow.rowHeight = 45;
    logListRow.cellData = @"书签列表";
    [settingList insertRow:logListRow];
    
    KIVDSBaseRow *serverRow = [KIVDSBaseRow new];
    serverRow.selectedBlock = ^(id listView, NSIndexPath *indexPath) {
        DemoWebServerVC *vc = [DemoWebServerVC new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    serverRow.rowHeight = 45;
    serverRow.cellData = @"导入数据";
    [settingList insertRow:serverRow];
    
    KIVDSBaseRow *homeRow = [KIVDSBaseRow new];
    homeRow.selectedBlock = ^(id listView, NSIndexPath *indexPath) {
        HomeVC *vc = [HomeVC new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    homeRow.rowHeight = 45;
    homeRow.cellData = @"首页";
    [settingList insertRow:homeRow];
    
    [self.tableView addSection:settingList];
    [self.tableView refreshData];
}

@end
