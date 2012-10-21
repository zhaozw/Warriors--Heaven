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
@property (strong, nonatomic) IBOutlet UIImageView *vBgBottom;

@property (strong, nonatomic) IBOutlet UIImageView *vBgTop;
@property (strong, nonatomic) IBOutlet UILabel *lbError;
@property (strong, nonatomic) IBOutlet UITextField *tName;
@property (strong, nonatomic) IBOutlet UITextField *lbTeamCode;
@property (strong, nonatomic) IBOutlet UILabel *lbVersion;
@property (strong, nonatomic) IBOutlet UIView *vReg;

@property (strong, nonatomic) IBOutlet UIImageView *vBG;
- (IBAction)onCreate:(id)sender;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
- (IBAction)onSelectSex:(id)sender;
@end
