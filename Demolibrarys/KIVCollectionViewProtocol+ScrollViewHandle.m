//
//  KIVCollectionViewProtocol+ScrollViewHandle.m
//  Demolibrarys
//
//  Created by Fann on 21/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "KIVCollectionViewProtocol+ScrollViewHandle.h"

@implementation KIVCollectionViewProtocol (ScrollViewHandle) 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.collectionViewScrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.collectionViewScrollDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.collectionViewScrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.collectionViewScrollDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.collectionViewScrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.collectionViewScrollDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([self.collectionViewScrollDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.collectionViewScrollDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

@end
