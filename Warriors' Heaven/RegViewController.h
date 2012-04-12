//
//  RegViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegViewController : UIViewController{
    int currentSelectedSex;
    UIButton* btSelectedSex;
}

@property (strong, nonatomic) IBOutlet UILabel *lbError;
@property (strong, nonatomic) IBOutlet UITextField *tName;

- (IBAction)onCreate:(id)sender;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
- (IBAction)onSelectSex:(id)sender;
@end
