//
//  Demo_Network.m
//  Demo_Network
//
//  Created by kivan on 10/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "Demo_Network.h"
#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"

@implementation Demo_Network{
    GCDWebServer* _webServer;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _webServer = [[GCDWebServer alloc] init];
    }
    return self;
}

- (NSURL *)serverURL
{
    return _webServer.serverURL;
}

- (void)startServer
{
    // Add a handler to respond to GET requests on any URL
    [_webServer addDefaultHandlerForMethod:@"GET"
                              requestClass:[GCDWebServerRequest class]
                              processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
//                                  NSLog(@"%@",request.query);
                                  return [GCDWebServerDataResponse responseWithHTML:@"<!DOCTYPE html> \
                                          <html> \
                                          <body> \
                                          <form action='/1'> \
                                          博客名称:<br> \
                                          <input type=\"text\" name=\"logtitle\"> \
                                          <br>\
                                          博客网址:<br>\
                                          <input type=\"text\" name=\"logurl\">\
                                          <br>\
                                          <input type=\"submit\" name=\"提交\">\
                                          </form>\
                                          <p>同时请注意文本字段的默认宽度是 20 个字符。</p>\
                                          </body> \
                                          </html>"];
                              }];
    
    __weak typeof(self) weakSelf = self;
    [_webServer addHandlerForMethod:@"GET"
                               path:@"/1"
                       requestClass:[GCDWebServerRequest class]
                  asyncProcessBlock:^(__kindof GCDWebServerRequest * _Nonnull request, GCDWebServerCompletionBlock  _Nonnull completionBlock) {
                      __strong typeof(self) strongSelf = weakSelf;
                      NSLog(@"%@",request.query);
                      
                      if([strongSelf.delegate respondsToSelector:@selector(webServer:responsePath:responseData:error:)]){
                          [strongSelf.delegate webServer:strongSelf responsePath:@"/1" responseData:request.query error:nil];
                      }
                      
    }];

    // Start server on port 8080
    [_webServer startWithPort:8080 bonjourName:nil];
    NSLog(@"Visit %@ in your web browser", _webServer.serverURL);
    if([self.delegate respondsToSelector:@selector(webServer:startUrl:)]){
        [self.delegate webServer:self startUrl:[self serverURL]];
    }

}

@end
