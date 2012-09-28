//
//  HomeViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import <Foundation/NSURLRequest.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "SBJson.h"
#import "WHHttpClient.h"
#import "EGOImageButton.h"
#import "EGOImageView.h"
#import "LightView.h"
#import "Lunar.h"

@implementation HomeViewController
@synthesize lbUserName;

//@synthesize vStatus;
@synthesize vSummary;
@synthesize lbStatus;
@synthesize vcStatus;
@synthesize btCloseFloat1;
@synthesize lbTitle;
@synthesize playerProfile;
@synthesize bgView;
@synthesize vHomeUnder;
@synthesize vHome;
@synthesize vBadge;
@synthesize ad;
@synthesize vSeasonImag;
@synthesize vProfileBg;
@synthesize lbDate;
@synthesize lbMonth;
@synthesize lbTiming;
@synthesize lbTimingInfo;

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
-(void)viewWillAppear:(BOOL)animated {

/*
    NSURL* url = [NSURL URLWithString:@"http://192.168.0.24:3000/test1"];
  //  [NSString stringWithContentsOfURL:(NSURL *)url];  

    NSMutableURLRequest* request = [NSMutableURLRequest new];  
    [request setURL:url];  
    [request setHTTPMethod:@"GET"];  
     NSURLResponse* response;  
     NSData* data = [NSURLConnection sendSynchronousRequest:request  
                                         returningResponse:&response error:nil];  
     NSString* strRet = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];  
     NSLog(@"%@", strRet);  
    //[strRet release];  
    */
//    AppDelegate * ad = [UIApplication sharedApplication].delegate;
//    [ad setBgImg:[UIImage imageNamed:@"background.PNG"] ];
    [ad setBgImg:[UIImage imageNamed:@"bg5.jpg"] ];
//    [self recoverWebView];
    
}
- (void) viewDidAppear:(BOOL) animated{
    NSLog(@"viewDidAppear");
    [ad showStatusView:YES];
    // setup season image and date time
    vSeasonImag.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/game/other/spring.png", ad.host, ad.port]];
    
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    if (ad.data_user){
        NSObject* json = [ad.data_user valueForKey:@"user"];
        lbUserName.text = [json valueForKey:@"user"];
//        lbTitle.text = [json valueForKey:@"title"];
        id title = [[ad getDataUserext] valueForKey:@"title"];
        if (title != [NSNull null])
            lbTitle.text = title;
        
        // show badges
        vBadge.frame = CGRectMake(20, 200, 250, 35);
        [vBadge setBackgroundColor:[UIColor clearColor]];
        NSArray* badges = [[ad getDataUserext] valueForKey:@"badges"];
        for (int i = 0; i < [badges count]; i++){
            NSObject* b = [badges objectAtIndex:i];
            NSString * image = [b valueForKey:@"image"];
            EGOImageButton * btn_badge = [[EGOImageButton alloc] initWithFrame:CGRectMake(35*i,0, 35, 35)];
            [btn_badge setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@%@", ad.host, ad.port, image]]];
            [btn_badge addTarget:self action:@selector(showHelpForBadge:) forControlEvents:UIControlEventTouchUpInside];
            btn_badge.tag = i;
            [vBadge addSubview:btn_badge];
        }
        
    }else{
        [ad updateUserData];
    }
    
    // set player profile
    id prof = [[ad getDataUser] valueForKey:@"profile"];
    int iProf = 0;
    if (prof != NULL && prof != [NSNull null] )
        iProf = [prof intValue];
    
    if (iProf > 5){
        NSString* sProf = [NSString stringWithFormat:@"http://%@:%@/game/profile/p_%db.png", ad.host, ad.port, iProf];
        [playerProfile setImageURL:[NSURL URLWithString:sProf]];
    }else{
        NSString* sProf = [NSString stringWithFormat:@"p_%db.png", iProf];
        
        [playerProfile setImage:[UIImage imageNamed:sProf]];
    }

    //[vcStatus viewDidAppear:NO];

    

}

- (void) showHelpForBadge:(UIButton*) btn{
    int i = btn.tag;      
    NSArray* badges = [[ad getDataUserext] valueForKey:@"badges"];
    NSObject* b = [badges objectAtIndex:i];
    NSString * name = [b valueForKey:@"name"];
    NSString* helpUrl = [NSString stringWithFormat:@"http://%@:%@/help?cat=badge&name=%@", ad.host, ad.port, name];
    [ad showHelpView:helpUrl];
}
#pragma mark - View lifecycle
/*
- (void)sendHttpRequest:(NSString*)cmd{
    
    if (self->waiting)
        return;
    self->buf = [[NSMutableData alloc] initWithLength:0];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];         
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://192.168.0.24:3006",cmd]]];
    [request setHTTPMethod:@"GET"];
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    //if (ad.session_id != nil)
        //[request addValue:ad.session_id forHTTPHeaderField:@"Cookie"];
    if (cookie)
        [request addValue:cookie forHTTPHeaderField:@"Cookie"];
    else{ // first request
        if (ad.session_id != nil){
            NSString * c = [[NSString alloc] initWithFormat:@"_wh_session=%@;", ad.session_id];
            NSLog(@"First request cookie:%@", c);
            [request addValue:c forHTTPHeaderField:@"Cookie"];
        }
    }
    //  NSMutableData* buf = [[NSMutableData alloc] initWithLength:0];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"send cmd to http server: %@", cmd);
    //    NSString * s = [[NSString alloc] initWithString:statusView.text];
    lbStatus.text = [NSString stringWithFormat:@"%@ send cmd to http server: %@", lbStatus.text, cmd];
    //  [connection release];
    
    //[request release];
    
    // display waiting dialog
    self->waiting = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]  bounds]];
    [self->waiting setBackgroundColor:[UIColor blackColor]];
    [self->waiting setAlpha:0.5f]; 
  //  [self->waiting setUserInteractionEnabled:false];
    //[self->waiting setOpaque:TRUE];

    
    // Create and add the activity indicator  
  //  UIWebView *aiv = [[UIWebView alloc] initWithFrame:CGRectMake(waiting.bounds.size.width/2.0f - 234, waiting.bounds.size.height/2.0f-130, 468, 260 )];
      UIWebView *aiv = [[UIWebView alloc] initWithFrame:CGRectMake(120, 200, 50, 50 )];
 //   UIWebView *aiv = [[UIWebView alloc] initWithFrame:CGRectMake(0, (480-260)/2, 468, 260 )];
    [aiv setBackgroundColor:[UIColor clearColor]];
    [aiv setOpaque:NO];
    
  //  [aiv setAlpha:0.0f];
    NSLog(@"%@", [NSString stringWithFormat:@"<html><body><img src = 'file://%@/button2.png'></body></html>", [[NSBundle mainBundle] bundlePath] ]);
    [aiv loadHTMLString:[NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><img width='39' src = \"file://%@\"></body></html>", [[NSBundle mainBundle] pathForResource:@"wait3" ofType:@"gif"] ] baseURL:Nil] ;
    //aiv.center = CGPointMake(waiting.bounds.size.width / 2.0f, waiting.bounds.size.height - 40.0f);  
 //   [aiv startAnimating];  
    [self->waiting addSubview:aiv];  
    //[aiv release];  
    
    // Auto dismiss after 3 seconds  
  //  [self performSelector:@selector(performDismiss) withObject:nil afterDelay:3.0f];  
    [[[UIApplication sharedApplication].delegate window] addSubview:self->waiting];
    [[[UIApplication sharedApplication].delegate window] bringSubviewToFront:self->waiting];
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    bgView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
//    
//    [bgView setImage:[UIImage imageNamed:@"background.png"]];
//    [self.view addSubview:bgView];
    hideWebViewCount = 0;
    ad = [UIApplication sharedApplication].delegate;
    // set strechable image for report view
    UIImage *imageNormal = [UIImage imageNamed:@"reportboard.png"];
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:20];
    UIImage* rimage = [imageNormal resizableImageWithCapInsets:UIEdgeInsetsMake(30, -1, 30, -1)];
    //设置帽端为12px,也是就左边的12个像素不参与拉伸,有助于圆角图片美观
    [self->viewReport setImage:rimage  ];
	
   // [playerProfile setBackgroundColor:[UIColor whiteColor]];
    
    // add status view
//    [self addChildViewController:vcStatus];
//    [self.view addSubview:vcStatus.view];
    
//    viewReport.animationImages= [NSArray arrayWithObjects:
//                                 [UIImage imageNamed:@"scroll1.png"],
//                                 [UIImage imageNamed:@"scroll2.png"],
//                                 [UIImage imageNamed:@"reportboard.png"],
//                                 nil];
    
    [[self lbTitle ] setText:@""];
    [lbUserName setText:@""];
    
    [vSummary setBackgroundColor:[UIColor clearColor]];
    [vSummary setOpaque:NO];
    vSummary.delegate = self;
    [viewReport setUserInteractionEnabled:YES];
    [viewReport addSubview:vSummary];
    vSummary.frame = CGRectMake(26, 56, 269, 175);
    
//    int content_start_y = 68;
    int content_start_y = 0;
    int margin_left = 8; // the left of vProfileBg
//    [self recoverWebView];

//    int left_seasonimg=230+5;
//    int left_month = 240;

    int left_seasonimg=5+margin_left;
    int left_month = 5+margin_left;
    
    int top_sessonimg=content_start_y+5;
    int height = 20;
    int width= 30;
    
UIView* vMain = vHome;
    
    vSeasonImag = [[EGOImageView alloc] initWithFrame:CGRectMake(left_seasonimg, top_sessonimg, 50, 50)];
    vSeasonImag.alpha = 0.39f;
//    [vProfileBg addSubview:vSeasonImag];
    [vMain addSubview:vSeasonImag];
    
    
    
    Lunar * lunar_day = [Lunar LunarForSolar:[NSDate date]];
    
    
    lbMonth = [LightView createLabel:CGRectMake(left_month, top_sessonimg+55, width, height) parent:vMain text:lunar_day.sMonthName textColor: [UIColor yellowColor]];
    
    lbMonth.alpha = 0.6f;
    [vMain bringSubviewToFront:lbMonth];
    
    lbDate = [LightView createLabel:CGRectMake(left_month+width, top_sessonimg+55, width, height) parent:vMain text:lunar_day.sDayname textColor: [UIColor colorWithRed:1.0f green:0.8f blue:0.8f alpha:1.0f]];
    lbDate.alpha = 0.6f;
    [vMain bringSubviewToFront:lbDate];
    
    // 节气
    lbTiming = [LightView createLabel:CGRectMake(left_month, top_sessonimg+55+height, width, height) parent:vMain text:lunar_day.sJieqi textColor: [UIColor colorWithRed:0.8f green:1.0f blue:0.8f alpha:1.0f]];
    lbTiming.alpha = 0.6f;
    [vMain bringSubviewToFront:lbTiming];
    
//    lbTimingInfo = [LightView createLabel:CGRectMake(left_month+width, top_sessonimg+55+height, width, height) parent:vProfileBg text:@"晴" textColor: [UIColor colorWithRed:0.6f green:0.6f blue:1.0f alpha:1.0f]];
//    lbTimingInfo.alpha = 0.6f;
    
    [vMain bringSubviewToFront:lbTimingInfo];
    
    // test http
    
//    [self sendHttpRequest:@"/editor?fdaf"];
    
    //[self sendHttpRequest:@"/"];
    //WHHttpClient* client = [[WHHttpClient alloc] init:self];
  //  [client sendHttpRequest:@"/" selector:@selector(onReceiveStatus:) showWaiting:YES];
    
    NSString* url =[NSString stringWithFormat:@"http://%@:%@/wh/summary?sid=%@", ad.host, ad.port, ad.session_id];
//    NSString* url =[NSString stringWithFormat:@"http://%@:%@/wh/summary", ad.host, ad.port, ad.session_id];
    NSLog(url);
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    NSArray                 *cookies;
//    NSDictionary            *cookieHeaders;
//     cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ]
//               cookiesForURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/", ad.host, ad.port]]];
//
//    if (!cookies){
//        
//    }
//    NSLog(@"cookies = %@", cookies);
//    cookieHeaders = [ NSHTTPCookie requestHeaderFieldsWithCookies: cookies ];
//    NSLog(@"cookies1 = %@", cookieHeaders);
//    [ req setValue: [ cookieHeaders objectForKey: @"Cookie" ]    forHTTPHeaderField: @"Cookie" ];

    // show summary
    [vSummary loadRequest:req];
    
    // show map 
    vSummary.hidden = NO;
    /* 
        use UIWebView
     */
    

    wvMap =  [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-49)];
    wvMap.userInteractionEnabled = TRUE;
    wvMap.delegate = self;
    //    [[self view] addSubview:wvMap];
    [self.view addSubview:wvMap];
    wvMap.backgroundColor = [UIColor whiteColor];
    wvMap.opaque = NO;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"map_yangzhou" ofType:@"jpg"];
    //    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];  
    //    imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];  
    imagePath = [imagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //      imagePath = [imagePath stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];  
    NSString* html  = [NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><!--script src='/javascripts/map.js' ></script--><img src = \"file://%@\" /></body></html>",imagePath];
    NSLog(@"html=%@",html);
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/", host, port]];
    //    [wvMap loadHTMLString:html baseURL:url];
    NSString *map_yangzhou_html = [[NSBundle mainBundle] pathForResource:@"map_yangzhou" ofType:@"html"];
    map_yangzhou_html = [map_yangzhou_html stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"html path=%@", map_yangzhou_html);
    [wvMap loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@", map_yangzhou_html]]]];
    //    wvMap.scrollView.showsVerticalScrollIndicator = NO;
    //    wvMap.scrollView.showsHorizontalScrollIndicator = NO;
    wvMap.hidden = NO;
    if ( [ [ [UIDevice currentDevice] systemVersion] floatValue] >= 5 ){
        wvMap.scrollView.showsHorizontalScrollIndicator = NO;
        wvMap.scrollView.showsVerticalScrollIndicator = NO;
    }else{

    }
        //    wvMap.scrollView.contentSize = CGSizeMake(1000, 1000);
//    [[wvMap scrollView] scrollRectToVisible:CGRectMake(600, 600, wvMap.scrollView.frame.size.width, wvMap.scrollView.frame.size.height) animated:NO];
//    [wvMap.scrollView setContentOffset:CGPointMake(600, 600) animated:NO];
     
    
/*
    //
    //    USE UIImageView
    //
    UIImage *imgMap = [UIImage imageNamed:@"map_yangzhou.jpg"];
    vMap = [[UIImageView alloc]  initWithImage:imgMap];
  
    [self.view addSubview:vMap];
    vMap.frame = CGRectMake(0, 0, 1369, 1512);
    vMap.opaque = YES;
    vMap.userInteractionEnabled = YES;
    vMap.contentMode = UIViewContentModeTopLeft;
    UIScrollView* sv =  (UIScrollView*)self.view;
    sv.showsVerticalScrollIndicator = NO;
    sv.showsHorizontalScrollIndicator = NO;
    CGSize size = imgMap.size;
    sv.contentSize =  CGSizeMake(imgMap.size.width-320, imgMap.size.height-480);
//    float f1 = sv.decelerationRate;
//    [sv setDecelerationRate:UIScrollViewDecelerationRateFast];
//    float f = sv.decelerationRate;
    sv.bounces = NO;
    
    
    vMap.userInteractionEnabled = YES;  
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];  
    [vMap addGestureRecognizer:singleTap];  
    
*/
    vHomeUnder.backgroundColor = [UIColor clearColor];
    vHome.backgroundColor = [UIColor clearColor];
    [[self view]bringSubviewToFront:vHome];
    [[self view] bringSubviewToFront:vHomeUnder];
    [self.view bringSubviewToFront:btCloseFloat1];
    
    
    vScrollAni = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, 50, 160)];
    [[self view ] addSubview: vScrollAni];
    vScrollAni.animationImages  = [NSArray arrayWithObjects:
                                   [UIImage imageNamed:@"scroll2.png"],
                                   [UIImage imageNamed:@"scroll3.png"],
                                   nil];
    [vHome bringSubviewToFront:vScrollAni];
}

