//
//  KIVLogVC.m
//  Demolibrarys
//
//  Created by kivan on 24/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVLogVC.h"
#import "KIVDSDataSource.h"
#import <PureLayout/PureLayout.h>
#import "Demo_Network.h"
#import "KIVWebVC.h"
#import "CommonHeader.h"
#import "FolderListItem.h"
#import "KIVArchiverManager.h"

@interface KIVLogVC () <DemoWebServerDelegate>

@property (nonatomic, strong) UITableView *mainListTV;
@property (nonatomic, strong) KIVDSDataSource *dataSouce;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation KIVLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.logsData) {
        self.logsTitle = self.logsData[LOGSTITLE];
        self.folder = self.logsData[LOGSCONTENT];
    }

    [self navigationConfig];
    [self viewConfig];
    [self dataConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Configeration
- (void)navigationConfig
{
    self.navigationItem.title = self.logsTitle;
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 20)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightNaviBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)viewConfig
{
    [self.view addSubview:self.mainListTV];
    [self.mainListTV autoPinEdgesToSuperviewEdges];
}

- (void)dataConfig
{
    FolderListItem *rootFolder = self.folder;
    KIVDSBaseSection *section = [KIVDSBaseSection new];
    //这里可以优化成indexPath
    WEAKSElF
    section.didSelectedBlock = ^(UITableView *tableView, KIVDSBaseSection *section, NSUInteger index) {
        STRONGSELF
        KIVDSBaseRow *row = [section.rows objectAtIndex:index];
        ElementInfo *element = (ElementInfo *)row.cellData;
        if(element.elementType == ElementInfoTypeOfFolder){
            KIVLogVC *logvc = [[KIVLogVC alloc] init];
            FolderListItem *item = (FolderListItem *)element;
            logvc.folder = item;
            logvc.logsTitle = rootFolder.title;
            [self.navigationController pushViewController:logvc animated:YES];
        }else{
            KIVWebVC *webVc = [[KIVWebVC alloc] init];
            webVc.url = element.aUrl;
            [self.navigationController pushViewController:webVc animated:YES];
        }
    };
  
    for (int i = 0; i < rootFolder.subElements.count; ++i) {
        KIVDSBaseRow *row = [KIVDSBaseRow new];
        row.cellClassName = @"KIVLogMainCell";
        ElementInfo *info = rootFolder.subElements[i];
        if(info.elementType == ElementInfoTypeOfFolder){
            row.rowHeight = 60;
        }else{
            row.rowHeight = 100;
        }
        row.cellData = info;
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

#pragma mark - Action
- (void)rightNaviBarButtonAction:(UIButton *)button
{
    if(!button.selected){
        [self.mainListTV setEditing:YES animated:YES];
        [button setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [self.mainListTV setEditing:NO animated:YES];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
    }
    button.selected = !button.selected;
}


@end
