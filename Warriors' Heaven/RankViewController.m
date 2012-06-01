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
    AppDelegate* ad = [UIApplication sharedApplication].delegate;
    NSString *surl = [NSString stringWithFormat:@"http://%@:%@/wh/rank?sid=%@", ad.host, ad.port, ad.session_id];
    [vRankWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:surl]]];
    
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

@end
