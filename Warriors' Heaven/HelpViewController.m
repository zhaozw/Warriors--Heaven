//
//  HelpViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"

@implementation HelpViewController

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
    wvContent = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-49)];
    wvContent.backgroundColor = [UIColor clearColor];
    [[self view ] addSubview:wvContent];
}


- (void)viewDidUnload
{
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
    [ad showStatusView:FALSE];
    [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/helpboard.html", ad.host, ad.port]]]];
    
}
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {    
    [activityIndicator startAnimating];         
    if (myAlert==nil){        
        myAlert = [[UIAlertView alloc] initWithTitle:nil 
                                             message: @"Loading"
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
    [activityIndicator stopAnimating];    
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
}
@end
