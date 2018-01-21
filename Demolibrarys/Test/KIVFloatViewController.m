//
//  KIVFloatViewController.m
//  Demolibrarys
//
//  Created by Fann on 20/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "KIVFloatViewController.h"
//#import "UITableView+KIVListHandle.h"

@interface KIVFloatViewController ()

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) KIVTableViewProtocol *protocol;

@property (nonatomic, strong) UIView *triangleView;

@end

@implementation KIVFloatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.triangleView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 13, 10)];
    [self.view addSubview:self.triangleView];
    self.triangleView.backgroundColor = [UIColor clearColor];
    
//    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    
    [self drawTriangle];
    [self subViewConfig];
    [self dataHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dissmissVC:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)subViewConfig
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
    
}

- (void)dataHandle
{
    KIVTableViewProtocol *protocol = [KIVTableViewProtocol new];
    [self.tableView registeKivProtocol:protocol];
    
    KIVTVCellSection *section = [KIVTVCellSection new];
    WEAKSElF
    section.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
        STRONGSELF
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    for (int i = 0; i<5; ++i) {
        KIVTVCellItem *item = [KIVTVCellItem new];
        item.itemClassName = @"KIVFloatTVCell";
        item.height = 30;
        item.itemData = @"选项";
        [section addItem:item];
    }
    
    [self.tableView addSections:@[section].mutableCopy];
    [self.tableView kiv_reloadData];
}

- (void)drawTriangle {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat x = 70;
    //绘制三角形的三个顶点，自己算，能连成三角形就行啦！
    [path moveToPoint:CGPointMake(x, 0)];
    [path addLineToPoint:CGPointMake(x-7, 10)];
    [path addLineToPoint:CGPointMake(x+7, 10)];
    //连接三个点
    [path closePath];
    layer.path = path.CGPath;
    //填充图形颜色
    layer.fillColor = [UIColor whiteColor].CGColor;
    //图形变现颜色
    layer.strokeColor = [UIColor whiteColor].CGColor;
    //self.drawView,自己定义一个View，继承UIView
    [self.triangleView.layer addSublayer:layer];
}


@end
