//
//  TrainingGround.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"
#import "AppDelegate.h"
#import "ResearchViewController.h"

@interface TrainingGround : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lbPotential;
//@property (strong, nonatomic) IBOutlet StatusViewController *vcStatus;
@property (strong, nonatomic) IBOutlet UIView* skillsView;
@property (strong, nonatomic) IBOutlet UIView* vBasicSkill;
@property (strong, nonatomic) IBOutlet UILabel *lbUsername;

@property (strong, nonatomic) IBOutlet UIView* vCommonSkill;
@property (strong, nonatomic) IBOutlet UIView* vPremierSkill;
@property (strong, nonatomic) IBOutlet UIView* vBasicSkillsList;
@property (strong, nonatomic) IBOutlet UIView* vCommonSkillsList;
@property (strong, nonatomic) IBOutlet UIView* vPremierSkillsList;
@property (strong, nonatomic) IBOutlet UIButton * bt_common_skill;
@property (strong, nonatomic) IBOutlet UIButton * bt_premier_skill;
@property (strong, nonatomic) IBOutlet UIButton * bt_basic_skill;
- (IBAction)onSelectTrainingGround:(id)sender;
@property (strong, retain) AppDelegate * ad;
//@property (nonatomic, retain) NSMutableArray* userskills;
@property (nonatomic, retain) NSMutableArray* pv_tp; // list of progress view of tp
@property (nonatomic, retain) NSMutableArray* lb_level_list; // list of progress view of tp
@property (strong, nonatomic) IBOutlet ResearchViewController *vcResearch;
- (IBAction)onSelectLibrary:(id)sender;
@end
