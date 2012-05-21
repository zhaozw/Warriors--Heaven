//
//  TrainingGround.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TrainingGround.h"
#import "AppDelegate.h"
#import "QuartzCore/CAAnimation.h"
#import "WHHttpClient.h"

@implementation TrainingGround
@synthesize vcResearch;
@synthesize lbPotential;
//@synthesize vcStatus;
@synthesize skillsView;
@synthesize vBasicSkill;
@synthesize lbUsername;
@synthesize vCommonSkill;
@synthesize vPremierSkill;
@synthesize ad;
@synthesize vBasicSkillsList;
@synthesize vCommonSkillsList;
@synthesize vPremierSkillsList;
@synthesize bt_basic_skill;
@synthesize vProfile;
@synthesize bt_common_skill;
@synthesize bt_premier_skill;
//@synthesize userskills;
@synthesize pv_tp;
@synthesize lb_level_list;
@synthesize lb_status_list;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // add status view
     ad = [UIApplication sharedApplication].delegate;
    currentPractisingSkill = -1;
    willPractiseSkill = -1;
    lbUsername.text = [[ad getDataUser] valueForKey:@"user"];
    
    pv_tp = [[NSMutableArray alloc] init];
    lb_level_list = [[NSMutableArray alloc] init];
    btn_practise_list = [[NSMutableArray alloc] init];
    lb_status_list  = [[NSMutableArray alloc] init];

//    userskills = [[NSMutableArray alloc] init];
//    [self addChildViewController:vcStatus];
//    [self.view addSubview:vcStatus.view];
    
    [self addChildViewController:vcResearch];
    vcResearch.view.hidden = YES;
    [self.view addSubview:vcResearch.view];
    
    
    NSString* prof = [NSString stringWithFormat:@"p_%@m.png", [[ad getDataUser] valueForKey:@"profile"]];
    [vProfile setImage:[UIImage imageNamed:prof]];
    
    
    //  UIImageView skillsView = [[UIImageView alloc] initWithImage:UIImage imageNamed:@"skillview.png")];
    skillsView = [[UIView alloc] initWithFrame:CGRectMake(-200, 200, 300, 300)];
//    [skillsView setAlpha:0.5f];
    [skillsView setOpaque:NO];
    [skillsView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:skillsView];
    
    vBasicSkill = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [vBasicSkill setBackgroundColor:[UIColor clearColor]];
    [vBasicSkill setOpaque:FALSE];
    
    [skillsView addSubview:vBasicSkill];
    
    UIImage *imageNormal = [UIImage imageNamed:@"btn_skill.png"];
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:30 topCapHeight:0];

    
    bt_basic_skill = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt_basic_skill setBackgroundImage:stretchableImageNormal  forState:UIControlStateNormal];
    [bt_basic_skill setFrame:CGRectMake(0, 0, 200, 20)];
    [bt_basic_skill setBackgroundColor:[UIColor clearColor]];
    [bt_basic_skill setOpaque:NO];
    [[bt_basic_skill titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [bt_basic_skill setTitleColor:[UIColor colorWithRed:88 green:33 blue:0 alpha:1] forState:UIControlStateNormal];
    [bt_basic_skill setTitle:@"基础技" forState:UIControlStateNormal];
    [bt_basic_skill setTag:1];
    [bt_basic_skill addTarget:self action:@selector(selectedSkillBt:) forControlEvents:UIControlEventTouchUpInside];
    [vBasicSkill addSubview:bt_basic_skill];
    
 

  
    // create view contain skill list. height=20, margin 10, row height is 30
    
    vBasicSkillsList  = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 20)];
    [vBasicSkillsList setBackgroundColor:[UIColor clearColor]];
    vBasicSkillsList.hidden = YES;
    [vBasicSkill setUserInteractionEnabled:TRUE];
    [vBasicSkillsList setUserInteractionEnabled:TRUE];
    [vBasicSkill addSubview:vBasicSkillsList];
    
    
    vCommonSkill = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 20)];
    [vCommonSkill setBackgroundColor:[UIColor clearColor]];
    [vCommonSkill setOpaque:FALSE];
    [skillsView addSubview:vCommonSkill];
   
    bt_common_skill = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt_common_skill setBackgroundImage:stretchableImageNormal  forState:UIControlStateNormal];
    [bt_common_skill setFrame:CGRectMake(0, 0, 200, 20)];
    [bt_common_skill setBackgroundColor:[UIColor clearColor]];
    [bt_common_skill setOpaque:NO];
    [[bt_common_skill titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [bt_common_skill setTitleColor:[UIColor colorWithRed:88 green:33 blue:0 alpha:1] forState:UIControlStateNormal];
    [bt_common_skill setTitle:@"高级技" forState:UIControlStateNormal];
    [bt_common_skill setTag:2];
    [bt_common_skill addTarget:self action:@selector(selectedSkillBt:) forControlEvents:UIControlEventTouchUpInside];
    [vCommonSkill addSubview:bt_common_skill];
    vCommonSkillsList  = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 20)];
    [vCommonSkill addSubview:vCommonSkillsList];
    vCommonSkillsList.hidden = YES;
    
    vPremierSkill = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 300, 20)];
    [vPremierSkill setBackgroundColor:[UIColor clearColor]];
    [vPremierSkill setOpaque:FALSE];
    [skillsView addSubview:vPremierSkill];

    bt_premier_skill = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt_premier_skill setBackgroundImage:stretchableImageNormal  forState:UIControlStateNormal];
    [bt_premier_skill setFrame:CGRectMake(0, 0, 200, 20)];
    [bt_premier_skill setBackgroundColor:[UIColor clearColor]];
    [bt_premier_skill setOpaque:NO];
    [[bt_premier_skill titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [bt_premier_skill setTitleColor:[UIColor colorWithRed:88 green:33 blue:0 alpha:1] forState:UIControlStateNormal];
    [bt_premier_skill setTitle:@"必杀技" forState:UIControlStateNormal];
    [bt_premier_skill setTag:3];
    [bt_premier_skill addTarget:self action:@selector(selectedSkillBt:) forControlEvents:UIControlEventTouchUpInside];
    [vPremierSkill addSubview:bt_premier_skill];
    vPremierSkillsList  = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 300, 20)];
    [vPremierSkill addSubview:vPremierSkillsList];
    vPremierSkillsList.hidden = YES;
    

    vBasicSkillsList.hidden = YES;
    vCommonSkillsList.hidden = YES;
    vPremierSkillsList.hidden = YES;

}

