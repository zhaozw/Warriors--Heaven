//
//  TeamViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightView.h"
#import "AppDelegate.h"

@interface TeamViewController : UIViewController
@property(nonatomic, assign)     int currentSelectedList;
@property(nonatomic, assign) BOOL needReload;

- (IBAction)onSelectTab1:(id)sender;
- (IBAction)onSelectTab2:(id)sender;
@property (strong, nonatomic) IBOutlet LightView *vMyTeam;
@property (strong, nonatomic) IBOutlet LightView *vJoinedTeams;
@property (strong, retain) AppDelegate *ad;
@property (strong, nonatomic) IBOutlet UITextField *tfTeamCode;
@property (strong, nonatomic) UILabel *lbMemberNumber;
@property (strong, nonatomic) UILabel *lbTeamPower;
- (IBAction)onJoinTeam:(id)sender;
- (IBAction)onHelpTeamCode:(id)sender;

@end
