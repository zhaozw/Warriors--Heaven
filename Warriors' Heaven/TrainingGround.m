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

@implementation TrainingGround
@synthesize vcStatus;
@synthesize skillsView;

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
    [self addChildViewController:vcStatus];
    [self.view addSubview:vcStatus.view];
    
    //  UIImageView skillsView = [[UIImageView alloc] initWithImage:UIImage imageNamed:@"skillview.png")];
    skillsView = [[UIView alloc] initWithFrame:CGRectMake(-200, 200, 200, 300)];
    [skillsView setBackgroundColor:[UIColor redColor]];
//    [skillsView setAlpha:0.5f];
    [skillsView setOpaque:NO];
    [skillsView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:skillsView];
    
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
    [skillsView addSubview:bt_basic_skill];
    
    UIButton * bt_common_skill = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt_common_skill setBackgroundImage:stretchableImageNormal  forState:UIControlStateNormal];
    [bt_common_skill setFrame:CGRectMake(0, 20, 200, 20)];
    [bt_common_skill setBackgroundColor:[UIColor clearColor]];
    [bt_common_skill setOpaque:NO];
    [[bt_common_skill titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [bt_common_skill setTitleColor:[UIColor colorWithRed:88 green:33 blue:0 alpha:1] forState:UIControlStateNormal];
    [bt_common_skill setTitle:@"高级技" forState:UIControlStateNormal];
    [skillsView addSubview:bt_common_skill];
    
    UIButton * bt_premier_skill = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt_premier_skill setBackgroundImage:stretchableImageNormal  forState:UIControlStateNormal];
    [bt_premier_skill setFrame:CGRectMake(0, 40, 200, 20)];
    [bt_premier_skill setBackgroundColor:[UIColor clearColor]];
    [bt_premier_skill setOpaque:NO];
    [[bt_premier_skill titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [bt_premier_skill setTitleColor:[UIColor colorWithRed:88 green:33 blue:0 alpha:1] forState:UIControlStateNormal];
    [bt_premier_skill setTitle:@"必杀技" forState:UIControlStateNormal];
    [skillsView addSubview:bt_premier_skill];

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