- (void) recoverWebView{
    [[self view ] addSubview:viewReport];
    viewReport.hidden = NO;
    viewReport.frame= CGRectMake(0, 219, 320, 231);
    vSummary.frame = CGRectMake(26, 26, 269, 175);
    viewReport.alpha = 1.0f;
    
}

- (void) hideWebView{
    if (--hideWebViewCount <= 0)
        viewReport.hidden = YES;
}
- (void) floatWebView{
    if ([[ad tabBarController] selectedIndex] == 0)
        return;
   
    [[ad window] addSubview:viewReport];
    [[ad window] bringSubviewToFront:viewReport];
    viewReport.hidden = NO;
    viewReport.frame = CGRectMake(0, 480-49-30-30, 320, 60);
    vSummary.frame = CGRectMake(26, 10, 269, 30);
//    viewReport.alpha = 0.8f;
    hideWebViewCount++;
    [self performSelector:@selector(hideWebView) withObject:NULL afterDelay:3];
}
- (void) onReceiveStatus:(NSObject*) json{
    NSLog(@"HomeViewController receive data:%@", json);
    
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    
    ad.data_user = json;
//    [ad.data_user setValue:@"fdsfa" forKey:@"userskills"];
    [self viewDidAppear:NO];
}
- (void)viewDidUnload
{
    lbGold = nil;
    btGold = nil;
    viewReport = nil;
    [self setPlayerProfile:nil];
    [self setVcStatus:nil];
    [self setLbStatus:nil];
    [self setLbUserName:nil];
    [self setLbTitle:nil];
//    [self setVStatus:nil];
    [self setVSummary:nil];
    [self setVBadge:nil];
    [self setVProfileBg:nil];
    [self setVHome:nil];
    [self setVHomeUnder:nil];
    [self setBtCloseFloat1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
/*
/// http request event /////
// 收到响应时, 会触发
// 你可以在里面判断返回结果, 或者处理返回的http头中的信息
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse{
    NSLog(@"Recieve http respnse %@", aResponse.MIMEType);
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)aResponse;
    NSDictionary *fields = [HTTPResponse allHeaderFields];
    NSString *_cookie = [fields valueForKey:@"Set-Cookie"]; 
    NSLog(@"set-cookie:%@", _cookie);
    
    if (_cookie){
        self->cookie = _cookie;
        AppDelegate * ad = [UIApplication sharedApplication].delegate;
        if (ad.session_id == nil){
            NSString *regExStr = @"_wh_session=(.*?);";
            NSError *error = NULL;
            
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExStr
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:&error];

            [regex enumerateMatchesInString:cookie options:0 range:NSMakeRange(0, [cookie length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    NSLog(@"session id=%@",[cookie substringWithRange:[result rangeAtIndex:1]]);
                
                    ad.session_id = [cookie substringWithRange:[result rangeAtIndex:1]];
                NSLog(@"session id=%@", ad.session_id);
                // persist
                NSArray *Array = [NSArray arrayWithObjects:ad.session_id, nil];
                NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
                [SaveDefaults setObject:Array forKey:@"sessionid"];
                
            }];
        }
    }
}


// 每收到一次数据, 会调用一次
// 因此一般来说,是
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data
{
    [buf appendData:data];
    
     [[[UIApplication sharedApplication].delegate window] bringSubviewToFront:self->waiting];
}
// 当然buffer就是前面initWithRequest时同时声明的.

// 网络错误时触发
- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error{
    NSLog(@"http receive error:%d", error.code);
}

// 全部数据接收完毕时触发
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn{
    NSString* text =  [[NSString alloc ]initWithData:buf encoding:NSUTF8StringEncoding];
    lbStatus.text = text;
    NSLog(@"http return content:%@", text);
    
    // parse json
    //NSString* JSONString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSObject *json = [text JSONValue] ;
     NSString * v;
    if (v = [json valueForKey:@"user"])
    {
        NSLog(@"user=%@", v);
   //     NSObject *json_user = [v JSONValue];
   
    if (v = [v valueForKey:@"user"])
        lbUserName.text = v;
        NSLog(@"username=%@", v);
    }
    if (self->waiting){
        [self->waiting setHidden:true];
        [self->waiting removeFromSuperview];
        self->waiting = Nil;
    }
    //[self.view setNeedsDisplay];
}

*/

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"closereport"]){
         viewReport.hidden = YES;

        vScrollAni.hidden = NO;
        //vScrollAni.transform = CGAffineTransformIdentity;
        [vScrollAni setAnimationDuration:1.0f];
        [vScrollAni setAnimationRepeatCount:30];
        [vScrollAni startAnimating];

        
        
        
//        vHome.transform = CGAffineTransformMakeScale(1, 1);
//        vHome.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
//
//        vHome.layer.position = CGPointMake(0, vHome.layer.position.y);
        [UIView animateWithDuration:0.3f
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                          
                             vScrollAni.transform = CGAffineTransformIdentity;
//                             vHome.transform = CGAffineTransformMakeScale(0.1f,1.0f);
//                             vHome.alpha = 0.0f;
                             CGRect f = vHome.frame;
                             f.size.width = 0;
                             vHome.frame = f;
                         }
                         completion:^(BOOL finished){
                             vHome.hidden = YES;
                             [vScrollAni stopAnimating];
                         }];
  

        
      
      


       
    }else{
        
        [vScrollAni stopAnimating];
//        vScrollAni.hidden = YES;
        
//        viewReport.transform = CGAffineTransformMakeScale(1,0.1);
//        viewReport.alpha = 0.0f;
//        CGPoint point2 = viewReport.layer.position;
//        point2.y = 0;
//        viewReport.layer.position = point2;
        [UIView beginAnimations:@"scroll2" context:nil];
        [UIView setAnimationDuration:0.3];
//        viewReport.layer.anchorPoint = CGPointMake(0.5f, 0.0f);
//        viewReport.transform = CGAffineTransformMakeScale(1,1);
//        
//        viewReport.alpha = 1.0f;
        CGRect f = viewReport.frame;
        f.size.height = 200;
        viewReport.frame = f;
        [UIView commitAnimations];
          viewReport.hidden = NO;
    }
}
- (IBAction)onCloseFloat1:(id)sender {
    if (vHome.hidden){
        [btCloseFloat1 setBackgroundImage:[UIImage imageNamed:@"arrow2.png"] forState:UIControlStateNormal];
        vHome.hidden = NO;
        
        
        vScrollAni.hidden = NO;
        vScrollAni.transform = CGAffineTransformIdentity;
        [vScrollAni setAnimationDuration:1.0f];
        [vScrollAni setAnimationRepeatCount:30];
        [vScrollAni startAnimating];
//        
//        [UIView animateWithDuration:0.3
//                              delay: 0.0
//                            options: UIViewAnimationOptionCurveEaseIn
//                         animations:^{
//                          
//                         }
//                         completion:^(BOOL finished){
//                     
//                         }];

      
        
       // vHome.transform = CGAffineTransformMakeScale(0.1, 1);
//        vHome.alpha = 0.0f;
    //    CGPoint point = vHome.layer.position;

      //  vHome.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
//        point.x = 0;
//        vHome.layer.position = point;
        CGRect f = vHome.frame;
        f.size.width = 0;
        vHome.frame = f;
        [UIView beginAnimations:@"scroll" context:nil];
        
        
        
        [UIView setAnimationDelegate:self];
        //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationDuration:0.5];
       // vHome.transform = CGAffineTransformMakeScale(1,1);

        f.size.width = 320;
        vHome.frame = f;
//        vHome.alpha = 1.0f;
        CGAffineTransform t = CGAffineTransformMakeTranslation(300, 0);
        vScrollAni.transform = CGAffineTransformScale(t, 0.2, 1);
        [UIView commitAnimations];
  
    
//        viewReport.animationDuration= 1.0f;
//        viewReport.animationRepeatCount = 1;
//        
//        [viewReport startAnimating];
     
  
    }
    else{
     
            [btCloseFloat1 setBackgroundImage:[UIImage imageNamed:@"arrow1.png"] forState:UIControlStateNormal];
//        viewReport.transform = CGAffineTransformMakeScale(1,1);
//        viewReport.alpha = 0.0f;
//        CGPoint point2 = viewReport.layer.position;
//        point2.y = 0;
//        viewReport.layer.position = point2;
        [UIView beginAnimations:@"closereport" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationDuration:0.3];
//        viewReport.layer.anchorPoint = CGPointMake(0.5f, 0.0f);
//        viewReport.transform = CGAffineTransformMakeScale(1,0.1);
        
//        viewReport.alpha = 0.0f;
        CGRect f = viewReport.frame;
        f.size.height = 30;
        viewReport.frame = f;
        [UIView commitAnimations];
        
  
    }
}

