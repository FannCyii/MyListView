//
//  KIVLogVC.m
//  Demolibrarys
//
//  Created by kivan on 24/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVLogVC.h"
#import <PureLayout/PureLayout.h>
#import "Demo_Network.h"
#import "CommonHeader.h"
#import "FolderListItem.h"
#import "KIVArchiverManager.h"

@interface KIVLogVC () <DemoWebServerDelegate>

@property (nonatomic, strong) UITableView *mainListTV;
@property (nonatomic, strong) KIVTableViewProtocol *dataSouce;
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
    KIVTVCellSection *section = [KIVTVCellSection new];
    //这里可以优化成indexPath
    WEAKSElF
    section.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
        STRONGSELF
        NSArray *sections = [(UITableView *)list sections];
        KIVTVCellSection *section = [sections objectAtIndex:indexPath.section];
        KIVTVCellItem *row = [section.items objectAtIndex:indexPath.row];
        ElementInfo *element = (ElementInfo *)row.itemData;
        if(element.elementType == ElementInfoTypeOfFolder){
            KIVLogVC *logvc = [[KIVLogVC alloc] init];
            FolderListItem *item = (FolderListItem *)element;
            logvc.folder = item;
            logvc.logsTitle = rootFolder.title;
            [self.navigationController pushViewController:logvc animated:YES];
        }else{
            //            KIVWebVC *webVc = [[KIVWebVC alloc] init];
            //            webVc.url = element.aUrl;
            //            [self.navigationController pushViewController:webVc animated:YES];
            
            KIVArchiverManager *manager = [[KIVArchiverManager alloc] initWithIdentifior:FOLDER_ARTICLE_READ_HISTORIES completeHandle:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ARCHIVER_HISTORIES object:nil];
            }];
            
            [manager saveLogs:element keyWord:element.title];
            
            NSDictionary *params =@{@"url":element.aUrl};
            [[KIVRouter sharedInstance] routeToModulesOfKey:@"webreadervc" withParams:params];
            
        }
    };
    
//
//    section.didSelectedBlock = ^(UITableView *tableView, KIVDSBaseSection *section, NSUInteger index) {
//        STRONGSELF
//        KIVDSBaseRow *row = [section.rows objectAtIndex:index];
//        ElementInfo *element = (ElementInfo *)row.cellData;
//        if(element.elementType == ElementInfoTypeOfFolder){
//            KIVLogVC *logvc = [[KIVLogVC alloc] init];
//            FolderListItem *item = (FolderListItem *)element;
//            logvc.folder = item;
//            logvc.logsTitle = rootFolder.title;
//            [self.navigationController pushViewController:logvc animated:YES];
//        }else{
////            KIVWebVC *webVc = [[KIVWebVC alloc] init];
////            webVc.url = element.aUrl;
////            [self.navigationController pushViewController:webVc animated:YES];
//
//            KIVArchiverManager *manager = [[KIVArchiverManager alloc] initWithIdentifior:FOLDER_ARTICLE_READ_HISTORIES completeHandle:^{
//                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ARCHIVER_HISTORIES object:nil];
//            }];
//
//            [manager saveLogs:element keyWord:element.title];
//
//            NSDictionary *params =@{@"url":element.aUrl};
//            [[KIVRouter sharedInstance] routeToModulesOfKey:@"webreadervc" withParams:params];
//
//        }
//    };
  
    for (int i = 0; i < rootFolder.subElements.count; ++i) {
        KIVTVCellItem *row = [KIVTVCellItem new];
        row.itemClassName = @"KIVLogMainCell";
        ElementInfo *info = rootFolder.subElements[i];
        if(info.elementType == ElementInfoTypeOfFolder){
            row.height = 60;
        }else{
            row.height = 100;
        }
        row.itemData = info;
        [section addItem:row];
    }

    [self.mainListTV addSections:@[section]];
    [self.mainListTV kiv_reloadData];
}
#pragma mark - Accessor
- (UITableView *)mainListTV
{
    if(!_mainListTV){
        _mainListTV = [[UITableView alloc] initWithFrame:CGRectZero];
        _dataSouce = [KIVTableViewProtocol new];
        [_mainListTV registeKivProtocol:_dataSouce];
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
