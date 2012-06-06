//
//  HomeViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import <Foundation/NSURLRequest.h>
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
@synthesize lbTitle;
@synthesize playerProfile;
@synthesize bgView;
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
 
    // setup season image and date time
    vSeasonImag.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/game/other/spring.png", ad.host, ad.port]];
    
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    if (ad.data_user){
        NSObject* json = [ad.data_user valueForKey:@"user"];
        lbUserName.text = [json valueForKey:@"user"];
        lbTitle.text = [json valueForKey:@"title"];
        
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
    NSString* prof = [NSString stringWithFormat:@"p_%@b.png", [[ad getDataUser] valueForKey:@"profile"]];
    [playerProfile setImage:[UIImage imageNamed:prof]];

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
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:39];
    //设置帽端为12px,也是就左边的12个像素不参与拉伸,有助于圆角图片美观
    [self->viewReport setImage:stretchableImageNormal  ];
	
   // [playerProfile setBackgroundColor:[UIColor whiteColor]];
    
    // add status view
//    [self addChildViewController:vcStatus];
//    [self.view addSubview:vcStatus.view];
    
    
    [[self lbTitle ] setText:@""];
    [lbUserName setText:@""];
    
    [vSummary setBackgroundColor:[UIColor clearColor]];
    [vSummary setOpaque:NO];

    [viewReport setUserInteractionEnabled:YES];
     [viewReport addSubview:vSummary];
        vSummary.frame = CGRectMake(26, 26, 269, 175);
//    [self recoverWebView];

    
    vSeasonImag = [[EGOImageView alloc] initWithFrame:CGRectMake(230+5, 5, 50, 50)];
    vSeasonImag.alpha = 0.3f;
    [vProfileBg addSubview:vSeasonImag];
    
    Lunar * lunar_day = [Lunar LunarForSolar:[NSDate date]];
    
    
    lbMonth = [LightView createLabel:CGRectMake(180+60, 5+55, 30, 20) parent:vProfileBg text:lunar_day.sMonthName textColor: [UIColor yellowColor]];
    
    lbMonth.alpha = 0.6f;
    [vProfileBg bringSubviewToFront:lbMonth];
    
    lbDate = [LightView createLabel:CGRectMake(180+90, 5+55, 30, 20) parent:vProfileBg text:lunar_day.sDayname textColor: [UIColor colorWithRed:1.0f green:0.8f blue:0.8f alpha:1.0f]];
    lbDate.alpha = 0.6f;
    [vProfileBg bringSubviewToFront:lbDate];
    
    // 节气
    lbTiming = [LightView createLabel:CGRectMake(180+60, 25+55, 30, 20) parent:vProfileBg text:lunar_day.sJieqi textColor: [UIColor colorWithRed:0.8f green:1.0f blue:0.8f alpha:1.0f]];
    lbTiming.alpha = 0.6f;
    [vProfileBg bringSubviewToFront:lbTiming];
    
    lbTimingInfo = [LightView createLabel:CGRectMake(180+90, 25+55, 30, 20) parent:vProfileBg text:@"晴" textColor: [UIColor colorWithRed:0.6f green:0.6f blue:1.0f alpha:1.0f]];
    lbTimingInfo.alpha = 0.6f;
    [vProfileBg bringSubviewToFront:lbTimingInfo];
    
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

    [vSummary loadRequest:req];

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
        [[ad floatMsg] addObjectsFromArray:aurl];
        
//            NSLog(@"%@",[request.URL absoluteString]);
//         NSLog(surl);
//            NSLog(@"%d", [aurl count]);
//        NSLog(@"%@",request.URL);
    }
        
    return YES;
}
@end
