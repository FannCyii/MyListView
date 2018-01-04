//
//  KIVWebVC.m
//  Demolibrarys
//
//  Created by kivan on 24/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVWebVC.h"
#import "PureLayout.h"
#import <WebKit/WebKit.h>
#import "UIView+Toast.h"
#import <MGJRouter/MGJRouter.h>

@interface KIVWebVC ()
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation KIVWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    self.progressView.backgroundColor = [UIColor whiteColor];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:66];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
    [self.progressView autoSetDimension:ALDimensionHeight toSize:2];
    
    if (self.routerParamsDir) {
        self.url = [self.routerParamsDir objectForKey:@"url"];
    }
    
    if(self.url.length == 0){
        return;
    }
    
    if(!([self.url hasPrefix:@"http://"] || [self.url hasPrefix:@"https://"])){
        self.url = [NSString stringWithFormat:@"http://%@",self.url];
    }
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == self.webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            
            if(self.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView) {
            self.title = self.webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
