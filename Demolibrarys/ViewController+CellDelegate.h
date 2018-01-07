//
//  ViewController+CellDelegate.h
//  Demolibrarys
//
//  Created by kivan on 25/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController.h"
#import "KIVHomeCVHeaderCell.h"
#import "KIVHomeCVMiddelCell.h"
#import "KIVSearchHeaderView.h"

@interface ViewController (CellDelegate)<KIVSearchHeaderViewDelegate,KIVHomeCVMiddelCellDelegate,KIVCVCellDelegate>

@end
