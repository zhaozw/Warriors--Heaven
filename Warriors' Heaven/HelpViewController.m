//
//  HelpViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    needUpdate = YES;
    ad = [UIApplication sharedApplication].delegate;
    [ad fullScreen:self.view];
    vBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"helpbg2.png"]];
    vBg.frame = CGRectMake(0, 0, [ad screenSize].width, [ad screenSize].height-49);
    vBg.hidden = YES;
    [self.view addSubview:vBg];
    self.view.frame = CGRectMake(0, 0, [ad screenSize].width, [ad screenSize].height-49);
    wvContent = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [ad screenSize].width, [ad screenSize].height-49)];
    wvContent.backgroundColor = [UIColor clearColor];
    wvContent.opaque = NO;
    wvContent.scrollView.scrollEnabled = NO;
    [[self view ] addSubview:wvContent];
    wvContent.delegate = self;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    [view setTag:103];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.8];
//    [self.view addSubview:view];
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [activityIndicator setCenter:self.view.center];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [self.view addSubview:activityIndicator];
    anim = YES;
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
- (void) viewWillAppear:(BOOL)animated{

}
- (void) viewDidAppear:(BOOL) animated{
    [ad showStatusView:FALSE];
    if (needUpdate){
//        vBg.hidden = YES;
        if ([ad isRetina4])
            [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/helpboard_r4.html", ad.host, ad.port]]]];
        else
            [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/helpboard.html", ad.host, ad.port]]]];
    }


}
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {    
//    [activityIndicator startAnimating];  
    if (!anim)
        return;
        self.view.hidden = YES;
    if (myAlert==nil){        
        myAlert = [[UIAlertView alloc] initWithTitle:nil 
                                             message: @"Loading Data"
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
- (void) setNeedUpdate{
    needUpdate  = TRUE;
}
//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    needUpdate = NO;
     [self performSelector:@selector(setNeedUpdate) withObject:NULL afterDelay:1800];
    [ad showNetworkDown];
    vBg.hidden = NO;
    if (!anim)
        return;
//    [activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
      myAlert = NULL;
        self.view.hidden = NO;
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.2f;
    
    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;//设置上面4种动画效果
    //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
    
    animation.subtype = kCATransitionFromRight;
    
    [self.view.layer addAnimation:animation forKey:@"animationID"];
    
    anim = NO;
    
   

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    vBg.hidden = NO;
    if (!anim)
        return;
    //    [activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
    myAlert = NULL;
    self.view.hidden = NO;
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.2f;
    
    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;//设置上面4种动画效果
    //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
    
    animation.subtype = kCATransitionFromRight;
    
    [self.view.layer addAnimation:animation forKey:@"animationID"];
    
    anim = NO;
    
}
@end
