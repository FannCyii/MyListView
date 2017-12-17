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
#import "ViewController+CollectionViewDataSourceDelegate.h"
#import "KIVCVDataSource.h"

@interface ViewController ()
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) KIVCVDataSource * dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的书签管理";
    
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [settingBtn addTarget:self action:@selector(selectedSetting:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    
    [self subViewConfig];
    [self handleMainData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)selectedSetting:(UIButton *)button
{
    SettingVC *vc = [SettingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

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
    }
    return _dataSource;
}

- (void)subViewConfig
{
    [self.view addSubview:self.collectionView];
    [self.collectionView autoPinEdgesToSuperviewEdges];

    self.collectionView.delegate = self.dataSource;
    self.collectionView.dataSource = self.dataSource;
}

@end
