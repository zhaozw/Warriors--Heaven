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
@synthesize lbPotential;
@synthesize vcStatus;
@synthesize skillsView;
@synthesize vBasicSkill;
@synthesize vCommonSkill;
@synthesize vPremierSkill;
@synthesize ad;
@synthesize vBasicSkillsList;
@synthesize vCommonSkillsList;
@synthesize vPremierSkillsList;
@synthesize bt_basic_skill;
@synthesize bt_common_skill;
@synthesize bt_premier_skill;

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
    
    
//    [self addChildViewController:vcStatus];
//    [self.view addSubview:vcStatus.view];
    
    
    
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
    [self setVcStatus:nil];
    [self setLbPotential:nil];
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
    }
    
}

- (void) onReceiveStatus:(NSArray*) data{
    [ad.data_user setValue:data forKey:@"userskills"];
    ad.bUserSkillNeedUpdate = NO;
    // e.g. 
    //     [{"userskill":{"skdname":"dodge","created_at":null,"updated_at":null,"sid":"d434740f4ff4a5e758d4f340d7a5f467","level":0,"uid":1,"skname":"dodge","id":2,"enabled":1,"tp":0,"skid":2}},{"userskill":{"skdname":"parry","created_at":null,"updated_at":null,"sid":"d434740f4ff4a5e758d4f340d7a5f467","level":0,"uid":1,"skname":"parry","id":3,"enabled":1,"tp":0,"skid":3}},{"userskill":{"skdname":"unarmed","created_at":null,"updated_at":null,"sid":"d434740f4ff4a5e758d4f340d7a5f467","level":0,"uid":1,"skname":"unarmed","id":1,"enabled":1,"tp":0,"skid":1}}]
   
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
    // build new rows
    NSArray* ar = data;
    int height = 50;
    int y_b = 0;
    int y_c = 0;
    int y_p = 0;
    int count_b = 0;
    int count_c = 0;
    int count_p = 0;
    for (int i = 0; i< [ar count];  i++){
        
        NSObject *o = [ar objectAtIndex:i];
        o = [o valueForKey:@"userskill"];
        NSLog(@"skill %@", [o valueForKey:@"dname"]);
        
        UILabel* lbSkillTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [lbSkillTitle setFont:[UIFont fontWithName:@"System Bold" size:13.0f]];
        [lbSkillTitle setTextColor:[UIColor whiteColor]];
        [lbSkillTitle setBackgroundColor:[UIColor clearColor]];
        [lbSkillTitle setOpaque:NO];
        [lbSkillTitle setText:[o valueForKey:@"dname"]];

        UILabel* lbSkillStatus = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 50, 30)];
        [lbSkillStatus setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [lbSkillStatus setTextColor:[UIColor yellowColor]];
        [lbSkillStatus setBackgroundColor:[UIColor clearColor]];
        [lbSkillStatus setOpaque:NO];
        [lbSkillStatus setText:[[NSString alloc] initWithFormat:@"%@/%@", [[o valueForKey:@"tp"] stringValue], [[o valueForKey:@"level"] stringValue]]];

        
        UIButton * btPractise = [UIButton buttonWithType:UIButtonTypeCustom];
        [btPractise setBackgroundImage:[UIImage imageNamed:@"btn_green_light"]  forState:UIControlStateNormal];
        [btPractise setBackgroundColor:[UIColor clearColor]];
        [btPractise setOpaque:NO];
        [[btPractise titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [btPractise setTitleColor:[UIColor colorWithRed:88 green:33 blue:0 alpha:1] forState:UIControlStateNormal];
        [btPractise setTitle:@"Practise" forState:UIControlStateNormal];
        [btPractise setTag:i];
        [btPractise setShowsTouchWhenHighlighted:YES];
       [btPractise addTarget:self action:@selector(practiseSkill:) forControlEvents:UIControlEventTouchUpInside];

  
        NSString* cat = [o valueForKey:@"category"];
        if ([cat isEqualToString:@"basic"]){
            count_b ++;
            [lbSkillTitle setFrame:CGRectMake(0, y_b, 80, height-10)];
            [vBasicSkillsList addSubview:lbSkillTitle];
          
            [vBasicSkillsList addSubview:lbSkillStatus];
            [lbSkillStatus setFrame:CGRectMake(90, y_b, 80, height-10)];
            
            [vBasicSkillsList addSubview:btPractise];
            [btPractise setFrame:CGRectMake(220, y_b, 70, height-17)];
            
//            [skillsView setUserInteractionEnabled:YES];
//            [vBasicSkill setUserInteractionEnabled:YES];
//            [vBasicSkillsList setUserInteractionEnabled:YES];
//            [btPractise setUserInteractionEnabled: YES];
//            [vBasicSkillsList bringSubviewToFront:btPractise];
            
            
            y_b += height;
        }else if ([cat isEqualToString:@"common"]){
            count_c ++;
            [vCommonSkillsList addSubview:lbSkillTitle];
            [lbSkillTitle setFrame:CGRectMake(0, y_c, 80, height)];
            [vCommonSkillsList addSubview:lbSkillStatus];
            [lbSkillStatus setFrame:CGRectMake(90, y_c, 80, height)];
            [vCommonSkillsList addSubview:btPractise];
            [btPractise setFrame:CGRectMake(300, y_c, 70, height)];
  
  
            y_c += height;
        }else if ([cat isEqualToString:@"premier"]){
            count_p ++;
            [vPremierSkillsList addSubview:lbSkillTitle];
            [lbSkillTitle setFrame:CGRectMake(0, y_p, 80, height)];
            [vPremierSkillsList addSubview:lbSkillStatus];
            [lbSkillStatus setFrame:CGRectMake(90, y_p, 80, height)];
            [vPremierSkillsList addSubview:btPractise];
            [btPractise setFrame:CGRectMake(300, y_p, 70, height)];
      
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

    vBasicSkillsList.hidden = YES;
    vCommonSkillsList.hidden = YES;
    vPremierSkillsList.hidden = YES;
    
    [bt_basic_skill setTitle:[[NSString alloc] initWithFormat:@"基础技 (%d)", count_b] forState:UIControlStateNormal];
    [bt_common_skill setTitle:[[NSString alloc] initWithFormat:@"高级技 (%d)", count_c] forState:UIControlStateNormal];
    [bt_premier_skill setTitle:[[NSString alloc] initWithFormat:@"必杀技 (%d)", count_p] forState:UIControlStateNormal];
}

- (void)practiseSkill:(UIButton*)btn{
    NSLog(@"train skill");
}

- (void)viewDidAppear:(BOOL)animated{
    
//    [UIView setAnimationsEnabled:YES];
    NSLog(@"DID APPEAR %d", animated);
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

@end
