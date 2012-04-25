//
//  QuestViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface QuestViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *vAskedQuest;
@property (strong, nonatomic) IBOutlet UIView *vUnaskedQuest;
@property (strong, retain) AppDelegate *ad;
@property (strong, retain) NSArray* askedQuests;
@property (strong, retain) NSArray* unaskedQuests;
@property (strong, nonatomic) IBOutlet UIImageView *vQuestTitle;
@property (strong, nonatomic) IBOutlet UIImageView *vAskedQuestTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbQuestTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbAskedQuestTitle;
@property (strong, nonatomic) IBOutlet UIView *vQuestContainer;
@property (strong, nonatomic) IBOutlet UIWebView *vQuestRoom;
@property (strong, nonatomic) IBOutlet UIButton *btCloseQuestRoom;
@property (strong, nonatomic) IBOutlet UIWebView *wvLoadingQuest;
- (void) reloadQuests;
@end
