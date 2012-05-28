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
    
    int margin_top = 70;
    [LightView createLabel:CGRectMake(30, margin_top, 60, 20) parent:[self view] text:@"战队Code" textColor:[UIColor yellowColor]];
    lbTeamCode = [LightView createLabel:CGRectMake(90, margin_top, 60, 20) parent:[self view] text:@"" textColor:[UIColor whiteColor]];    
    
    [LightView createLabel:CGRectMake(30, margin_top+20, 60, 20) parent:[self view] text:@"战队成员" textColor:[UIColor yellowColor]];
    lbMemberNumber = [LightView createLabel:CGRectMake(90, margin_top+20, 30, 20) parent:[self view] text:@"" textColor:[UIColor whiteColor]];
    
    [LightView createLabel:CGRectMake(120, margin_top+20, 30, 20) parent:[self view] text:@"战力" textColor:[UIColor yellowColor]];
    lbTeamPower = [LightView createLabel:CGRectMake(155, margin_top+20, 30, 20) parent:[self view] text:@"" textColor:[UIColor whiteColor]];
    

    
    
    
    
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
    [ad setBgImg:[UIImage imageNamed:@"bg2.jpg"] ];

    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/team" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    
 }

- (void) onReceiveStatus:(NSObject*) data{
    // reload myteam
    [vMyTeam removeAllRow];
//    NSObject* ext = [ad getDataUserext];
    NSObject * team = [data valueForKey:@"team"];
//    NSObject* members = [team valueForKey:@"members"];
    
    NSObject* members = team;
    team = [[team valueForKey:@"data"] valueForKey:@"team"];
    
    UIImageView* banner = [vMyTeam createImageViewAsRow:@"" frame:CGRectMake(0, 2, 320, 30)];
    UILabel* lb = [LightView createLabel:CGRectMake(0, 0, 100, 20) parent:banner text:@"" textColor:[UIColor whiteColor]];
    UIButton* bt = [LightView createButton:CGRectMake(120, 0, 120, 35) parent:banner text:@"邀请好友加入战队" tag:0];
    [bt setBackgroundImage:[UIImage imageNamed:@"btn_blue_light.png"] forState:UIControlStateNormal];
    
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
    lb.text = [NSString stringWithFormat:@"目前你有%d个战友", count];
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

- (void) highlightButton1:(UIButton*) btn{
//    [btMyTeam setSelected:YES];
    [btMyTeam setHighlighted:YES];
//    [btJoinTeam setSelected:NO];
    [btJoinTeam setHighlighted:NO];
}
- (void) highlightButton2:(UIButton*) btn{
//    [btJoinTeam setSelected:YES];
    [btJoinTeam setHighlighted:YES];
//    [btMyTeam setSelected:NO];
    [btMyTeam setHighlighted:NO];
}
- (IBAction)onSelectTab1:(id)sender {
    currentSelectedList = 0;
    vMyTeam.hidden =NO;
    vJoinedTeams.hidden = YES;
//    [btMyTeam setSelected:YES];
//    [btMyTeam setHighlighted:YES];
    [self performSelector:@selector(highlightButton1:) withObject:btMyTeam afterDelay:0.0];
}

- (IBAction)onSelectTab2:(id)sender {
    currentSelectedList = 1;
    vJoinedTeams.hidden = NO;
    vMyTeam.hidden = YES;
    [self performSelector:@selector(highlightButton2:) withObject:vJoinedTeams afterDelay:0.0];

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