- (void)selectedSkillBt:(UIButton*) bt{
    NSLog(@"SELECT SKILL BUTTON");
    switch (bt.tag) {
        case 1:
            if (vBasicSkill.frame.size.height < 30){
                vBasicSkillsList.hidden = NO;
                int height = vBasicSkillsList.frame.size.height+20;
                int orig_height = vBasicSkill.frame.size.height;
                int offset = height - orig_height;
                CGRect rect = vBasicSkill.frame;
                rect.size.height = height;
                [vBasicSkill setFrame: rect];
                rect = vCommonSkill.frame;
                rect.origin.y += offset;
                [vCommonSkill setFrame:rect];
                 rect = vPremierSkill.frame;
                rect.origin.y += offset;
                [vPremierSkill setFrame:rect];
                
            }else{
                vBasicSkillsList.hidden = YES;
                CGRect rect = vBasicSkill.frame;
               
                int height = rect.size.height;
                rect.size.height = 20;
                [vBasicSkill setFrame: rect];
                rect = vCommonSkill.frame;
                rect.origin.y -= height-20;
                [vCommonSkill setFrame:rect];
                rect = vPremierSkill.frame;
                rect.origin.y -= height-20;
                [vPremierSkill setFrame:rect];
            }
            break;
            
        case 2:
            if (vCommonSkill.frame.size.height < 30){
                vCommonSkillsList.hidden = NO;
                int height = vCommonSkillsList.frame.size.height+20;
                int offset = height - vCommonSkill.frame.size.height;
                CGRect rect = vCommonSkill.frame;
                rect.size.height = height;
                [vCommonSkill setFrame: rect];
                rect = vPremierSkill.frame;
                rect.origin.y += offset;
                [vPremierSkill setFrame:rect];
                
            }else{
                     vCommonSkillsList.hidden = YES;
                
                int height = vCommonSkillsList.frame.size.height+20;
                CGRect rect = vCommonSkill.frame;
                rect.size.height = 20;
                [vCommonSkill setFrame: rect];
                int offset = height- 20;
                 rect = vPremierSkill.frame;
                rect.origin.y -= offset;
                [vPremierSkill setFrame:rect];
            }
            break;
            
        case 3:
            if (vPremierSkill.frame.size.height < 30){
               vPremierSkillsList.hidden = NO;
          
                CGRect rect = vPremierSkill.frame;
                rect.size.height = vPremierSkillsList.frame.size.height+20;;
                [vPremierSkill setFrame: rect];
     
                
            }else{
                     vPremierSkillsList.hidden = YES;
                CGRect rect = vPremierSkill.frame;
                rect.size.height = 20;
                [vPremierSkill setFrame:rect];
            }
            break;
        default:
            break;
    }
}

