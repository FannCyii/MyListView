//
//  KIVHomeCVMiddelCell.m
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVHomeCVMiddelCell.h"
#import <PureLayout/PureLayout.h>
#import "KIVCVDataSource.h"
#import "UICollectionView+KIVDS.h"
#import "KIVLogVC.h"

@interface KIVHomeCVMiddelCell () <KIVCVDataSourceDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) KIVCVDataSource * dataSource;

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
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 5; ++i) {
        KIVCVBaseItem *item = [KIVCVBaseItem new];
        item.cellClassName = @"kivMiddleItemCell";
        item.height = 60;
        item.with = 60;
        item.rowColor = [UIColor purpleColor];
        
        __weak typeof(self)weakSelf = self;
        item.selectedBlock = ^(id listView, NSIndexPath *indexPath) {
            NSLog(@"%ld",indexPath.row);
            __strong typeof(weakSelf)self = weakSelf;
            if([self.delegate respondsToSelector:@selector(kivHomeCVMiddelCell:selectedIndexPath:)]){
                [self.delegate kivHomeCVMiddelCell:self selectedIndexPath:indexPath];
            }
        };
        
        [array addObject:item];
    }
    
    [self.collectionView registerItmes:array];
    self.dataSource.itemArray = array;
    [self.collectionView reloadData];
}

#pragma mark - Accessor
- (UICollectionView *)collectionView
{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(60, 60);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor yellowColor];

    }
    return  _collectionView;
}

- (KIVCVDataSource *)dataSource
{
    if(!_dataSource){
        _dataSource = [KIVCVDataSource new];
        _dataSource.delegate = self;
    }
    return _dataSource;
}

#pragma mark -updata
- (void)updataCVCellWithData:(id)aData
{
    
}

#pragma mark - KIVCVDataSourceDelegate
- (id)getTargetVCWihtDataSource:(KIVCVDataSource *)dataSource
{
    return self;
}


@end
