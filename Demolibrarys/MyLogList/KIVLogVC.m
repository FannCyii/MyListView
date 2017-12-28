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

@interface KIVLogVC () <DemoWebServerDelegate>

@property (nonatomic, strong) UITableView *mainListTV;
@property (nonatomic, strong) KIVDSDataSource *dataSouce;
//@property (nonatomic, strong) Demo_Network *network;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation KIVLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationConfig];
    [self viewConfig];
    
    [self dataConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configeration
- (void)navigationConfig
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 20)];
    rightButton.backgroundColor = [UIColor brownColor];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightNaviBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)viewConfig
{
    [self.view addSubview:self.mainListTV];
    self.mainListTV.backgroundColor = [UIColor grayColor];
    [self.mainListTV autoPinEdgesToSuperviewEdges];
    
//    self.mainListTV.gestureRecognizers = self.tapGesture;
}

- (void)dataConfig
{
    [self listDemo];
}

- (void)listDemo
{
    FolderListItem *rootFolder = nil;
    if(!self.folder){
        NSData *folderData = [[NSUserDefaults standardUserDefaults] objectForKey:FOLDER_ARTICLE_ARCHIVER_IDENTIFIOR];
        rootFolder = (FolderListItem *)[NSKeyedUnarchiver unarchiveObjectWithData:folderData];
    }else{
        rootFolder = self.folder;
    }
    
    KIVDSBaseSection *section = [KIVDSBaseSection new];
    //这里可以优化成indexPath
    section.didSelectedBlock = ^(UITableView *tableView, KIVDSBaseSection *section, NSUInteger index) {
        KIVDSBaseRow *row = [section.rows objectAtIndex:index];
        ElementInfo *element = (ElementInfo *)row.cellData;
        if(element.elementType == ElementInfoTypeOfFolder){
            KIVLogVC *logvc = [[KIVLogVC alloc] init];
            FolderListItem *item = (FolderListItem *)element;
            logvc.folder = item;
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
