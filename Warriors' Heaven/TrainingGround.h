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

@interface TrainingGround : UIViewController{
    NSMutableArray* btn_practise_list; // list of progress view of tp
    int currentPractisingSkill;
    int willPractiseSkill;
    int usepot;
    int practiseRate;
}
@property (strong, retain) AppDelegate *ad;
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
@property (strong, nonatomic) IBOutlet UIImageView *vProfile;
- (IBAction)onSelectTrainingGround:(id)sender;
- (void) _startPractise:(NSString *)skillname _usepot:(int)_usepot;


//@property (nonatomic, retain) NSMutableArray* userskills;
@property (nonatomic, retain) NSMutableArray* pv_tp; // list of progress view of tp
@property (nonatomic, retain) NSMutableArray* lb_level_list; // list of progress view of tp
@property (nonatomic, retain) NSMutableArray* lb_status_list; // list of label for skill status
@property (strong, nonatomic) IBOutlet ResearchViewController *vcResearch;
- (IBAction)onSelectLibrary:(id)sender;
- (void) reloadSkills;
- (IBAction)onSelectStatus:(id)sender;
- (void) reloadPot;

- (void) _startPractise:(NSString *)skillname usepot:(int)usepot;
- (int) findSkillIndexByName:(NSString*) name;
//- (void) _startPractise:(NSString *)skillname _usepot:(int)_usepot;

@end
