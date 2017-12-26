//
//  KIVLogMainCell.m
//  Demolibrarys
//
//  Created by kivan on 24/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVLogMainCell.h"
#import "KIVTogetherTouchRecogizer.h"
#import "DemoLogVO.h"
#import "KIVDSBaseSection.h"
#import "FolderListItem.h"
#import "ArticleListItem.h"
#import "ElementInfo.h"

@interface KIVLogMainCell ()<KIVTogetherTouchRecogizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logIconImageView;
@property (nonatomic, strong) KIVTogetherTouchRecogizer *touchr;
@end


@implementation KIVLogMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.touchr = [KIVTogetherTouchRecogizer new];
//    self.touchr.delegate = self;
//    [self.touchr registerTouchView:self];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateDataWithData:(id)aData
{
    ElementInfo *element = (ElementInfo *)aData;
    if (element.elementType == ElementInfoTypeOfFolder) {
//        FolderListItem *folder = (FolderListItem *)aData;
        self.descriptionLabel.text = @"文件夹";
        self.urlLabel.text = @"";
        self.backgroundColor = [UIColor yellowColor];
    }else if(element.elementType == ElementInfoTypeOfArticle){
        ArticleListItem *folder = (ArticleListItem *)aData;
        self.urlLabel.text = folder.aUrl;
        self.descriptionLabel.text = @"文章";
        self.backgroundColor = [UIColor whiteColor];
        
        NSData *iconURLData = [NSData dataWithContentsOfURL:[NSURL URLWithString:element.iconURI]];
        self.logIconImageView.image = [UIImage imageWithData:iconURLData];
    }
    self.titleLabel.text = element.title;
}

- (CGFloat)endGoBackWithTogetherTouch:(KIVTogetherTouchRecogizer *)toucher
{
    return 0.2;
}

- (void)endWithTogetherTouch:(KIVTogetherTouchRecogizer *)toucher
{
    
}


@end
