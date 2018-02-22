//
//  UserInfoVC.m
//  Demolibrarys
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "UserInfoVC.h"
#import "AboutViewController.h"

@interface UserInfoVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;

@property (nonatomic, strong) KIVTableViewProtocol *dataSource;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoImageView.layer.cornerRadius = 50;

    self.view.backgroundColor = [UIColor whiteColor];
    [self dataHandle];
    [self network];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dataHandle
{
    KIVTVCellSection *section = [KIVTVCellSection new];
    
    KIVTVCellItem *row1 = [KIVTVCellItem new];
    row1.itemData = @"关于";
    row1.itemClassName = @"UserInfoTVCell";
    row1.height = 60;
    WEAKSElF;
    row1.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
        STRONGSELF;
        [self goToItemVCWithKey:@"aboutvc"];
    };
    [section addItem:row1];
    
    KIVTVCellItem *row2 = [KIVTVCellItem new];
    row2.itemData = @"用户建议";
    row2.height = 60;
    row2.itemClassName = @"UserInfoTVCell";
    row2.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
        [self goToItemVCWithKey:@"advicevc"];
    };
    [section addItem:row2];
    
    KIVTVCellItem *row3 = [KIVTVCellItem new];
    row3.itemData = @"主题";
    row3.height = 60;
    row3.itemClassName = @"UserInfoTVCell";
    [section addItem:row3];
    
    KIVTVCellItem *row4 = [KIVTVCellItem new];
    row4.itemData = @"设置";
    row4.height = 60;
    row4.itemClassName = @"UserInfoTVCell";
    [section addItem:row4];
    
    KIVTVCellItem *row5 = [KIVTVCellItem new];
    row5.itemData = @"其他";
    row5.height = 60;
    row5.itemClassName = @"UserInfoTVCell";
    [section addItem:row5];
    
    [self.tableView addSections:@[section]];
    [self.tableView registeKivProtocol:self.dataSource];
    [self.tableView kiv_reloadData];
    
}


#pragma mark - Accessor
- (KIVTableViewProtocol *)dataSource
{
    if(!_dataSource){
        _dataSource = [KIVTableViewProtocol new];
    }
    return _dataSource;
}

#pragma mark - Action
- (void)goToItemVCWithKey:(NSString *)moduleKey
{
    [self dismissViewControllerAnimated:NO completion:^{
        [[KIVRouter sharedInstance] routeToModulesOfKey:moduleKey];
    }];
}

- (void)network
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.baseURL = [NSURL URLWithString:@""];
    
}
@end
