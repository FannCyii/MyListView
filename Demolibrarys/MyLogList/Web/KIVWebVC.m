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

@interface KIVWebVC ()
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation KIVWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.webView];
    
    [self.webView autoPinEdgesToSuperviewEdges];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
