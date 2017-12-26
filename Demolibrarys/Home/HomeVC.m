//
//  HomeVC.m
//  Demolibrarys
//
//  Created by kivan on 12/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "HomeVC.h"
#import "PureLayout.h"
#import "KIVCVDataSource.h"
#import "KIVCVBaseItem.h"
#import "KIVColor.h"

#import "HomeVC+DataHandle.h"

@interface HomeVC ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) KIVCVDataSource *dataDelegate;

//@property (nonatomic, strong) NSMutableArray *items
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConstrainConfig];
    [self navigationConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewConstrainConfig
{
    [self.view addSubview:self.collectionView];
    [self.collectionView autoPinEdgesToSuperviewEdges];
    
    self.dataDelegate = [KIVCVDataSource new];
    self.collectionView.delegate = self.dataDelegate;
    self.collectionView.dataSource = self.dataDelegate;
    
    [self refreshCollectionViewWihtType:HomeListCellType];
}

#pragma mark - Configeration
- (void)navigationConfig
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 20)];
    [rightButton setTitle:@"方格" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightNaviBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - Accessor
- (UICollectionView *)collectionView
{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
//        layout.itemSize = CGSizeMake(200, 200);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [KIVColor hex:@"#eeeeee"];
    }
    return _collectionView;
}

#pragma mark - Action
- (void)rightNaviBarButtonAction:(UIButton *)button
{
    if(!button.selected){
        [self refreshCollectionViewWihtType:HomeItemCellType];
        [button setTitle:@"列表" forState:UIControlStateNormal];
    }else{
        [self refreshCollectionViewWihtType:HomeListCellType];
        [button setTitle:@"方格" forState:UIControlStateNormal];
    }
    button.selected = !button.selected;
}

@end
