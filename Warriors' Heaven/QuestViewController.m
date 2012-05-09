//
//  QuestViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestViewController.h"
#import "AppDelegate.h"
#import "WHHttpClient.h"
#import "EGOImageButton.h"

@implementation QuestViewController
@synthesize vAskedQuest;
@synthesize vUnaskedQuest;
@synthesize ad;
@synthesize askedQuests;
@synthesize unaskedQuests;
@synthesize vQuestTitle;
@synthesize vAskedQuestTitle;
@synthesize lbQuestTitle;
@synthesize lbAskedQuestTitle;
@synthesize vQuestContainer;
@synthesize vQuestRoom;
@synthesize btCloseQuestRoom;
@synthesize wvLoadingQuest;

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

    
    [vAskedQuest setUserInteractionEnabled:YES];
    [vUnaskedQuest setUserInteractionEnabled:YES];
    [vAskedQuest setBackgroundColor:[UIColor clearColor]];
    [vUnaskedQuest setBackgroundColor:[UIColor clearColor]];
    [vQuestTitle addSubview:lbQuestTitle];
    [vAskedQuestTitle addSubview:lbAskedQuestTitle];
    
    CGRect rect = lbAskedQuestTitle.frame;
    rect.origin.y = 2;
    lbAskedQuestTitle.frame = rect;
    
    rect =lbQuestTitle.frame;
    rect.origin.y = 2;
    lbQuestTitle.frame = rect;
    
    [btCloseQuestRoom addTarget:self action:@selector(closeQuest:) forControlEvents:UIControlEventTouchUpInside];
    vQuestContainer.hidden = YES;
    vQuestContainer.backgroundColor = [UIColor clearColor];
    vQuestContainer.opaque = NO;
    vQuestContainer.frame = CGRectMake(0,0, 320, 480);
    vQuestRoom.frame = CGRectMake(0,0, 320, 480);
    [vQuestRoom setBackgroundColor:[UIColor clearColor]];
    [vQuestRoom setOpaque:NO];
    [wvLoadingQuest setBackgroundColor:[UIColor clearColor]];
    [wvLoadingQuest setOpaque:NO];
    [wvLoadingQuest loadHTMLString:[NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><img width='39' src = \"file://%@\"></body></html>", [[NSBundle mainBundle] pathForResource:@"wait3" ofType:@"gif"] ] baseURL:Nil] ;

    [self retrieveQuests];
    
}

- (void) retrieveQuests{
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/quest" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
}

- (void) closeQuest:(UIButton*) btn{
    vQuestContainer.hidden = YES;
    [ad showStatusView:YES];
     [vQuestRoom loadHTMLString:@"" baseURL:nil];
 
    [self retrieveQuests];
    [ad updateUserext];
 
}


- (void) onReceiveStatus:(NSObject* )data{
    NSArray* unasked = [data valueForKey:@"unasked"];
    NSArray* asked = [data valueForKey:@"asked"];
    askedQuests  = asked;
    unaskedQuests = unasked;
    [self reloadQuests];
}

