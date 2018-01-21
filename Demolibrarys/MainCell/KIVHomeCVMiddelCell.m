//
//  KIVHomeCVMiddelCell.m
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVHomeCVMiddelCell.h"
#import <PureLayout/PureLayout.h>
#import "KIVLogVC.h"
#import "KIVArchiverManager.h"
#import "CommonHeader.h"

@interface KIVHomeCVMiddelCell ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) KIVCollectionViewProtocol * dataSource;

@end

@implementation KIVHomeCVMiddelCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self.contentView addSubview:self.collectionView];
        [self.collectionView autoPinEdgesToSuperviewEdges];
        self.collectionView.delegate = self.dataSource;
        self.collectionView.dataSource = self.dataSource;
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logsArchived:) name:NOTIFICATION_ARCHIVER_LOGS object:nil];
    }
    return self;
}

-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self dataHandel];
}

//- (void)logsArchived:(NSNotification *)notification
//{
//    if ([notification.name isEqualToString:NOTIFICATION_ARCHIVER_LOGS]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self dataHandel];
//        });
//    }
//}

- (void)dataHandel
{
    KIVArchiverManager *archiverManager = [[KIVArchiverManager alloc] initWithIdentifior:FOLDER_ARTICLE_ARCHIVER_IDENTIFIOR];
    NSArray *logsCollections = [archiverManager getAllLogs];
    KIVCVCellSection *array = [KIVCVCellSection new];
    //独立的一个item 用于google搜索
    KIVCVCellItem *itemGoogle = [KIVCVCellItem new];
    itemGoogle.itemClassName = @"kivMiddleItemCell";
    itemGoogle.height = 100;
    itemGoogle.width = 80;
//    itemGoogle.rowColor = [UIColor yellowColor];
    itemGoogle.itemData = @"Google搜索";
    itemGoogle.delegateTarget = self;
    [array addItem:itemGoogle];
    
    WEAKSElF
    itemGoogle.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
        STRONGSELF
        if([self.delegate respondsToSelector:@selector(kivHomeCVMiddelCell:selectedIndexPath:cellData:)]){
            NSDictionary *aData = logsCollections[indexPath.row ];
            if (![aData isKindOfClass:[NSDictionary class]]) {
                aData = nil;
            }
            [self.delegate kivHomeCVMiddelCell:self selectedIndexPath:indexPath cellData:aData];
        }
    };
    
    for (NSInteger i = 0; i < logsCollections.count; ++i) {
        KIVCVCellItem *item = [KIVCVCellItem new];
        item.itemClassName = @"kivMiddleItemCell";
        item.height = 100;
        item.width = 78;
//        item.rowColor = [UIColor yellowColor];
        NSDictionary *dirData = logsCollections[i];
        item.itemData = [dirData objectForKey:LOGSTITLE];
        
        WEAKSElF
        item.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
            STRONGSELF
            if([self.delegate respondsToSelector:@selector(kivHomeCVMiddelCell:selectedIndexPath:cellData:)]){
                NSDictionary *aData = logsCollections[indexPath.row -1];
                if (![aData isKindOfClass:[NSDictionary class]]) {
                    aData = nil;
                }
                [self.delegate kivHomeCVMiddelCell:self selectedIndexPath:indexPath cellData:aData];
            }
        };
        
        [array addItem:item];
    }
    
    [self.collectionView registeKivProtocol:self.dataSource];
    [self.collectionView addSection:array];
    [self.collectionView kiv_reloadData];
}

#pragma mark - Accessor
- (UICollectionView *)collectionView
{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
//        layout.itemSize = CGSizeMake(60, 60);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;

    }
    return  _collectionView;
}

- (KIVCollectionViewProtocol *)dataSource
{
    if(!_dataSource){
        _dataSource = [KIVCollectionViewProtocol new];
//        _dataSource.delegate = self;
    }
    return _dataSource;
}

#pragma mark -updata
- (void)updateCellWithItem:(KIVCVCellItem *)item
{
    self.delegate = item.delegateTarget;
}

#pragma mark - KIVCVDataSourceDelegate
- (id)getTargetVCWihtDataSource:(KIVCollectionViewProtocol *)dataSource
{
    return self;
}


@end
