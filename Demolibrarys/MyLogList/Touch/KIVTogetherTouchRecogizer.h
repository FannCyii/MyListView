//
//  KIVTogetherTouchRecogizer.h
//  Demolibrarys
//
//  Created by kivan on 24/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KIVTogetherTouchRecogizer;
@protocol KIVTogetherTouchRecogizerDelegate <NSObject>
- (void)endWithTogetherTouch:(KIVTogetherTouchRecogizer *)toucher targetView:(UIView *)view;
- (CGFloat)endGoBackWithTogetherTouch:(KIVTogetherTouchRecogizer *)toucher;

@end


@interface KIVTogetherTouchRecogizer : NSObject

@property (nonatomic, weak) id<KIVTogetherTouchRecogizerDelegate> delegate;


- (void)registerTouchView:(UIView *)touchView;

@end