- (void) reloadQuests{
    for(UIView *v in [vAskedQuest subviews])
    {
        [v removeFromSuperview];
    }
    for(UIView *v in [vUnaskedQuest subviews] )
    {
        [v removeFromSuperview];
    }
    int row_height = 70;
    int margin =2;
    for (int i = 0; i< [askedQuests count]; i++) {
        NSObject* o = [askedQuests objectAtIndex:i];
        NSString * name = [o valueForKey:@"dname"];
        NSString* logo = [o valueForKey:@"image"];
        NSString* desc = [o valueForKey:@"desc"];
        int progress = [[o valueForKey:@"progress"] intValue];
        
        UIImageView* row = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_quest1.png"]];
        row.frame = CGRectMake(0, i*(row_height+margin), 320, row_height);
        row.backgroundColor = [UIColor clearColor];
        [row setUserInteractionEnabled:YES];
        EGOImageButton* bt_logo = [[EGOImageButton alloc] initWithFrame:CGRectMake(2, 1, 60, 60)];
        [row addSubview:bt_logo];
        [bt_logo setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@%@", ad.host, ad.port, logo]]];
        UILabel* questName = [[UILabel alloc] initWithFrame:CGRectMake(65, 15, 100, 20)];
        [row addSubview:questName];
        [questName setText:name];
        [questName setBackgroundColor:[UIColor clearColor]];
        [questName setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [questName setTextColor:[UIColor whiteColor] ];
        
        UILabel* lb_desc = [[UILabel alloc] initWithFrame:CGRectMake(65, 35, 200, 30)];
        [row addSubview:lb_desc];
        [lb_desc setText:desc];
        [lb_desc setBackgroundColor:[UIColor clearColor]];   
        [lb_desc setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
        [lb_desc setNumberOfLines:2];
        [lb_desc setTextColor:[UIColor yellowColor] ];
        
        UIProgressView* pv = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        pv.frame = CGRectMake(2, 62, 60, 10);
        [pv setProgress:progress];
        [row addSubview:pv];
        
        UIButton* btn_ask = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_ask.frame = CGRectMake(250, 20, 60, 30);
        [row addSubview: btn_ask];
        [btn_ask setTitle:@"Enter" forState:UIControlStateNormal];
        [btn_ask setBackgroundImage:[UIImage imageNamed:@"btn_green_light.png"] forState:UIControlStateNormal];
        [btn_ask addTarget:self action:@selector(onEnterQuest:) forControlEvents:UIControlEventTouchUpInside];
        [btn_ask.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        btn_ask.tag = i;
        [row bringSubviewToFront:btn_ask];
        [vAskedQuest addSubview:row];
    }
    CGRect rect = vAskedQuest.frame;
    rect.size.height = [askedQuests count]*(row_height+margin);
    vAskedQuest.frame = rect;
    
    CGRect rect3 = vQuestTitle.frame;
    rect3.origin.y = rect.origin.y + rect.size.height+10;
    vQuestTitle.frame = rect3;
    
    for (int i = 0; i< [unaskedQuests count]; i++) {
        NSObject* o = [unaskedQuests objectAtIndex:i];
        NSString * name = [o valueForKey:@"dname"];
        NSString* logo = [o valueForKey:@"image"];
        NSString* desc = [o valueForKey:@"desc"];
        
        UIImageView* row = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_quest1.png"]];
        row.frame = CGRectMake(0, i*65, 320, 60);
        [row setUserInteractionEnabled:YES];
        row.backgroundColor = [UIColor clearColor];
        
        EGOImageButton* bt_logo = [[EGOImageButton alloc] initWithFrame:CGRectMake(2, 1, 60, 60)];
        [row addSubview:bt_logo];
        NSString* logourl = [NSString stringWithFormat:@"http://%@:%@%@", ad.host, ad.port, logo];
        NSLog(logourl);
        [bt_logo setImageURL:[NSURL URLWithString:logourl]];
        
        UILabel* questName = [[UILabel alloc] initWithFrame:CGRectMake(65, 15, 100, 20)];
        [row addSubview:questName];
        [questName setText:name];
        [questName setBackgroundColor:[UIColor clearColor]];
        [questName setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [questName setTextColor:[UIColor whiteColor] ];
        
        UILabel* lb_desc = [[UILabel alloc] initWithFrame:CGRectMake(65, 35, 200, 30)];
        [row addSubview:lb_desc];
        [lb_desc setText:desc];
        [lb_desc setBackgroundColor:[UIColor clearColor]];   
        [lb_desc setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
        [lb_desc setNumberOfLines:2];
        [lb_desc setTextColor:[UIColor yellowColor] ];
        
        UIButton* btn_ask = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_ask.frame = CGRectMake(250, 20, 60, 30);
        [row addSubview: btn_ask];
        [btn_ask setTitle:@"Ask" forState:UIControlStateNormal];
        [btn_ask setBackgroundImage:[UIImage imageNamed:@"btn_green_light.png"] forState:UIControlStateNormal];
        btn_ask.tag = i;
        [btn_ask addTarget:self action:@selector(askQuest:) forControlEvents:UIControlEventTouchUpInside];
        [row bringSubviewToFront:btn_ask];
        [vUnaskedQuest addSubview:row];
    }
    CGRect rect2 = vUnaskedQuest.frame;
    rect2.origin.y = rect3.origin.y+ rect3.size.height;
    rect2.size.height = [unaskedQuests count]*60;
    vUnaskedQuest.frame = rect2;
    
    UIScrollView* usv = (UIScrollView*)[self view];
    int offset =  rect2.origin.y + rect2.size.height - 480;
    if (offset > 0)
        usv.contentSize = CGSizeMake(0, offset+500);
    
}

- (void) onEnterQuest:(UIButton*)btn{
    int i = btn.tag;
   
    NSObject* q = [askedQuests objectAtIndex:i];
    NSString * url = [NSString stringWithFormat:@"http://%@:%@/quest/show?sid=%@&name=%@", ad.host, ad.port, ad.session_id, [q valueForKey:@"name"]];
    [vQuestRoom loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
      vQuestContainer.hidden = NO;
   
     [ad showStatusView:NO];
    
//     currentWorkingQuest = i;
}

- (void) askQuest:(UIButton*) btn{
    
    NSObject* q = [unaskedQuests objectAtIndex:btn.tag];
    NSString* url = [NSString stringWithFormat:@"/quest/ask?name=%@", [q valueForKey:@"name"]];
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:url selector:@selector(onAskQuestReturn:) json:YES showWaiting:YES];

}
- (void) onAskQuestReturn:(NSObject*) data{
    if ([data valueForKey:@"error"] != NULL){
        [ad showMsg:[data valueForKey:@"error"] type:1 hasCloseButton:YES];
        return;
    }
    unaskedQuests = [data valueForKey:@"unasked"];
    askedQuests = [data valueForKey:@"asked"];
    [self reloadQuests];

}

- (void)viewWillAppear:(BOOL)animated {
    [ad setBgImg:[UIImage imageNamed:@"bg6.jpg"] ];
}

- (void)viewDidUnload
{
    [self setVAskedQuest:nil];
    [self setVUnaskedQuest:nil];
    [self setVQuestTitle:nil];
    [self setVAskedQuestTitle:nil];
    [self setLbQuestTitle:nil];
    [self setLbAskedQuestTitle:nil];
    [self setVQuestRoom:nil];
    [self setVQuestContainer:nil];
    [self setBtCloseQuestRoom:nil];
    [self setWvLoadingQuest:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
