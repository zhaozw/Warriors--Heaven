//
//  RankViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RankViewController.h"

@implementation RankViewController
@synthesize vRankWeb;

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
    vRankWeb.frame = CGRectMake(0, 0, 320, 480-49);
    [self view ].frame = CGRectMake(0, 0, 320, 480);
    vRankWeb.delegate = self;
    vRankWeb.opaque = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [view setTag:103];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.8];
    [self.view addSubview:view];
    
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [activityIndicator setCenter:view.center];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [view addSubview:activityIndicator];
    anim = YES;
}

- (void)viewDidUnload
{
    [self setVRankWeb:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewDidAppear:(BOOL) animated{
    AppDelegate* ad = [UIApplication sharedApplication].delegate;
    NSString *surl = [NSString stringWithFormat:@"http://%@:%@/rank?sid=%@", ad.host, ad.port, ad.session_id];
      [ad showStatusView:FALSE];
    [vRankWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:surl]]];
//    vRankWeb.backgroundColor = [UIColor redColor];
        vRankWeb.frame = CGRectMake(0, 0, 320, 480);
    anim = YES;
}

//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {    
    if (!anim)
        return;
//    [activityIndicator startAnimating];         
    if (myAlert==nil){        
        myAlert = [[UIAlertView alloc] initWithTitle:nil 
                                             message: @"Loading Rank"
                                            delegate: self
                                   cancelButtonTitle: nil
                                   otherButtonTitles: nil];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(120.f, 48.0f, 37.0f, 37.0f);
        [myAlert addSubview:activityView];
        [activityView startAnimating];
        [myAlert show];
    }
}

//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (!anim)
        return;
//    [activityIndicator stopAnimating];    
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
     [myAlert dismissWithClickedButtonIndex:0 animated:YES];
    myAlert = NULL;
    anim = NO;
}
@end
