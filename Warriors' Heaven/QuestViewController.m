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

    needUpdate = YES;
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
    

    vQuestContainer.hidden = YES;
    vQuestContainer.backgroundColor = [UIColor clearColor];
//    vQuestContainer.alpha = 0.5f;
    
//    [self view].alpha = 0.5f;
    vQuestContainer.opaque = NO;
//    vQuestContainer.frame = CGRectMake(0,-9, 320, 490);
    vQuestContainer.frame = CGRectMake(0,-9, 320, [ad screenSize].height+10);
  
//    [ad checkRentina:vQuestContainer changeSize:YES changeOrigin:YES];
 
    [vQuestContainer removeFromSuperview];
    [[ad window] addSubview:vQuestContainer];
       [btCloseQuestRoom addTarget:self action:@selector(closeQuest:) forControlEvents:UIControlEventTouchUpInside];
//    [[UIApplication sharedApplication].keyWindow addSubview:vQuestContainer];
    vQuestContainer.userInteractionEnabled = YES;
    vQuestRoom.userInteractionEnabled = YES;
    vQuestRoom.frame = CGRectMake(0,0, 320, [ad screenSize].height+10);
//     [ad checkRentina:vQuestRoom changeSize:YES changeOrigin:NO];
    [vQuestRoom setBackgroundColor:[UIColor clearColor]];
    [vQuestRoom setOpaque:NO];
    vQuestRoom.delegate = self;
    [wvLoadingQuest setBackgroundColor:[UIColor clearColor]];
    [wvLoadingQuest setOpaque:NO];
    [wvLoadingQuest loadHTMLString:[NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><img width='39' src = \"file://%@\"></body></html>", [[NSBundle mainBundle] pathForResource:@"wait3" ofType:@"gif"] ] baseURL:Nil] ;
//    [wvLoadingQuest setHidden: YES];
    
 
    
    //
    // init map
    //
    wvMap =  [[UIWebView alloc] initWithFrame:CGRectMake(0, 65, 320, [ad screenSize].height-49-65)];
    wvMap.userInteractionEnabled = TRUE;
//    [[self view] addSubview:wvMap];
//    [ad.window addSubview:wvMap];
    wvMap.backgroundColor = [UIColor whiteColor];
    wvMap.opaque = NO;
    NSString* html  = [NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><img src = \"file://%@\"></body></html>", [[NSBundle mainBundle] pathForResource:@"yangzhou_map" ofType:@"jpg"]];
    [wvMap loadHTMLString:html baseURL:nil];
//    wvMap.scrollView.showsVerticalScrollIndicator = NO;
//    wvMap.scrollView.showsHorizontalScrollIndicator = NO;
    wvMap.hidden = NO;
    
}

- (void) retrieveQuests{
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/quest?v=2" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
}

- (void) closeQuest:(UIButton*) btn{
    // hide quest view
    vQuestContainer.hidden = YES;
    [ad showStatusView:YES];
//     [vQuestRoom loadHTMLString:@"" baseURL:nil];
    [vQuestRoom stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
 
    // reload quest list 
    [self retrieveQuests];
    [ad updateUserext];
    ad.bUserEqNeedUpdated = YES;
    [self view].hidden = NO;
 
}


- (void) onReceiveStatus:(NSObject* )data{
    needUpdate = NO;
    NSArray* unasked = [data valueForKey:@"unasked"];
    NSArray* asked = [data valueForKey:@"asked"];
    askedQuests  = asked;
    unaskedQuests = unasked;
    [self reloadQuests];
}

// realod UI from local data
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
        [pv setProgress:progress/100.0f];
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
        [btn_ask.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
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
    rect2.size.height = [unaskedQuests count]*65;
    vUnaskedQuest.frame = rect2;
    
    UIScrollView* usv = (UIScrollView*)[self view];
    int offset =  rect2.origin.y + rect2.size.height - [ad screenSize].height;
    if (offset > 0)
        usv.contentSize = CGSizeMake(0, rect2.origin.y + rect2.size.height);
    
}

- (void) onEnterQuest:(UIButton*)btn{
    int i = btn.tag;
   
    NSObject* q = [askedQuests objectAtIndex:i];
    NSString* device = @"3";
    if ([ad isRetina4]){
        device =@"r4";
    }

    NSString * url = [NSString stringWithFormat:@"http://%@:%@/quest/show?sid=%@&name=%@&device=%@", ad.host, ad.port, ad.session_id, [q valueForKey:@"name"], device];
    [vQuestRoom loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self view].hidden = YES;
      vQuestContainer.hidden = NO;
    [[ad window] bringSubviewToFront:vQuestContainer];
    [vQuestContainer bringSubviewToFront:btCloseQuestRoom];
     [ad showStatusView:NO];
//    [[ad window] makeKeyAndVisible];
//    [vQuestRoom becomeFirstResponder];
    
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
        [ad showStatusView:YES];
    [ad setBgImg:[UIImage imageNamed:@"bg6.jpg"] ];

}

- (void)viewDidAppear:(BOOL)animated {
    if (needUpdate)
        [self retrieveQuests];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request);
    NSString* url = [request.URL absoluteString];
    NSString* path = [request.URL path];
    if ( [url hasPrefix:@"map://"]){
        NSString* map_name = [[request.URL absoluteString] substringFromIndex:6];
        // load map
        NSString* map_file = [NSString stringWithFormat:@"map_%@",map_name];
        NSString* html  = [NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><img src = \"file://%@\"></body></html>", [[NSBundle mainBundle] pathForResource:map_file ofType:@"jpg"]];
            [wvMap loadHTMLString:html baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@", ad.host, ad.port]]];
//        [wvMap loadHTMLString:html baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@", ad.host, ad.port]]];
        [wvMap loadHTMLString:html baseURL:nil];
        NSLog(html);
        wvMap.hidden = NO;
        
        // hide quest view
        vQuestContainer.hidden = YES;
        [ad showStatusView:YES];
//        [vQuestRoom loadHTMLString:@"" baseURL:nil];
        // clean browser content
        [vQuestRoom stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
        return false;
    }else if ( [path hasPrefix:@"/clientaction/closequest/"]){
        [self closeQuest:NULL];
    }else
        return [ad webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    return TRUE;
}

@end