- (void)viewDidUnload
{
//    [self setVcStatus:nil];
    [self setLbPotential:nil];
    [self setVcResearch:nil];
    [self setLbUsername:nil];
    [self setVProfile:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    [ad setBgImg:[UIImage imageNamed:@"traininggrd.jpg"] ];
    
    NSObject* userext = [ad getDataUserext];
    lbPotential.text = [[userext valueForKey:@"pot"] stringValue];
    if (ad.bUserSkillNeedUpdate){
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        [client sendHttpRequest:@"/userskills" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    }else {
        [self reloadSkills];
    }
    
}

- (void) foldAll{
    vBasicSkillsList.hidden = YES;
    vCommonSkillsList.hidden = YES;
    vPremierSkillsList.hidden = YES;
//    CGRect rect = vBasicSkill.frame;
//    int h = rect.size.height;
//    rect.size.height = 20;
//    [vBasicSkill setFrame: rect];
//    rect = vCommonSkill.frame;
//    h = rect.size.height;
//    rect.size.height = 20;
//    [vCommonSkill setFrame: rect];
//    rect = vPremierSkill.frame;
//    h = rect.size.height;
//    rect.size.height = 20;
//    [vPremierSkill setFrame: rect];
    [vBasicSkill setFrame:CGRectMake(0, 0, 320, 20)];
    [vCommonSkill setFrame:CGRectMake(0, 30, 320, 20)];
    [vPremierSkill setFrame:CGRectMake(0, 60, 320, 20)];
}

// reload from local data
- (void) reloadSkills{
    // reset status
//    [self foldAll];
    
    // remove all existing row
    NSArray * subviewsArr = [vBasicSkillsList subviews];
    for(UIView *v in subviewsArr )
    {
        [v removeFromSuperview];
    }
    subviewsArr = [vCommonSkillsList subviews];
    for(UIView *v in subviewsArr )
    {
        [v removeFromSuperview];
    }
    subviewsArr = [vPremierSkillsList subviews];
    for(UIView *v in subviewsArr )
    {
        [v removeFromSuperview];
    }
    
    [pv_tp removeAllObjects];
    [lb_level_list removeAllObjects];
    [lb_status_list removeAllObjects];
    // build new rows
    NSArray* userskills = [ad getDataUserskills];
    int height = 50;
    int y_b = 0;
    int y_c = 0;
    int y_p = 0;
    int count_b = 0;
    int count_c = 0;
    int count_p = 0;
    for (int i = 0; i< [userskills count];  i++){
        
        NSObject *o = [userskills objectAtIndex:i];
        o = [o valueForKey:@"userskill"];
        NSLog(@"skill %@", [o valueForKey:@"dname"]);
        int tp = [[o valueForKey:@"tp"] intValue];
        int level = [[o valueForKey:@"level"] intValue];
        
        UILabel* lbSkillTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [lbSkillTitle setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
        [lbSkillTitle setTextColor:[UIColor whiteColor]];
        [lbSkillTitle setBackgroundColor:[UIColor clearColor]];
        [lbSkillTitle setOpaque:NO];
        [lbSkillTitle setText:[o valueForKey:@"dname"]];
        
        UIProgressView * pvTP = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        pvTP.frame = CGRectMake(100, 20, 50, 30);
        float process = ((float)tp)/((level+1)*(level+1));
        [pvTP setProgress:process];
        [pv_tp addObject:pvTP];
        
        UILabel* lbSkillStatus = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 50, 30)];
        [lbSkillStatus setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [lbSkillStatus setTextColor:[UIColor yellowColor]];
        [lbSkillStatus setBackgroundColor:[UIColor clearColor]];
        [lbSkillStatus setOpaque:NO];
        [lbSkillStatus setText:[[NSString alloc] initWithFormat:@"%@/Level %@", [[o valueForKey:@"tp"] stringValue], [[o valueForKey:@"level"] stringValue]]];
        [lb_level_list addObject:lbSkillStatus];
        
        UILabel* lbSkillStatus2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 50, 30)];
        [lbSkillStatus2 setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [lbSkillStatus2 setTextColor:[UIColor yellowColor]];
        [lbSkillStatus2 setBackgroundColor:[UIColor clearColor]];
        [lbSkillStatus2 setOpaque:NO];
        if (currentPractisingSkill == i)
            lbSkillStatus2.text = @"修炼中";
//        [lbSkillStatus2 setText:[[NSString alloc] initWithFormat:@"%@/%@", [[o valueForKey:@"tp"] stringValue], [[o valueForKey:@"level"] stringValue]]];
        [lb_status_list addObject:lbSkillStatus2];
        
        UIButton * btPractise = [UIButton buttonWithType:UIButtonTypeCustom];
        [btPractise setBackgroundImage:[UIImage imageNamed:@"btn_green_light"]  forState:UIControlStateNormal];
        [btPractise setBackgroundColor:[UIColor clearColor]];
        [btPractise setOpaque:NO];
        [[btPractise titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [btPractise setTitleColor:[UIColor colorWithRed:88 green:33 blue:0 alpha:1] forState:UIControlStateNormal];
        [btPractise setTitle:@"修炼" forState:UIControlStateNormal];
        [btPractise setTag:i];
        [btPractise setShowsTouchWhenHighlighted:YES];
//        [btPractise addTarget:self action:@selector(practiseSkill:) forControlEvents:UIControlEventTouchUpInside];
         [btPractise addTarget:self action:@selector(startPractise:) forControlEvents:UIControlEventTouchUpInside];
        [btn_practise_list addObject:btPractise];
        
        NSString* cat = [o valueForKey:@"category"];
        if ([cat isEqualToString:@"basic"]){
            count_b ++;
            [lbSkillTitle setFrame:CGRectMake(0, y_b, 90, height-10)];
            [vBasicSkillsList addSubview:lbSkillTitle];
            
            [vBasicSkillsList addSubview:pvTP];
            [pvTP setFrame:CGRectMake(90, y_b+10, 80, 10)];
            
            [vBasicSkillsList addSubview:lbSkillStatus];
            [lbSkillStatus setFrame:CGRectMake(100, y_b+5, 80, height-10)];
            
            [vBasicSkillsList addSubview:lbSkillStatus2];
            [lbSkillStatus2 setFrame:CGRectMake(180, y_b+5, 50, height-10)];
            
            [vBasicSkillsList addSubview:btPractise];
            [btPractise setFrame:CGRectMake(250, y_b, 70, height-17)];
            
            //            [skillsView setUserInteractionEnabled:YES];
            //            [vBasicSkill setUserInteractionEnabled:YES];
            //            [vBasicSkillsList setUserInteractionEnabled:YES];
            //            [btPractise setUserInteractionEnabled: YES];
            //            [vBasicSkillsList bringSubviewToFront:btPractise];
            
            
            y_b += height;
        }else if ([cat isEqualToString:@"common"]){
            count_c ++;
            [vCommonSkillsList addSubview:lbSkillTitle];
            [lbSkillTitle setFrame:CGRectMake(0, y_c, 90, height-10)];
            [vCommonSkillsList addSubview:pvTP];
            [pvTP setFrame:CGRectMake(90, y_c+10, 80, height-10)];
            [vCommonSkillsList addSubview:lbSkillStatus];
            [lbSkillStatus setFrame:CGRectMake(100, y_c+5, 80, height-10)];
            [vCommonSkillsList addSubview:lbSkillStatus2];
            [lbSkillStatus2 setFrame:CGRectMake(180, y_c+5, 50, height-10)];
            [vCommonSkillsList addSubview:btPractise];
            [btPractise setFrame:CGRectMake(250, y_c, 70, height-17)];
            
            
            y_c += height;
        }else if ([cat isEqualToString:@"premier"]){
            count_p ++;
            [vPremierSkillsList addSubview:lbSkillTitle];
            [lbSkillTitle setFrame:CGRectMake(0, y_p, 90, height)];
            [vPremierSkillsList addSubview:pvTP];
            [pvTP setFrame:CGRectMake(90, y_p+10, 80, height-10)];
            [vPremierSkillsList addSubview:lbSkillStatus];
            [lbSkillStatus setFrame:CGRectMake(120, y_p+5, 80, height-10)];
            [vPremierSkillsList addSubview:lbSkillStatus2];
            [lbSkillStatus2 setFrame:CGRectMake(180, y_p+5, 50, height-10)];
            [vPremierSkillsList addSubview:btPractise];
            [btPractise setFrame:CGRectMake(250, y_p, 70, height-17)];
            
            y_p += height;
        }
        
    }
    
    CGRect rect = vBasicSkillsList.frame;
    rect.size.height = y_b;
    [vBasicSkillsList setFrame:rect];
    rect = vCommonSkillsList.frame;
    rect.size.height = y_c;
    [vCommonSkillsList setFrame:rect];
    rect = vPremierSkillsList.frame;
    rect.size.height = y_p;
    [vPremierSkillsList setFrame:rect];
    
    //    vBasicSkillsList.backgroundColor = [UIColor greenColor];
    
    
    //    int h = vBasicSkillsList.frame.size.height + vCommonSkillsList.frame.size.height + vPremierSkill.frame.size.height+30;
    rect =  skillsView.frame;
    rect.size.height = height*(count_b+count_c+count_p)+90;
    skillsView.frame = rect;
    if (rect.size.height+200-480 >0)
        [(UIScrollView*)[self view] setContentSize:CGSizeMake(0, 200+rect.size.height-480)];
    
    
//    vBasicSkillsList.hidden = YES;
//    vCommonSkillsList.hidden = YES;
//    vPremierSkillsList.hidden = YES;
    
    [bt_basic_skill setTitle:[[NSString alloc] initWithFormat:@"基础技 (%d)", count_b] forState:UIControlStateNormal];
    [bt_common_skill setTitle:[[NSString alloc] initWithFormat:@"高级技 (%d)", count_c] forState:UIControlStateNormal];
    [bt_premier_skill setTitle:[[NSString alloc] initWithFormat:@"必杀技 (%d)", count_p] forState:UIControlStateNormal];
}

- (IBAction)onSelectStatus:(id)sender {
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    [[ad tabBarController] selectTab:1];
}
- (void) onReceiveStatus:(NSArray*) data{
    [[ad.data_user valueForKey:@"user"] setValue:data forKey:@"skills"];
    ad.bUserSkillNeedUpdate = NO;
    // e.g. 
    //     [{"userskill":{"skdname":"dodge","created_at":null,"updated_at":null,"sid":"d434740f4ff4a5e758d4f340d7a5f467","level":0,"uid":1,"skname":"dodge","id":2,"enabled":1,"tp":0,"skid":2}},{"userskill":{"skdname":"parry","created_at":null,"updated_at":null,"sid":"d434740f4ff4a5e758d4f340d7a5f467","level":0,"uid":1,"skname":"parry","id":3,"enabled":1,"tp":0,"skid":3}},{"userskill":{"skdname":"unarmed","created_at":null,"updated_at":null,"sid":"d434740f4ff4a5e758d4f340d7a5f467","level":0,"uid":1,"skname":"unarmed","id":1,"enabled":1,"tp":0,"skid":1}}]
    [self reloadSkills];

}

- (void) _startPractise:(NSString *)skillname _usepot:(int)_usepot{
    self->usepot = _usepot;

    self->currentPractisingSkill = [self findSkillIndexByName:skillname];
    UIButton* btn = [btn_practise_list objectAtIndex:currentPractisingSkill];
    if (btn){
        [btn setTitle:@"修炼" forState:UIControlStateNormal];
        [btn removeTarget:self action:@selector(stopPractise:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(startPractise:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self performSelector:@selector(practiseThread) withObject:NULL afterDelay:1];
}
- (void)startPractise:(UIButton*) btn{
    NSLog(@"train skill");

        
    
    
    int i = btn.tag;
    NSDictionary *ext = [ad getDataUserext];
    int jingli = [[ext valueForKey:@"jingli"] intValue];
    int stam = [[ext valueForKey:@"stam"] intValue];
    int pot = [[ext valueForKey:@"pot"] intValue];
    if (pot <= 0){
        currentPractisingSkill =-1; // in case training didn't stop properly
        [ad showMsg:@"你没有潜能，无法提高" type:1 hasCloseButton:NO];
        return;
    }
    if (jingli <= 0){
        [ad showMsg:@"你的精力不够，无法集中精神，休息一下吧" type:1 hasCloseButton:NO];
        return;
    }
    if (stam <= 0){
        [ad showMsg:@"你觉得腰酸背痛，体力似乎不够充足，休息一下再练吧" type:1 hasCloseButton:NO];
        return;
    }
    if (currentPractisingSkill != -1){      
        [ad showMsg:@"你正在修炼" type:1 hasCloseButton:NO];
        return;
    }
    NSArray* userskills = [ad getDataUserskills];
    NSObject* skill = [[userskills objectAtIndex:i] valueForKey:@"userskill"];
    NSLog(@"%@", skill);
    NSString* name = [skill valueForKey:@"skname"];
    NSLog(@"skillname is %@", name);
    
    int level = [[skill valueForKey:@"level"] intValue];
    int tp = [[skill valueForKey:@"tp"] intValue];

    int need_pot = (level+1)*(level+1) - tp;
    if (need_pot < pot)
        need_pot = pot;
        
    usepot = need_pot;
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client setRetry:TRUE];
    NSString* url = [[NSString alloc] initWithFormat:@"/wh/startPractise?pot=%d&skill=%@", need_pot, name];
    [client sendHttpRequest:url selector:@selector(onStartPractiseReturn:) json:YES showWaiting:YES];
    
//    currentPractisingSkill = i;

}

- (void) practiseThread{
    NSObject* ext = [ad getDataUserext];
    int pot = [[ext valueForKey:@"pot"] intValue];
    int jingli = [[ext valueForKey:@"jingli"] intValue];
    int it = [[ext valueForKey:@"it"] intValue];
    NSArray* userskills = [ad getDataUserskills];
    NSObject* skill = [[userskills objectAtIndex:currentPractisingSkill] valueForKey:@"userskill"];
    NSLog(@"%@", skill);
    NSString* name = [skill valueForKey:@"skname"];
    NSLog(@"skillname is %@", name);
    int tp = [[skill valueForKey:@"tp"] intValue];
    if (pot == 0 || usepot == 0){
        // stop practise
        NSLog(@"stop practise");
               WHHttpClient* client = [[WHHttpClient alloc] init:self];
        NSString* url = [[NSString alloc] initWithFormat:@"/wh/stopPractise?skill=%@", name];
        [client setRetry:YES];
        [client sendHttpRequest:url selector:@selector(onStopPractiseReturn:) json:YES showWaiting:NO];
        return;
        
    }
    int rate = 1; // consume 1 pot per second 
   
    id fixture;
    
    if ([name isEqualToString:@"parry"]){
         fixture   = [ad getDataUserextProp:@"muren"];
        if (fixture){
            int fx_v = [fixture intValue];
            if (fx_v >0)
                rate = rate / 2;
        }
    }else if ([name isEqualToString:@"unarmed"]){
        fixture   = [ad getDataUserextProp:@"shadai"];
        if (fixture){
            int fx_v = [fixture intValue];
            if (fx_v >0)
                rate = rate / 2;
        }
    }else if ([name isEqualToString:@"dodge"]){
        fixture   = [ad getDataUserextProp:@"meihuazhuang"];
        if (fixture){
            int fx_v = [fixture intValue];
            if (fx_v >0)
                rate = rate / 2;
        }
    }
    usepot -= rate;
    pot-=rate;
    tp += rate;
    jingli -= rate*20/it;
    [skill setValue:[NSNumber numberWithInt:tp] forKey:@"tp"];
    [ext setValue:[NSNumber numberWithInt:pot] forKey:@"pot"];
    [ext setValue:[NSNumber numberWithInt:jingli] forKey:@"jingli"];
    [self performSelector:@selector(practiseThread) withObject:NULL afterDelay:1];
    lbPotential.text = [NSString stringWithFormat:@"%d", pot];
    int level = [[skill valueForKey:@"level"] intValue];
    float process = ((float)tp)/((level+1)*(level+1));
    [((UIProgressView*)([pv_tp objectAtIndex:currentPractisingSkill])) setProgress:process];
    
}
- (void) onStopPractiseReturn:(NSObject*) data{
    NSString* error = [data valueForKey:@"error"];
    if (error)
        [ad showMsg:error type:1 hasCloseButton:YES];
    else{
        NSString* suc = [data valueForKey:@"OK"];
        [ad showMsg:suc type:0 hasCloseButton:YES];
        NSObject* ext = [data valueForKey:@"userext"];
        [[[ad getDataUser] valueForKey:@"userext"] setValue:ext forKey:@"userext"];
        NSArray* userskills = [ad getDataUserskills];
        NSObject* skill = [userskills objectAtIndex:currentPractisingSkill] ;
        NSObject* new_userskill = [data valueForKey:@"userskill"];
        if (new_userskill)
            [skill setValue:new_userskill forKey:@"userskill"];
        NSLog(@"USERSKILLS: %@", [ad getDataUserskills]);
        UIButton* btn = [btn_practise_list objectAtIndex:currentPractisingSkill];
        if (btn){
            [btn setTitle:@"修炼" forState:UIControlStateNormal];
            [btn removeTarget:self action:@selector(stopPractise:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(startPractise:) forControlEvents:UIControlEventTouchUpInside];
        }
      
    }
    
    currentPractisingSkill = -1;
    
    [ad reloadStatus];
    [self reloadSkills];
}
- (void) onStartPractiseReturn:(NSObject*) data{
    NSString* error = [data valueForKey:@"error"];
    if (error){
        [ad showMsg:error type:1 hasCloseButton:YES];
        currentPractisingSkill = -1;
        return;
    }
    
    else{
         NSString* suc = [data valueForKey:@"OK"];
         
        [ad showMsg:suc type:0 hasCloseButton:YES];
        int usepot = [[data valueForKey:@"usepot"] intValue];
        if (usepot > 0)
            [self _startPractise:[data valueForKey:@"skill"] _usepot:usepot];
        UILabel* lbStatus = [lb_status_list objectAtIndex:currentPractisingSkill];
        lbStatus.text = @"修炼中";
    }
    [self reloadSkills];
    [ad setUserBusy:TRUE];

}

- (void) stopPractise:(UIButton*) btn{
    NSArray* userskills = [ad getDataUserskills];
    NSObject* skill = [[userskills objectAtIndex:currentPractisingSkill] valueForKey:@"userskill"];
    NSLog(@"%@", skill);
    NSString* name = [skill valueForKey:@"skname"];
    NSLog(@"skillname is %@", name);
    int tp = [[skill valueForKey:@"tp"] intValue];

        // stop practise
        NSLog(@"stop practise");
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        NSString* url = [[NSString alloc] initWithFormat:@"/wh/stopPractise?skill=%@", name];
        [client setRetry:TRUE];
        [client sendHttpRequest:url selector:@selector(onStopPractiseReturn:) json:YES showWaiting:NO];
        return;
        
  
}

- (void)practiseSkill:(UIButton*)btn{
    NSLog(@"train skill");
    int i = btn.tag;
    NSDictionary *ext = [ad getDataUserext];
    int jingli = [[ext valueForKey:@"jingli"] intValue];
    int stam = [[ext valueForKey:@"stam"] intValue];
    if (jingli < 0){
        [ad showMsg:@"你的精力不够，无法集中精神，休息一下吧" type:1 hasCloseButton:NO];
        return;
    }
    if (stam < 0){
        [ad showMsg:@"你觉得腰酸背痛，体力似乎不够充足，休息一下再练吧" type:1 hasCloseButton:NO];
        return;
    }
    NSArray* userskills = [ad getDataUserskills];
    NSObject* skill = [[userskills objectAtIndex:i] valueForKey:@"userskill"];
    NSLog(@"%@", skill);
    NSString* name = [skill valueForKey:@"skname"];
        NSLog(@"skillname is %@", name);
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    NSString* url = [[NSString alloc] initWithFormat:@"/wh/practise?pot=1&skill=%@", name];
    [client sendHttpRequest:url selector:@selector(onPractiseReturn:) json:YES showWaiting:YES];

}

- (int) findSkillIndexByName:(NSString*) name{
    NSMutableArray* userskills = [ad getDataUserskills];
    int i = 0;
    for ( i = 0; i< [userskills count]; i++){
        NSObject* us = [[userskills objectAtIndex:i] valueForKey:@"userskill"];
        NSString* skname = [us valueForKey:@"skname"];
        if ([skname isEqualToString:name])
            return i;
    }
    return -1;
}
         
- (void) onPractiseReturn:(NSObject*) data{
    if ([data valueForKey:@"error"]){
        [ad showMsg:[data valueForKey:@"error"] type:1 hasCloseButton:YES]; 
        return;
    }
    NSObject* userskill = [[data valueForKey:@"userskill"] valueForKey:@"userskill"];
    NSLog(@"%@", userskill);
    NSMutableArray* userskills = [ad getDataUserskills];
    NSString *name = [userskill valueForKey:@"skname"];
    int i = 0;
    for ( i = 0; i< [userskills count]; i++){
        NSObject* us = [[userskills objectAtIndex:i] valueForKey:@"userskill"];
        NSString* skname = [us valueForKey:@"skname"];
        if ([skname isEqualToString:name]){
            int level = [[us valueForKey:@"level"] intValue];
            int level2 = [[userskill valueForKey:@"level"] intValue];
            if (level2 > level)
                [ad showMsg:[NSString stringWithFormat:@"你的\"%@\"提升了!", skname] type:0 hasCloseButton:NO];
            [userskills replaceObjectAtIndex:i withObject: [data valueForKey:@"userskill"]];
            break;
        }
    }
    
    UIProgressView *pv = [pv_tp objectAtIndex:i];
    int tp = [[userskill valueForKey:@"tp"] intValue];
    int level = [[userskill valueForKey:@"level"] intValue];

    float process = ((float)tp)/((level+1)*(level+1));
    [pv setProgress:process];
    
    UILabel* lb = [lb_level_list objectAtIndex:i];
    NSString* stp = [[userskill valueForKey:@"tp"] stringValue];
    [lb setText:[[NSString alloc] initWithFormat:@"%@/%@", stp, [[userskill valueForKey:@"level"] stringValue]]];

    // update potential
    NSObject* userext = [[[data valueForKey:@"user"] valueForKey:@"user"] valueForKey:@"userext"];
    
    [[ad.data_user valueForKey:@"user"] setValue:userext forKey:@"userext"];
    NSLog(@"%@", ad.data_user);
    int pot = [[[ad getDataUserext] valueForKey:@"pot"] intValue];
    lbPotential.text = [NSString stringWithFormat:@"%d", pot];
    [ad reloadStatus];
    
        
}
- (void)viewDidAppear:(BOOL)animated{
    
//    [UIView setAnimationsEnabled:YES];
    NSLog(@"TrainingView DID APPEAR %d", animated);
//    CGAffineTransform initTransform = [skillsView transform];

    [skillsView setFrame:CGRectMake(-200, 200, 200, 300)];
   // [skillsView setTransform:CGAffineTransformIdentity]; 

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:) ];
    [UIView setAnimationDuration:0.15f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    skillsView.transform =
    CGAffineTransformMakeTranslation (200, 0);
    [UIView commitAnimations];
    
    
    CABasicAnimation *bounceAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    bounceAnimation.duration = 0.1f;
    bounceAnimation.fromValue = [NSNumber numberWithInt:0];
    bounceAnimation.toValue = [NSNumber numberWithInt:-20];
    bounceAnimation.repeatCount = 2;
    bounceAnimation.autoreverses = YES;
    bounceAnimation.fillMode = kCAFillModeBoth;
    bounceAnimation.removedOnCompletion = NO;
    bounceAnimation.additive = YES;
    [skillsView.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    // fade in
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:1.0];
//        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//        skillsView.alpha = 1.0;
//        [UIView commitAnimations];
    
      
    
}
- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    NSLog(@"ANIMATION stopped");
    [skillsView setTransform:CGAffineTransformIdentity]; 
    [skillsView setFrame:CGRectMake(0, 200, 320, 300)];
  
}

- (IBAction)onSelectLibrary:(id)sender {
    vcResearch.view.hidden = NO;
    skillsView.hidden = YES;
//    UIScrollView* v = (UIScrollView*)[self view] ;
    [vcResearch viewWillAppear:NO];

    
}
- (IBAction)onSelectTrainingGround:(id)sender {
    skillsView.hidden = NO;
    vcResearch.view.hidden = YES;
    CGRect rect3 = skillsView.frame;
    int scrollSize = rect3.size.height+200 - 480;
//    skillsView.backgroundColor = [UIColor redColor];
    [self viewWillAppear:NO];
    if (scrollSize > 0 ){
//        UIScrollView* sv = [self view ].superview;
        [(UIScrollView*)[self view] setContentSize:CGSizeMake(0, 200+rect3.size.height-480)];
    }
}
@end
