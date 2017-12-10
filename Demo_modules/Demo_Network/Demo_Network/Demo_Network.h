//
//  Demo_Network.h
//  Demo_Network
//
//  Created by kivan on 10/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseDateComplete)(id ResponseDate,NSError *error);


@class Demo_Network;

@protocol DemoWebServerDelegate <NSObject>
- (void)webServer:(Demo_Network *)webServer startUrl:(NSURL *)url;

- (void)webServer:(Demo_Network *)webServer responsePath:(NSString *)path responseData:(id)aData error:(NSError *)error;

@end


@interface Demo_Network : NSObject

@property (nonatomic, weak) id<DemoWebServerDelegate> delegate;

- (void)startServer;

@end
