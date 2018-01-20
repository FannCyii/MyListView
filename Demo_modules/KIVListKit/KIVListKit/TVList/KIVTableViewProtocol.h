//
//  KIVTableViewProtocol.h
//  Demo_AboutList
//
//  Created by Fann on 17/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVTVCellItem.h"
#import "KIVTVCellSection.h"

@interface KIVTableViewProtocol : NSObject <UITableViewDataSource,UITableViewDelegate>
- (void)updateWithData:(NSArray <KIVTVCellSection *> *)sections;
@end
