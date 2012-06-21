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
//    iapm_list = [[NSMutableArray alloc] init];
//    vwPurchase.delegate = self;
    iapm = [[InAppPurchaseManager alloc] init];
    [iapm setCallback:self sel:@selector(onPurchaseFinished)];
    [self view].backgroundColor = [UIColor clearColor];
    vwPurchase.backgroundColor = [UIColor clearColor];
}

- (void) onPurChaseFinished{
    
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
    }else if ([[request.URL absoluteString] hasPrefix:@"myspecialurl:iap//"]){
        //        [self floatWebView];
        NSString* surl = [[[request.URL absoluteString] substringFromIndex:18] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        NSArray* aurl = [surl componentsSeparatedByString:@"&"];
        if ([aurl count] >=2){
            NSString* param1 = [aurl objectAtIndex:0]; // id=xxx
            NSArray* params = [param1 componentsSeparatedByString:@"="];
            if ([params count]>=2){
                NSString* product = [params objectAtIndex:1]; // xxx
                if (product){
//                    product = [NSString stringWithFormat:@"com.joycom.wh.iap.%@", product];
                    NSString* stoken = [aurl objectAtIndex:1];
                    if (stoken){
                        NSArray* ar = [stoken componentsSeparatedByString:@"="]; // authority_token, yyyyy
                        if (ar && [ar count] >=2){
//                            InAppPurchaseManager*   iapm1 = [[InAppPurchaseManager alloc] init];
//                            [iapm_list addObject:iapm1];
//                            [iapm1 purchase:product tname:[ar objectAtIndex:0] tvalue:[ar objectAtIndex:1]];
//                       
 
                            iaptest = [[TestIap alloc] init];
                            [iaptest requestProUpgradeProductData];
                           [iapm purchase:product tname:[ar objectAtIndex:0] tvalue:[ar objectAtIndex:1]];

                        }
                    }
         
                    
                }
            }
        }
            
    
        //            NSLog(@"%@",[request.URL absoluteString]);
        //         NSLog(surl);
        //            NSLog(@"%d", [aurl count]);
        //        NSLog(@"%@",request.URL);
    }
    
    return YES;
}
- (IBAction)onClose:(id)sender {
    [self view ].hidden = YES;
    [vwPurchase loadHTMLString:@"" baseURL:nil];
}
@end
