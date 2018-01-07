//
//  KIVSearchHeaderView.h
//  Demolibrarys
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KIVSearchHeaderView;
@protocol KIVSearchHeaderViewDelegate <NSObject>
- (void)kivSearchHeaderView:(KIVSearchHeaderView *)view didReturnWihtTextField:(UITextField *)textField;
@end

@interface KIVSearchHeaderView : UIView

@property (nonatomic, weak) id<KIVSearchHeaderViewDelegate> delegate;

@end
