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
@synthesize btJoinTeam;
@synthesize vMyTeam;
@synthesize vJoinedTeams;
@synthesize currentSelectedList;
@synthesize needReload;
@synthesize ad;
@synthesize tfTeamCode;
@synthesize lbMemberNumber;
@synthesize lbTeamPower;
@synthesize lbTeamCode;
@synthesize btMyTeam;

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
    
    vJoinedTeams.frame = CGRectMake(0, 150, 320, 500);
    [vJoinedTeams setBackgroundColor:[UIColor clearColor]];
    
    currentSelectedList = 0;
    needReload =TRUE;
    
    [LightView createLabel:CGRectMake(0, 65, 60, 20) parent:[self view] text:@"战队Code" textColor:[UIColor yellowColor]];
    lbTeamCode = [LightView createLabel:CGRectMake(60, 65, 60, 20) parent:[self view] text:@"" textColor:[UIColor whiteColor]];    
    
    [LightView createLabel:CGRectMake(0, 85, 60, 20) parent:[self view] text:@"战队成员" textColor:[UIColor yellowColor]];
    lbMemberNumber = [LightView createLabel:CGRectMake(60, 85, 30, 20) parent:[self view] text:@"" textColor:[UIColor whiteColor]];
    
    [LightView createLabel:CGRectMake(100, 85, 30, 20) parent:[self view] text:@"战力" textColor:[UIColor yellowColor]];
    lbTeamPower = [LightView createLabel:CGRectMake(135, 85, 30, 20) parent:[self view] text:@"" textColor:[UIColor whiteColor]];
    

    
    
    
    
}

- (void)viewDidUnload
{
    [self setVMyTeam:nil];
    [self setVJoinedTeams:nil];
    [self setTfTeamCode:nil];
    [self setBtMyTeam:nil];
    [self setBtJoinTeam:nil];
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
    
    int count = 0;
    for (int i = 0; i< 8; i++){
        NSObject* user = [members valueForKey:[[NSNumber numberWithInt:i] stringValue]];
        if (!user)
            continue;
        user = [user valueForKey:@"user"];
        int userId = [[user valueForKey:@"id"] intValue];
        NSString* sUser = [user valueForKey:@"user"];
        int profile = [[user valueForKey:@"profile"] intValue];
        NSString* userProfile = [NSString stringWithFormat:@"p_%d.png", profile];
        
        LightRowView * lrv = [vMyTeam addRowView:sUser logo:userProfile btTitle:@"Delete" btnTag:i];
        [[lrv button:0] addTarget:self action:@selector(onDeleteMember:) forControlEvents:UIControlEventTouchUpInside];
        
//        lrv.lbTitle.backgroundColor = [UIColor redColor];
        count++;
    }
    lbTeamCode.text = [team valueForKey:@"code"];
    lbMemberNumber.text  = [[NSNumber numberWithInt:count] stringValue];
    lbTeamPower.text = [ [team valueForKey:@"power"] stringValue];
    int h = vMyTeam.frame.size.height + vMyTeam.frame.origin.y - 380;
    if (h > 0)
        ((UIScrollView*)[self view]).contentSize = CGSizeMake(0, h+380);
//    [vJoinedTeams removeAllRow];
}

- (void) onDelMemberReturn:(NSObject*)data{
    
}

- (void) onDeleteMember:(UIButton*) btn{
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:[NSString stringWithFormat:@"/team/delmember?i=%d", btn.tag ] selector:@selector(onDelMemberReturn:) json:YES showWaiting:YES];
//    [btn.superview removeFromSuperview];
    [vMyTeam deleteRow:btn.superview]; 
    lbMemberNumber.text = [[NSNumber numberWithInt:[lbMemberNumber.text intValue]-1] stringValue];
}
- (void) viewDidAppear:(BOOL) animated{
    
    
}

- (IBAction)onSelectTab1:(id)sender {
    currentSelectedList = 0;
    vMyTeam.hidden =NO;
    vJoinedTeams.hidden = YES;
    [btMyTeam setSelected:YES];
    [btMyTeam setHighlighted:YES];
    
}

- (IBAction)onSelectTab2:(id)sender {
    currentSelectedList = 1;
    vJoinedTeams.hidden = NO;
    vMyTeam.hidden = YES;
}

- (IBAction)onJoinTeam:(id)sender {
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:[NSString stringWithFormat:@"/team/join?code=%@", tfTeamCode.text] selector:@selector(onJoinTeamReturn:) json:YES showWaiting:YES];
    [tfTeamCode resignFirstResponder];
}

- (void) onJoinTeamReturn:(NSString*)data{
    NSString* error = [data valueForKey:@"error"];
    if (error){
        [ad showMsg:error type:1 hasCloseButton:YES];
        return;
    }
    NSString* success = [data valueForKey:@"OK"];
    if (success){
        tfTeamCode.text = @"";
        [ad showMsg:success type:0 hasCloseButton:YES];
        return;
    }
        

}

- (IBAction)onHelpTeamCode:(id)sender {
    NSString* helpUrl = [NSString stringWithFormat:@"http://%@:%@/help?cat=team&name=teamcode", ad.host, ad.port];
    [ad showHelpView:helpUrl];
}
// hide system keyboard when user click "return"
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [tfTeamCode resignFirstResponder];
    return YES;
}
@end
