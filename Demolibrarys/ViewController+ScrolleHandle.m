//
//  ViewController+ScrolleHandle.m
//  Demolibrarys
//
//  Created by Fann on 21/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "ViewController+ScrolleHandle.h"
#import "ViewController.h"
#import <PureLayout/PureLayout.h>
#import "ViewController+CellDelegate.h"
#import "ViewController+CollectionViewDataSourceDelegate.h"
#import "KIVArchiverManager.h"
#import "UserInfoVC.h"
#import "KIVFloatViewController.h"
#import "KIVFloatViewPC.h"
#import "ViewController+ScrolleHandle.h"
#import <KIVListKit.h>

//view
#import "KIVSearchHeaderView.h"

@interface ViewController ()
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) KIVCollectionViewProtocol * dataSource;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) KIVSearchHeaderView * searchHeader;
@property (nonatomic, strong) KIVVCTransition *trasition;

@property (nonatomic, strong) NSLayoutConstraint *searchHeaderTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *searchHeaderWidthConstraint;
@end

@implementation ViewController (ScrolleHandle)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + self.collectionView.contentInset.top;
    
    if (offsetY > 124) {
        CGPoint point = [scrollView.panGestureRecognizer translationInView:self.view];
        if (point.y > 0) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            self.navigationItem.titleView.hidden = NO;
            self.searchHeaderTopConstraint.constant = 64;
            self.searchHeaderWidthConstraint.constant = self.view.frame.size.width;
//             [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
        }else{
            [self.navigationController setNavigationBarHidden:YES animated:YES];
//            self.navigationItem.titleView.hidden = YES;
            self.searchHeaderTopConstraint.constant = 12;
            self.searchHeaderWidthConstraint.constant = self.view.frame.size.width - 80;
//            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        }
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.navigationItem.titleView.hidden = NO;
        self.searchHeaderTopConstraint.constant = 64;
        self.searchHeaderWidthConstraint.constant = self.view.frame.size.width;
//         [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    }
    

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    self.isScrolling = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    self.isScrolling = NO;
}


@end
