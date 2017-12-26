//
//  KIVDSBaseTVCell.m
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//

#import "KIVDSBaseTVCell.h"
#import "NSArray+SafeArray.h"
#import "KIVDSBaseSection.h"
#import "PureLayout/PureLayout.h"
#import "KIVColor.h"

@interface KIVDSBaseTVCell ()
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation KIVDSBaseTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self viewSetup];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self viewSetup];
    }
    return self;
}

- (void)viewSetup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.bottomLine];
    [self bringSubviewToFront:self.bottomLine];
    [self.bottomLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.5];
}

- (void)updateDataWithData:(id)aData
{
    if([NSStringFromClass([self class]) isEqualToString:@"KIVDSBaseTVCell"]){
        if([aData isKindOfClass:[NSString class]]){
            self.textLabel.text = (NSString *)aData;
        }
    }
}

- (UIView *)bottomLine
{
    if(!_bottomLine){
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [KIVColor hex:@"#ECECEC"];
    }
    return _bottomLine;
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)setHiddenBottomLine:(BOOL)hiddenBottomLine
{
    self.bottomLine.hidden = hiddenBottomLine;
}

- (void)didSelectedWithSection:(KIVDSBaseSection *)section index:(NSUInteger)index
{
    //override
}

@end
