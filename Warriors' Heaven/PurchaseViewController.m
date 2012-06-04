//
//  PurchaseViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PurchaseViewController.h"

@implementation PurchaseViewController
@synthesize vwPurchase;


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
//    vwPurchase.delegate = self;
    iapm = [[InAppPurchaseManager alloc] init];
    [self view].backgroundColor = [UIColor clearColor];
    vwPurchase.backgroundColor = [UIColor clearColor];
}

- (void)viewDidUnload
{
    [self setVwPurchase:nil];

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
    NSString* surl = [NSString stringWithFormat:@"http://%@:%@/tradables/listProduct", ad.host, ad.port];
    
    [vwPurchase loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:surl]]];
}
- (void) viewDidAppear:(BOOL) animated{
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request);
    NSString* url = [request.URL path];
    if ( [url isEqualToString:@"/quests"]){
        [[ad tabBarController] selectTab:6];
        return false;
    }else if ([[request.URL absoluteString] hasPrefix:@"myspecialurl:foo//"]){
        //        [self floatWebView];
        NSString* surl = [[[request.URL absoluteString] substringFromIndex:18] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        NSArray* aurl = [surl componentsSeparatedByString:@"<br\/>"];
        [[ad floatMsg] addObjectsFromArray:aurl];
        
        //            NSLog(@"%@",[request.URL absoluteString]);
        //         NSLog(surl);
        //            NSLog(@"%d", [aurl count]);
        //        NSLog(@"%@",request.URL);
    }
    
    return YES;
}
- (IBAction)onClose:(id)sender {
    [self view ].hidden = YES;
}
@end