- (IBAction)onTouchFight:(id)sender {
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    [[ad tabBarController] selectTab:2];
}

- (IBAction)onClickStatus:(id)sender {
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    [[ad tabBarController] selectTab:1];
}

- (IBAction)onTouchSkill:(id)sender {
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    [[ad tabBarController] selectTab:3];
}

- (IBAction)onTouchTeam:(id)sender {
    [[ad tabBarController] selectTab:4];
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
        NSMutableArray * ar = [[NSMutableArray alloc] init];
        for (int i = 0; i < [aurl count]; i++){
            NSString* s =[aurl objectAtIndex:i];
            if (s != NULL && s != [NSNull null] && [s length] >0){
                s = [s stringByReplacingOccurrencesOfString:@"<div>" withString:@""];
                s = [s stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
                 [ar addObject:s];
              
            }
        }
  
        [[ad floatMsg] addObjectsFromArray:ar];
        
//            NSLog(@"%@",[request.URL absoluteString]);
//         NSLog(surl);
//            NSLog(@"%d", [aurl count]);
//        NSLog(@"%@",request.URL);
    }else if ([[request.URL absoluteString] hasPrefix:@"myspecialurl:help//"]){
        NSString* surl = [[request.URL absoluteString] substringFromIndex:19];
        surl = [surl stringByReplacingOccurrencesOfString:@":://" withString:@"://"];
        [ad showHelpView:surl frame:CGRectMake(0, 0, 320, 480-49)];
    }else if ( [url hasPrefix:@"/clientaction/gototab/"]){
        NSString* tab = [url substringFromIndex:22];
        int iTab = [tab intValue];
        if (iTab >0)
            [[ad tabBarController] selectTab:iTab];
        return FALSE;
    }
        
    return YES;
}

