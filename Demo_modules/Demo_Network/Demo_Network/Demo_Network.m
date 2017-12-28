//
//  Demo_Network.m
//  Demo_Network
//
//  Created by kivan on 10/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "Demo_Network.h"
//#import "GCDWebServer.h"
#import <GCDWebServer/GCDWebServer.h>
#import "GCDWebServerDataResponse.h"
#import "GCDWebServerMultiPartFormRequest.h"
#import "GCDWebServerURLEncodedFormRequest.h"

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
                                          <form action='/1' method=\"post\" id=\"usrform\"> \
                                          标签集名称:<br> \
                                          <input type=\"text\" name=\"logtitle\"> \
                                          <br>\
                                          <input type=\"submit\" name=\"提交\">\
                                          </form>\
                                          <textarea rows=\"50\" cols=\"150\" name=\"comment\" form=\"usrform\">\
                                          请在此处输入文本...</textarea>\
                                          <p>注意上传成功后，网页会出现未找到的情况，是否上传成功已App显示为主。</p>\
                                          </body> \
                                          </html>"];
                              }];
    
    __weak typeof(self) weakSelf = self;
    [_webServer addHandlerForMethod:@"POST"
                               path:@"/1"
                       requestClass:[GCDWebServerURLEncodedFormRequest class]
                  asyncProcessBlock:^(__kindof GCDWebServerRequest * _Nonnull request, GCDWebServerCompletionBlock  _Nonnull completionBlock) {
                      __strong typeof(self) strongSelf = weakSelf;
                      GCDWebServerURLEncodedFormRequest *postRequest = (GCDWebServerURLEncodedFormRequest *)request;
//                      NSLog(@"%@",postRequest.arguments);
                      if([strongSelf.delegate respondsToSelector:@selector(webServer:responsePath:responseData:error:)]){
                          [strongSelf.delegate webServer:strongSelf responsePath:@"/1" responseData:postRequest.arguments error:nil];
                      }
                      
    }];

    // Start server on port 8080
    [_webServer startWithPort:9888 bonjourName:@"test111"];
    NSLog(@"Visit %@ in your web browser", _webServer.serverURL);
    if([self.delegate respondsToSelector:@selector(webServer:startUrl:)]){
        [self.delegate webServer:self startUrl:[self serverURL]];
    }

}

- (void)stopWebServer
{
    [_webServer stop];
}

@end
