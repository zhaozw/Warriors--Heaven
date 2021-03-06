//
//  StatusViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDColoredProgressView.h"
#import <MessageUI/MFMailComposeViewController.h>
@interface StatusViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lbGold;
@property (strong, nonatomic) IBOutlet UIProgressView *pvJingli;
@property (strong, nonatomic) IBOutlet UIProgressView *pvHP;
@property (strong, nonatomic) IBOutlet UILabel *lbHP;
@property (strong, nonatomic) IBOutlet UILabel *lbJingli;
@property (strong, nonatomic) IBOutlet UILabel *lbExp;
@property (strong, nonatomic) IBOutlet UILabel *lbLevel;
@property (strong, nonatomic) IBOutlet UIProgressView *pvStam;
@property (strong, nonatomic) IBOutlet UILabel *lbStam;
- (void) onReceiveStatus:(NSObject*) json;
@end
