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
#import "KIVHomeBottomView.h"


@interface KIVWebVC ()
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) KIVHomeBottomView *bottomView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation KIVWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfig];
    
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
//    self.progressView.backgroundColor = [UIColor whiteColor];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeBottom];

    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:22];
    [self.progressView autoSetDimension:ALDimensionHeight toSize:1];
    
//    if (self.routerParamsDir) {
//        self.url = [self.routerParamsDir objectForKey:@"url"];
//    }
    
    if(self.url.length == 0){
//        return;
        self.url = @"https://www.google.com";
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

- (void)navigationConfig
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)leftAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
