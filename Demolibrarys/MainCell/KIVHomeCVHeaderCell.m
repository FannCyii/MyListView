//
//  KIVHomeCVHeaderCell.m
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVHomeCVHeaderCell.h"
#import "KIVWebVC.h"

@interface KIVHomeCVHeaderCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation KIVHomeCVHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.searchTextField.keyboardType = UIKeyboardTypeWebSearch;
    self.searchTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.delegate respondsToSelector:@selector(kivHomeCVHeaderCell:didReturnWihtTextField:)]){
        [self.delegate kivHomeCVHeaderCell:self didReturnWihtTextField:textField];
    }
    return YES;
}



@end
