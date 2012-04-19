//
//  TeamViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TeamViewController.h"
#import "WHHttpClient.h"
#import "LightRowView.h"


@implementation TeamViewController
@synthesize vMyTeam;
@synthesize vJoinedTeams;
@synthesize currentSelectedList;
@synthesize needReload;
@synthesize ad;
@synthesize tfTeamCode;
@synthesize lbMemberNumber;
@synthesize lbTeamPower;

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
    ad = [UIApplication sharedApplication].delegate;
    
    [vMyTeam init1];
    vMyTeam.frame = CGRectMake(0, 150, 320, 500);
    [vMyTeam setBackgroundColor:[UIColor clearColor]];
    
    vJoinedTeams.frame = CGRectMake(0, 130, 320, 500);
    [vJoinedTeams setBackgroundColor:[UIColor clearColor]];
    
    currentSelectedList = 0;
    needReload =TRUE;
    
    [LightView createLabel:CGRectMake(0, 60, 50, 20) parent:[self view] text:@"战队成员" textColor:[UIColor yellowColor]];
    lbMemberNumber = [LightView createLabel:CGRectMake(30, 60, 30, 20) parent:[self view] text:@"" textColor:[UIColor whiteColor]];
    
    [LightView createLabel:CGRectMake(0, 80, 50, 20) parent:[self view] text:@"战力" textColor:[UIColor yellowColor]];
    lbTeamPower = [LightView createLabel:CGRectMake(30, 80, 30, 20) parent:[self view] text:@"" textColor:[UIColor whiteColor]];
    
    
}

- (void)viewDidUnload
{
    [self setVMyTeam:nil];
    [self setVJoinedTeams:nil];
    [self setTfTeamCode:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL) animated{
    NSLog(@"Team view will appear");
//    if (!needReload)
//        return;
    

    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/team" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    
 }

- (void) onReceiveStatus:(NSObject*) data{
    // reload myteam
    [vMyTeam removeAllRow];
//    NSObject* ext = [ad getDataUserext];
    NSObject * team = [data valueForKey:@"team"];
    NSObject* members = [team valueForKey:@"members"];
    
    
    for (int i = 0; i< 8; i++){
        NSObject* user = [members valueForKey:[[NSNumber numberWithInt:i] stringValue]];
        if (!user)
            continue;
        user = [user valueForKey:@"user"];
        int userId = [[user valueForKey:@"id"] intValue];
        NSString* sUser = [user valueForKey:@"user"];
        int profile = [[user valueForKey:@"profile"] intValue];
        NSString* userProfile = [NSString stringWithFormat:@"p_%d.png", profile];
        
        LightRowView * lrv = [vMyTeam addRowView:sUser logo:userProfile btTitle:@"Delete" btnTag:userId];
//        lrv.lbTitle.backgroundColor = [UIColor redColor];
    }
    int h = vMyTeam.frame.size.height + vMyTeam.frame.origin.y - 380;
    if (h > 0)
        ((UIScrollView*)[self view]).contentSize = CGSizeMake(0, h+380);
//    [vJoinedTeams removeAllRow];
}

- (void) viewDidAppear:(BOOL) animated{
    
    
}

- (IBAction)onSelectTab1:(id)sender {
    currentSelectedList = 0;
    vMyTeam.hidden =YES;
    vJoinedTeams.hidden = NO;
    
}

- (IBAction)onSelectTab2:(id)sender {
    currentSelectedList = 1;
    vJoinedTeams.hidden = YES;
    vMyTeam.hidden = NO;
}
- (IBAction)onJoinTeam:(id)sender {
}

- (IBAction)onHelpTeamCode:(id)sender {
}
@end