//- (void) reload{
//    if (ad.data_user){
//        NSObject* json = [ad.data_user valueForKey:@"user"];
//        lbUserName.text = [json valueForKey:@"user"];
//        //        lbTitle.text = [json valueForKey:@"title"];
//        lbTitle.text = [[ad getDataUserext] valueForKey:@"title"];
//        // show badges
//        vBadge.frame = CGRectMake(20, 200, 250, 35);
//        [vBadge setBackgroundColor:[UIColor clearColor]];
//        NSArray* badges = [[ad getDataUserext] valueForKey:@"badges"];
//        for (int i = 0; i < [badges count]; i++){
//            NSObject* b = [badges objectAtIndex:i];
//            NSString * image = [b valueForKey:@"image"];
//            EGOImageButton * btn_badge = [[EGOImageButton alloc] initWithFrame:CGRectMake(35*i,0, 35, 35)];
//            [btn_badge setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@%@", ad.host, ad.port, image]]];
//            [btn_badge addTarget:self action:@selector(showHelpForBadge:) forControlEvents:UIControlEventTouchUpInside];
//            btn_badge.tag = i;
//            [vBadge addSubview:btn_badge];
//        }
//        
//    }
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
      if ( [ [ [UIDevice currentDevice] systemVersion] floatValue] >= 5 ){
    [[wvMap scrollView] scrollRectToVisible:CGRectMake(299, 260, wvMap.scrollView.frame.size.width, wvMap.scrollView.frame.size.height) animated:NO];
//    [wvMap.scrollView setContentOffset:CGPointMake(600, 600) animated:NO];
      }
    if (vSummary == webView){
        ad.bSummarDidLoad = TRUE;
        [ad hideWelcomeView];
        [ad hideRegView];
    }
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];  
    
    if (touch.view == vMap){
        NSLog(@"FDSFA");
    }
        
}


- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {  
    CGPoint p = [gestureRecognizer locationInView:vMap];
    
    int cords[20][5] ={
        {393,419,495,500,1}, 
        {761,945,822,1012,7}
    };
    int t = 0;
    int i = 0;
    int size =2;
    for ( i = 0; i< size; i++){
        if (p.x > cords[i][0] && p.x < cords[i][2] && p.y >cords[i][1] && p.y < cords[i][3]){
            break;
        }
    }

    if (i<size){
        int tab = cords[i][4];
        [[ad tabBarController] selectTab:tab];
    }
        
}  

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{  
    [scrollView setContentOffset:scrollView.contentOffset animated:YES];   
}

@end
