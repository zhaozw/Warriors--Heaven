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

//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    [view setTag:103];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.8];
//    [self.view addSubview:view];
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [activityIndicator setCenter:self.view.center];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [self.view addSubview:activityIndicator];
    anim = NO;
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
        if ([ad checkNetworkStatus] == 0){
            [ad showNetworkDown];
        }else{
            if (wvContent != NULL){
                [wvContent removeFromSuperview];
                wvContent = NULL;
            }
            wvContent = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [ad screenSize].width, [ad screenSize].height-49)];
            wvContent.backgroundColor = [UIColor clearColor];
            wvContent.opaque = NO;
            if ([ad getDeviceVersion] >=5)
                wvContent.scrollView.scrollEnabled = NO;
            [[self view ] addSubview:wvContent];
            
            wvContent.delegate = self;
            wvContent.hidden = YES;
    //        vBg.hidden = YES;
            if ([ad isRetina4])
                [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/helpboard_j_r4.html", ad.host, ad.port]]]];
            else
                [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/helpboard_j.html", ad.host, ad.port]]]];

    
        }
    }


}
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {    
//    [activityIndicator startAnimating];
    // self.view.hidden = YES;
   /* if (!anim){
        
       
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
         anim = YES;
    }
    */
     [ad showWaiting:YES];
}
- (void) setNeedUpdate{
    needUpdate  = TRUE;
}
//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
     [ad showWaiting:NO];
    needUpdate = NO;
     [self performSelector:@selector(setNeedUpdate) withObject:NULL afterDelay:1800];
 
    vBg.hidden = NO;
    wvContent.hidden = NO;
      self.view.hidden = NO;
#if 0
    if (anim){
//    [activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
      myAlert = NULL;
      
    
    /*
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.2f;
    
    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;//设置上面4种动画效果
    //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
    
    animation.subtype = kCATransitionFromRight;
    
    [self.view.layer addAnimation:animation forKey:@"animationID"];*/
    
    anim = NO;
    }
#endif

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    if ([webView isLoading])
//        [webView stopLoading];
//    [webView  stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
    
    [ad showWaiting:NO];
    
    vBg.hidden = NO;
    self.view.hidden = NO;
#if 0
    if (anim){
        
    //    [activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
    myAlert = NULL;
   
/*    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.2f;
    
    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;//设置上面4种动画效果
    //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
    
    animation.subtype = kCATransitionFromRight;
    
    [self.view.layer addAnimation:animation forKey:@"animationID"];
    */
    anim = NO;
    }
#endif
     [ad showNetworkDown];
}
@end
