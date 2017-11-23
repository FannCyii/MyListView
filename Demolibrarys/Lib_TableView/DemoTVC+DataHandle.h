//
//  DemoTVC+DataHandle.h
//  Demolibrarys
//
//  Created by kivan on 16/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "DemoTVC.h"
#import "KIVDemo01Cell.h"

@interface DemoTVC (DataHandle) <KIVDemo01CellDelegate>
- (void)dataHandle;
@end
