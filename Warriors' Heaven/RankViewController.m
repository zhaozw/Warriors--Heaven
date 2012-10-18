//
//  RankViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RankViewController.h"
#import <QuartzCore/QuartzCore.h>
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
      ad = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view from its nib.
//    vRankWeb.frame = CGRectMake(0, 0, [ad screenSize].width, [ad screenSize].height-49);
       AppDelegate* ad = [UIApplication sharedApplication].delegate;

    needUpdate = YES;
    vRankWeb.hidden = YES;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    [view setTag:103];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.8];
//    [self.view addSubview:view];

    
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [activityIndicator setCenter:view.center];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [view addSubview:activityIndicator];
    anim = NO;
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
    [ad setBgImg:[UIImage imageNamed:@"bg5.jpg"]];
    [ad showStatusView:FALSE];
    
//    vRankWeb.frame = CGRectMake(0, 0, 320, 480);
//    vRankWeb.frame = CGRectMake(0, 0, [ad screenSize].width, [ad screenSize].height-49);
    
    if (needUpdate){
        if ([ad checkNetworkStatus] == 0){
            [ad showNetworkDown];
        }else{
            if (vRankWeb != NULL){
                [vRankWeb removeFromSuperview];
                vRankWeb = NULL;
            }
            vRankWeb  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [ad screenSize].width, [ad screenSize].height-49)];
            vRankWeb.backgroundColor = [UIColor clearColor];
            [ad fullScreen:self.view];            
            vRankWeb.delegate = self;
            vRankWeb.opaque = NO;
            [[self view] addSubview:vRankWeb];

            NSString *surl = [NSString stringWithFormat:@"http://%@:%@/rank?sid=%@", ad.host, ad.port, ad.session_id];
//            [vRankWeb stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
         
            [vRankWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:surl]]];
   
        }

    }
    else{
        CATransition *animation = [CATransition animation];
        
        animation.duration = 0.2f;
        
        //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionPush;//设置上面4种动画效果
        //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
        
        animation.subtype = kCATransitionFromRight;
        
        [self.view.layer addAnimation:animation forKey:@"animationID"];
    }
//    vRankWeb.backgroundColor = [UIColor redColor];

}
- (void) setNeedUpdate{
    needUpdate  = TRUE;
}
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [ad showWaiting:YES];
    self.view.hidden = YES;
/*
    if (!anim)
    {
    //    [activityIndicator startAnimating];
  
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
       anim = YES;
    }
 */
}

//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [ad showWaiting:NO];
     needUpdate = FALSE;
     [self performSelector:@selector(setNeedUpdate) withObject:NULL afterDelay:180];
    self.view.hidden = NO;
    vRankWeb.hidden  = NO;
/*    if (anim){
//    [activityIndicator stopAnimating];    
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
     [myAlert dismissWithClickedButtonIndex:0 animated:YES];
    myAlert = NULL;
    anim = NO;
    }*/

    
  /*  CATransition *animation = [CATransition animation];
    
    animation.duration = 0.2f;
    
    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;//设置上面4种动画效果
    //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom

        animation.subtype = kCATransitionFromRight;
 
    [self.view.layer addAnimation:animation forKey:@"animationID"];
   */
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    if ([webView isLoading])
//        [webView stopLoading];
//    [webView  stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
 [ad showWaiting:NO];
    self.view.hidden = NO;
#if 0
    if (anim){
        
    //    [activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
    myAlert = NULL;
    anim = NO;
    
    
  /*  CATransition *animation = [CATransition animation];
    
    animation.duration = 0.2f;
    
    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;//设置上面4种动画效果
    //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
    
    animation.subtype = kCATransitionFromRight;
    
    [self.view.layer addAnimation:animation forKey:@"animationID"];
   */
    }
#endif
    [ad showNetworkDown];
}
@end
