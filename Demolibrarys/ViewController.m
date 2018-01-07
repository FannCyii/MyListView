//
//  ViewController.m
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController.h"
#import "SettingVC.h"
#import <PureLayout/PureLayout.h>
#import "ViewController+CellDelegate.h"
#import "ViewController+CollectionViewDataSourceDelegate.h"
#import "KIVCVDataSource.h"
#import "KIVArchiverManager.h"

//view
#import "KIVSearchHeaderView.h"

@interface ViewController ()<KIVCVDataSourceDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) KIVCVDataSource * dataSource;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) KIVSearchHeaderView * searchHeader;

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MY BOOKMARKS";
    
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"nav_right_button"] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [settingBtn addTarget:self action:@selector(selectedSetting:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [leftBtn setTitle:@"信息" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"nav_left_button"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn addTarget:self action:@selector(userInfoSetting:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    
    [self subViewConfig];
    [self handleMainData];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logsArchived:) name:NOTIFICATION_ARCHIVER_LOGS object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)subViewConfig
{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.searchHeader];
    
    [self.searchHeader autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
    [self.searchHeader autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.searchHeader autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.searchHeader autoSetDimension:ALDimensionHeight toSize:60];
    [self.collectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchHeader];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    self.collectionView.delegate = self.dataSource;
    self.collectionView.dataSource = self.dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Actions
- (void)selectedSetting:(UIButton *)button
{
    SettingVC *vc = [SettingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)userInfoSetting:(UIButton *)button
{
    [[KIVRouter sharedInstance] routeToModulesOfKey:@"userinfovc"];
}

#pragma mark - Accessors
- (UICollectionView *)collectionView
{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (KIVCVDataSource *)dataSource
{
    if(!_dataSource){
        _dataSource = [KIVCVDataSource new];
        _dataSource.delegate = self;
    }
    return _dataSource;
}

- (UITapGestureRecognizer *)tapGesture
{
    if(!_tapGesture){
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard:)];
    }
    return _tapGesture;
}

- (KIVSearchHeaderView *)searchHeader
{
    if (!_searchHeader) {
        _searchHeader = [[KIVSearchHeaderView alloc] initWithFrame:CGRectZero];
        _searchHeader.delegate = self;
    }
    return _searchHeader;
}



#pragma mark - Action
- (void)hiddenKeyBoard:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

- (void)logsArchived:(NSNotification *)notification
{
    if ([notification.name isEqualToString:NOTIFICATION_ARCHIVER_LOGS]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleMainData];
        });
    }
}

#pragma mark - KIVCVDataSourceDelegate
- (id)getTargetVCWihtDataSource:(KIVCVDataSource *)dataSource
{
    return self;
}


@end
