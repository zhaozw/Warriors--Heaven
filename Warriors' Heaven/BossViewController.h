//
//  BossViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "AppDelegate.h"

@interface BossViewController : UIViewController{
    EGOImageView* vBg;
    EGOImageView* vImage;
    NSString* hero;
}
@property (strong, retain) AppDelegate *ad;
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbLevel;
@property (strong, nonatomic) IBOutlet UIView *vEquipment;
@property (strong, nonatomic) IBOutlet UIButton *btnFight;
@property (strong, nonatomic) IBOutlet UILabel *lbDesc;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;
@property (strong, nonatomic) IBOutlet UILabel *lbEq;
@property (strong, nonatomic) IBOutlet UIView *vFightView;
@property (strong, nonatomic) IBOutlet UIWebView *wvFight;
- (IBAction)onCloseFightView:(id)sender;
- (IBAction)onTouchClose:(id)sender;
- (IBAction)onFight:(id)sender;
- (void) loadHero:(NSObject*) data;
@end
