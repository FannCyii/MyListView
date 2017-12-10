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

@interface KIVLogMainCell ()<KIVTogetherTouchRecogizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
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
    NSLog(@"%@",aData);
    if([aData isKindOfClass:[DemoLogVO class]]){
        DemoLogVO *vo = (DemoLogVO *)aData;
        self.titleLabel.text = vo.logtitle;
        self.urlLabel.text = vo.logurl;
    }
}

- (CGFloat)endGoBackWithTogetherTouch:(KIVTogetherTouchRecogizer *)toucher
{
    return 0.2;
}

- (void)endWithTogetherTouch:(KIVTogetherTouchRecogizer *)toucher
{
    
}


@end
