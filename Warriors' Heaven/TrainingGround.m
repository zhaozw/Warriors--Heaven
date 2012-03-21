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
@synthesize vcStatus;
@synthesize skillsView;
@synthesize vBasicSkill;
@synthesize vCommonSkill;
@synthesize vPremierSkill;
@synthesize ad;
@synthesize vBasicSkillsList;
@synthesize vCommonSkillsList;
@synthesize vPremierSkillsList;

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
    
    
    [self addChildViewController:vcStatus];
    [self.view addSubview:vcStatus.view];
    
    
    
    //  UIImageView skillsView = [[UIImageView alloc] initWithImage:UIImage imageNamed:@"skillview.png")];
    skillsView = [[UIView alloc] initWithFrame:CGRectMake(-200, 200, 300, 300)];
    [skillsView setBackgroundColor:[UIColor redColor]];
//    [skillsView setAlpha:0.5f];
    [skillsView setOpaque:NO];
    [skillsView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:skillsView];
    
    vBasicSkill = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    [vBasicSkill setBackgroundColor:[UIColor clearColor]];
    [vBasicSkill setOpaque:FALSE];
    
    [skillsView addSubview:vBasicSkill];
    UIButton * bt_basic_skill = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imageNormal = [UIImage imageNamed:@"btn_skill.png"];
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:30 topCapHeight:0];
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
    vBasicSkillsList  = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 300, 20)];
//    [vBasicSkillsList setBackgroundColor:[UIColor blueColor]];
    [vBasicSkill addSubview:vBasicSkillsList];
    vBasicSkillsList.hidden = YES;
    
    
    
    vCommonSkill = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 300, 20)];
    [vCommonSkill setBackgroundColor:[UIColor clearColor]];
    [vCommonSkill setOpaque:FALSE];
    [skillsView addSubview:vCommonSkill];
    UIButton * bt_common_skill = [UIButton buttonWithType:UIButtonTypeCustom];
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
    vCommonSkillsList  = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 300, 20)];
    [vCommonSkill addSubview:vCommonSkillsList];
    vCommonSkillsList.hidden = YES;
    
    vPremierSkill = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 300, 20)];
    [vPremierSkill setBackgroundColor:[UIColor clearColor]];
    [vPremierSkill setOpaque:FALSE];
    [skillsView addSubview:vPremierSkill];
    UIButton * bt_premier_skill = [UIButton buttonWithType:UIButtonTypeCustom];
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
                [vBasicSkill setFrame: CGRectMake(0, 0, 300, height)];
                CGRect rect = vCommonSkill.frame;
                rect.origin.y += offset;
                [vCommonSkill setFrame:rect];
                 rect = vPremierSkill.frame;
                rect.origin.y += offset;
                [vPremierSkill setFrame:rect];
                
            }else{
                vBasicSkillsList.hidden = YES;
                int height = vBasicSkill.frame.size.height;
                [vBasicSkill setFrame: CGRectMake(0, 0, 300, 20)];
                CGRect rect = vCommonSkill.frame;
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
    
    if (ad.bUserSkillNeedUpdate){
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        [client sendHttpRequest:@"/userskills" selector:@selector(onReceiveStatus:) showWaiting:YES];
    }
    
}

- (void) onReceiveStatus:(NSArray*) data{
    [ad.data_user setValue:data forKey:@"userskills"];
  
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
    int height = 30;
    int y_b = 0;
    int y_c = 0;
     int y_p = 0;
    for (int i = 0; i< [ar count];  i++){
        
        NSObject *o = [ar objectAtIndex:i];
        o = [o valueForKey:@"userskill"];
        NSLog(@"skill %@", [o valueForKey:@"dname"]);
        UIButton * btPractise = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btPractise setBackgroundImage:[UIImage imageNamed:@""]  forState:UIControlStateNormal];

        [btPractise setBackgroundColor:[UIColor clearColor]];
        [btPractise setOpaque:NO];
        [[btPractise titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [btPractise setTitleColor:[UIColor colorWithRed:88 green:33 blue:0 alpha:1] forState:UIControlStateNormal];
        [btPractise setTitle:@"Practise" forState:UIControlStateNormal];
//        [btPractise setTag:10];
//        [btPractise addTarget:self action:@selector(selectedSkillBt:) forControlEvents:UIControlEventTouchUpInside];
        NSString* cat = [o valueForKey:@"category"];
        if ([cat isEqualToString:@"basic"]){
            
            [vBasicSkillsList addSubview:btPractise];
            [btPractise setFrame:CGRectMake(0, y_b, 50, height)];
            y_b += height;
        }else if ([cat isEqualToString:@"common"]){
            [btPractise setFrame:CGRectMake(300, y_b, 50, height)];
            [vBasicSkillsList addSubview:btPractise];
            [vCommonSkillsList addSubview:btPractise];
            y_c += height;
        }else if ([cat isEqualToString:@"premier"]){
            [btPractise setFrame:CGRectMake(300, y_b, 50, height)];
            [vBasicSkillsList addSubview:btPractise];
            [vPremierSkillsList addSubview:btPractise];
            y_p += height;
        }
        
    }
    
    CGRect rect = vBasicSkillsList.frame;
    rect.size.height = y_b+20;
    [vBasicSkillsList setFrame:rect];
    rect = vCommonSkillsList.frame;
    rect.size.height = y_c+20;
    [vCommonSkillsList setFrame:rect];
    rect = vPremierSkillsList.frame;
    rect.size.height = y_p+20;
    [vPremierSkillsList setFrame:rect];
    

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
    [skillsView setFrame:CGRectMake(0, 200, 200, 300)];
  
}

@end
