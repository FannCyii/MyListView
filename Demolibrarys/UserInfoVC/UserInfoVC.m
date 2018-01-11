//
//  UserInfoVC.m
//  Demolibrarys
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "UserInfoVC.h"

@interface UserInfoVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;

@property (nonatomic, strong) KIVDSDataSource *dataSource;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoImageView.layer.cornerRadius = 50;

    self.view.backgroundColor = [UIColor whiteColor];
    [self dataHandle];
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
    KIVDSBaseSection *section = [KIVDSBaseSection new];
    
    KIVDSBaseRow *row1 = [KIVDSBaseRow new];
    row1.cellData = @"关于";
    row1.cellClassName = @"UserInfoTVCell";
    row1.rowHeight = 60;
    [section insertRow:row1];
    
    KIVDSBaseRow *row2 = [KIVDSBaseRow new];
    row2.cellData = @"用户建议";
    row2.rowHeight = 60;
    row2.cellClassName = @"UserInfoTVCell";
    [section insertRow:row2];
    
    KIVDSBaseRow *row3 = [KIVDSBaseRow new];
    row3.cellData = @"主题";
    row3.rowHeight = 60;
    row3.cellClassName = @"UserInfoTVCell";
    [section insertRow:row3];
    
    KIVDSBaseRow *row4 = [KIVDSBaseRow new];
    row4.cellData = @"设置";
    row4.rowHeight = 60;
    row4.cellClassName = @"UserInfoTVCell";
    [section insertRow:row4];
    
    KIVDSBaseRow *row5 = [KIVDSBaseRow new];
    row5.cellData = @"其他";
    row5.rowHeight = 60;
    row5.cellClassName = @"UserInfoTVCell";
    [section insertRow:row5];
    
    [self.tableView addSection:section];
    [self.tableView registerKivDataSource:self.dataSource];
    [self.tableView refreshData];
    
}


#pragma mark - Accessor
- (KIVDSDataSource *)dataSource
{
    if(!_dataSource){
        _dataSource = [KIVDSDataSource new];
    }
    return _dataSource;
}
@end
