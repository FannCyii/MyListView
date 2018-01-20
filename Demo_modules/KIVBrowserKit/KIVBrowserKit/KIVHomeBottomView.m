//
//  KIVHomeBottomView.m
//  KIVBrowserKit
//
//  Created by Fann on 14/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVHomeBottomView.h"
#import <PureLayout/PureLayout.h>

@interface KIVHomeBottomView()

@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * advanceButton;
@property (nonatomic, strong) UIButton * homeButton;
@property (nonatomic, strong) UIButton * addPageButton;
@property (nonatomic, strong) UIView * centerView;

@property (nonatomic, strong) UIImageView *backgroundIV;

@end

@implementation KIVHomeBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self subViewsConfig];
    }
    return self;
}

- (void)subViewsInit
{
    self.backgroundIV = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.backgroundIV.backgroundColor = [UIColor grayColor];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.backButton setTitle:@"<返回" forState:UIControlStateNormal];
    
    self.advanceButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.backButton setTitle:@"前进>" forState:UIControlStateNormal];
    
    self.homeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.backButton setTitle:@"首页H" forState:UIControlStateNormal];
    
    self.addPageButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.backButton setTitle:@"添加+" forState:UIControlStateNormal];
    
    self.centerView = [[UIButton alloc] initWithFrame:CGRectZero];
    self.centerView.backgroundColor = [UIColor yellowColor];
    
    [self addSubview:self.backgroundIV];
    [self addSubview:self.backButton];
    [self addSubview:self.advanceButton];
    [self addSubview:self.homeButton];
    [self addSubview:self.addPageButton];
    [self addSubview:self.centerView];
    
}

- (void)subViewsConfig
{
    
    [self.backgroundIV autoPinEdgesToSuperviewEdges];
    
    [self.centerView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.centerView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.centerView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.centerView autoSetDimension:ALDimensionWidth toSize:50];
    
    
    
}

@end
