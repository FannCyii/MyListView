//
//  KIVSearchHeaderView.m
//  Demolibrarys
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "KIVSearchHeaderView.h"

@interface KIVSearchHeaderView()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *backgroudImageView;
@property (nonatomic, strong) UIImageView *searchIconImageView;
@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation KIVSearchHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self subViewConfig];
    }
    return self;
}

- (void)subViewConfig
{
    [self addSubview:self.backgroudImageView];
    [self addSubview:self.searchIconImageView];
    [self addSubview:self.searchTextField];
    
    [self.backgroudImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.backgroudImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.backgroudImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.backgroudImageView autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.searchIconImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.searchIconImageView autoSetDimension:ALDimensionHeight toSize:13];
    [self.searchIconImageView autoSetDimension:ALDimensionWidth toSize:13];
    [self.searchIconImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:105];
    
    [self.searchTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.backgroudImageView];
    [self.searchTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.backgroudImageView];
    [self.searchTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.backgroudImageView];
    [self.searchTextField autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.backgroudImageView];
    
    
}

#pragma mark - Accessor
//@property (nonatomic, strong) UIImageView *backgroudImageView;
//@property (nonatomic, strong) UIImageView *searchIconImageView;
//@property (nonatomic, strong) UITextField *searchTextField;

- (UIImageView *)backgroudImageView
{
    if (!_backgroudImageView) {
        _backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backgroudImageView.image = [UIImage imageNamed:@"searchBackground"];
    }
    return _backgroudImageView;
}

- (UIImageView *)searchIconImageView
{
    if (!_searchIconImageView) {
        _searchIconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _searchIconImageView.image = [UIImage imageNamed:@"SearchIcon"];
    }
    return _searchIconImageView;
}

- (UITextField *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _searchTextField.textAlignment = NSTextAlignmentCenter;
        _searchTextField.placeholder = @"Search Article";
        _searchTextField.keyboardType = UIKeyboardTypeWebSearch;
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.delegate respondsToSelector:@selector(kivSearchHeaderView:didReturnWihtTextField:)]){
        [self.delegate kivSearchHeaderView:self didReturnWihtTextField:textField];
    }
    return YES;
}



@end
