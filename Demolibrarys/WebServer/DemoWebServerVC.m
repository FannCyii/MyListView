//
//  DemoWebServerVC.m
//  Demolibrarys
//
//  Created by kivan on 10/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "DemoWebServerVC.h"
#import "Demo_Network.h"
#import "DemoLogVO.h"

@interface DemoWebServerVC () <DemoWebServerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *serverURLLabel;
@property (nonatomic, strong) Demo_Network *network;
@end

@implementation DemoWebServerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.network = [Demo_Network new];
    self.network.delegate = self;
    
    [self.network startServer];
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

#pragma mark -DemoWebServerDelegate

- (void)webServer:(Demo_Network *)webServer startUrl:(NSURL *)url
{
    self.serverURLLabel.text = [NSString stringWithFormat:@"%@",url];
}

- (void)webServer:(Demo_Network *)webServer responsePath:(NSString *)path responseData:(id)aData error:(NSError *)error
{
    if([path isEqualToString:@"/1"]){
        NSError *error = nil;
//        if([aData isKindOfClass:[NSDictionary class]]){
//            DemoLogVO *vo = [[DemoLogVO alloc] initWithDictionary:(NSDictionary *)aData error:&error];
//            NSLog(@"vo:%@",vo);
//        }
        NSLog(@"====返回数据%@",aData);
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"log.info.deme.list"];
    }
}

@end
