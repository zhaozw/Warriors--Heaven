//
//  AppDelegate.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "WHHttpClient.h"
#import "SBJson.h"
#import "TrainingGround.h"
#import "LightView.h"
#import <MessageUI/MFMailComposeViewController.h>


@implementation AppDelegate
@synthesize wvPreload;
@synthesize wvLoadingPreface;
@synthesize lbVersion;
@synthesize lbBattleResultTitle;
@synthesize vPreface;
@synthesize vcPurchase;

@synthesize window;
@synthesize bgView;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
//@synthesize vcCharacter;
@synthesize vcStatus;
@synthesize viewcontroller;
@synthesize tabBarController;
@synthesize vReg;
@synthesize session_id;
//@synthesize data_userext;
@synthesize data_user;
@synthesize host;
@synthesize port;
@synthesize vWelcome;
@synthesize vHelp;
@synthesize vHelpWebView;
@synthesize btCloseHelpView;
//@synthesize vcHome;
@synthesize vNetworkStatus;
@synthesize vAlertImg;
@synthesize btClose;
@synthesize lbAlertMsg;
@synthesize networkStatus;
@synthesize bUserSkillNeedUpdate;
@synthesize vBattleMsg;
@synthesize vBattleMsgBg;
@synthesize requests;
@synthesize bUserSkillNeedReload;
@synthesize tmRecoverStart;


@synthesize wvPreface;
@synthesize lbCompnayName;
@synthesize vCompanyLogo;
@synthesize bUserEqNeedUpdated;
@synthesize floatMsg;
@synthesize bSummarDidLoad;

@synthesize lbLoading;
@synthesize screenSize;
@synthesize bIsFirstRun;
@synthesize vMoreTab;
@synthesize vcTraining;

- (id) init{
    /////////////////
    // init data
    /////////////////
    
    // init const
//    host = @"localhost.joyqom.com";
//host = @"192.168.0.24";
//    host = @"localhost";
//   host = @"127.0.0.1";
  host = @"whj.joyqom.com";
    //    host = @"192.168.1.119";
//    id debug_local = [[[NSProcessInfo processInfo] environment] objectForKey:@"DEBUG_LOCAL"];
//    if (debug_local) {
//        host = @"homeserver.joyqom.com";
//    }
    UIUserInterfaceIdiom device = [UIDevice currentDevice];
//    if (device == 82924768)
//        host = @"homeserver.joyqom.com";

    
//    debug = TRUE;
    port = @"80";
    bUserEqNeedUpdated = FALSE;
//    bUpadtingStatus = false;
    debug_reg = FALSE;
    debug = FALSE;
    bSummarDidLoad = FALSE;
    preloaded = FALSE;
    return self;
}

/*
    upload new version process:
 1. check setTest not be called
 2. check serverlist will be retrieved from name server
*/

- (void) setTest{

//        debug = TRUE;
//      host = @"homeserver.joyqom.com";


//    host = @"localhost";

    host= @"192.168.0.10";

        port = @"80";
    //    session_id = @"cd675b8e71076136c6d07becdc6daa3e";// user 'hh' on product server
    //    [self setSessionId:@"cd675b8e71076136c6d07becdc6daa3e"];
    
    //    [self setSessionId:@"512298b206ac82df11e370f4021736d0"]; // user 'Spring' on product server
    //    [self setSessionId:@"8800a9ef2d3c91569eff59ed68349e46"];  // user '一灯‘ on product server
    //    [self setSessionId:@"cd675b8e71076136c6d07becdc6daa3e"];
    
    //    session_id = @"772b5e7546e46b854b248f86a4d84d8e"; // user 'dsfadfa'
//        session_id = @"ce17b7dbc51f7fc56bb6482c9a7dd9a1"; // user 'kkk'
//        session_id = @"40d2e044df294a37a604a9458e621018"; // user '燕北天'
//        session_id = @"41ef1b384cebdee01dc752b94f113db3"; // user 'vhd'
//    session_id = @"2d784425b2355425b5042330c8badc65"; // user 'gg'
//       session_id = @"0fa72802944f6dc81e9a970f888c9de0"; // user '漫画'
//    session_id = @"aa00586901918d30390e4bff784e4812"; //user fadfas
//    session_id = @"7355655bed8f48ad49b7441524e33265"; //user dddafasd
//        session_id = @"f0a28ae6cc681d3f50ae4f281cab9218"; // user 'king'
//        session_id = @"1320346951bf2bc6293fb70cc2a71a05"; // user 'queen'
    //    session_id = @"dce21c64f8788afce3960cf88734048b"; // user 'linsanity'
    //    session_id = @"c630a00633734cf4f5ff4c0de5e6e8b2"; // user '张三疯'
    

    session_id = nil; // test register new user
    [self setSessionId:session_id];


}
- (NSString *) readSessionId{
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    if (! SaveDefaults) 
        return NULL;
    
    NSArray * Array = [SaveDefaults objectForKey:@"sessionid"];
    
    if (!Array || [Array count] == 0)
        return NULL;
    
    
    return  [Array objectAtIndex:0];

}
- (void) setSessionId:(NSString *)sid{
//    if (!sid)
//        return;
    session_id = sid;
    NSArray *Array = [NSArray arrayWithObjects:sid, nil];
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    [SaveDefaults setObject:Array forKey:@"sessionid"];
    
  
//    Array = [NSArray arrayWithObjects:nil];
//    [SaveDefaults setObject:NULL forKey:@"data_user"];
}

- (NSObject*) readUserObject{
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* Array = [SaveDefaults objectForKey:@"data_user"];
    NSObject* userdata = NULL;
    if ([Array count] > 0)
        userdata = [Array objectAtIndex:0];
    NSLog(@"readUserObject datauser: %@", userdata);
    return userdata;
}


- (void) initUI{
    /////////////////
    // init UI
    /////////////////
    
    
    aiv.frame = CGRectMake(screenSize.width-38, screenSize.height-38-49, 38, 38 );
    
    // CGRect rect = [[UIScreen mainScreen] bounds];
    bgView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
    //[bgView1 setBackgroundColor:[UIColor redColor]];
//    [bgView setImage:[UIImage imageNamed:@"background.PNG"]];
    [bgView setImage:[UIImage imageNamed:@"bg5.jpg"]];
    //[bgView setHidden:FALSE];
    //    [bgView setAlpha:0.5f];
    
    [window addSubview:bgView];
    [window addSubview:tabBarController.view]; // move to onReceiveStatus, because this will show home view on top of welcome view
    
    // add create status view
    //    [window addChildViewController:vcStatus];
    // [window addSubview:self.vcStatus.view];
    //  [self.window setRootViewController:viewcontroller];
    // self.window.rootViewController = viewcontroller;
    // [self.window addSubview:viewcontroller.view];
    //   [viewcontroller viewWillAppear:FALSE];
    
    // add status view
    //    [window addChildViewController:vcStatus];
    [window addSubview:vcStatus.view];
    [vcStatus.view setBackgroundColor:[UIColor clearColor]];
    
    
     
    
    [self fullScreen:vBattleMsgBg];
    vBattleMsg. frame = CGRectMake(0, 60, screenSize.width, screenSize.height-60);
    [vBattleMsgBg setBackgroundColor:[UIColor blackColor]];
    [vBattleMsg setBackgroundColor:[UIColor blackColor]];
    

    
    // init help view
    vHelp.frame = CGRectMake(0, 0, 320, 480-60-49);
    vHelp.backgroundColor = [UIColor clearColor];
    vHelpWebView.tag = 1000;
    vHelpWebView.frame = CGRectMake(0, 60, 320, 480-60-49);
    vHelpWebView.backgroundColor = [UIColor clearColor];
    [vHelpWebView setOpaque:NO];

    btCloseHelpView.backgroundColor = [UIColor clearColor];
    [btCloseHelpView setBackgroundImage:[UIImage imageNamed:@"btn_close.png"] forState:UIControlStateNormal];
    btCloseHelpView.frame = CGRectMake(320-30, 0, 30, 30);
    [btCloseHelpView addTarget:self action:@selector(closeHelpView:) forControlEvents:UIControlEventTouchUpInside];
    vHelp.hidden = YES;
    vHelpWebView.delegate = self;
    [vcStatus view].frame = CGRectMake(0, 0, 320, 65);
    
//    controller = [[MFMailComposeViewController alloc] init];
//[window addSubview:controller.view];
//    controller.view.hidden = YES;

//    [window addSubview:[vcPurchase view]];
    [vcPurchase view].hidden = YES;
    [window bringSubviewToFront:vAlert];
    [window bringSubviewToFront:waiting];
    
/*
    id intro = [self readLocalProp:@"introduced"];
    if (intro == NULL ){
//    if (TRUE){
    
    // show Preface
    
  
    vPreface.backgroundColor = [UIColor clearColor];
    vPreface.opaque = NO;
    wvPreface.backgroundColor = [UIColor clearColor];
    wvPreface.opaque = NO;
//    [wvLoadingPreface setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
    [wvLoadingPreface setBackgroundColor:[UIColor clearColor]];
    [wvLoadingPreface setOpaque:NO];   

    wvLoadingPreface.hidden = YES;
   
//        [wvLoadingPreface loadHTMLString:[NSString stringWithFormat:@"<html><body style='background:transparent;background-color:transparent;' ><div style='position:absolute;z-index:-1;left:0;top:0;width:320px;height:480px;background-color:black;opacity:0.6;'><img width='39' src = \"file://%@\" style='position:absolute;left:130px;top:162px;'></div></body></html>", [[NSBundle mainBundle] pathForResource:@"wait3" ofType:@"gif"] ] baseURL:Nil] ;
        
//        vPreface.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];

//    wvPreface.hidden = YES;
    
    [wvPreface loadHTMLString:[NSString stringWithFormat:@"<html><body style='background:transparent;background-color:transparent;' ><div style='position:absolute;z-index:-1;left:0;top:0;width:320px;height:480px;background-color:black;opacity:0.6;'><img width='39' src = \"file://%@\" style='position:absolute;left:130px;top:162px;'></div></body></html>", [[NSBundle mainBundle] pathForResource:@"wait3" ofType:@"gif"] ] baseURL:Nil] ;
        NSString * surl = [NSString stringWithFormat:@"http://%@:%@/game/preface_j.html", host, port];
        [wvPreface loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:surl]]];  
        [wvPreface setDelegate:self];
    
    
        [vPreface bringSubviewToFront:wvPreface];
    
        [window bringSubviewToFront:vPreface];
        
        [self saveLocalProp:@"introduced" v:@"1"];
        vPreface.hidden = NO;


    }else{
        vPreface.hidden = YES;
    }
   */
 /*   
    // show map
    
    wvMap =  [[UIWebView alloc] initWithFrame:CGRectMake(0, 65, 320, 480-49-65)];
    wvMap.userInteractionEnabled = TRUE;
    wvMap.delegate = self;
    //    [[self view] addSubview:wvMap];
    [self.window addSubview:wvMap];
    wvMap.backgroundColor = [UIColor whiteColor];
    wvMap.opaque = NO;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"map_yangzhou" ofType:@"jpg"];
//    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];  
//    imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];  
    imagePath = [imagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//      imagePath = [imagePath stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];  
    NSString* html  = [NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><!--script src='/javascripts/map.js' ></script--><img src = \"file://%@\" /></body></html>",imagePath];
    NSLog(@"html=%@",html);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/", host, port]];
//    [wvMap loadHTMLString:html baseURL:url];
        NSString *map_yangzhou_html = [[NSBundle mainBundle] pathForResource:@"map_yangzhou" ofType:@"html"];
    map_yangzhou_html = [map_yangzhou_html stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"html path=%@", map_yangzhou_html);
    [wvMap loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@", map_yangzhou_html]]]];
    //    wvMap.scrollView.showsVerticalScrollIndicator = NO;
    //    wvMap.scrollView.showsHorizontalScrollIndicator = NO;
    wvMap.hidden = NO;
    */
   
    if (bShowingWelcome)
        [self topWelcomeView];
    [window makeKeyAndVisible];
    
}

- (float) getDeviceVersion{
    return deviceVersion;
}

- (BOOL) isRetina4{
    return screenSize.height > 480;
}


- (void) fullScreen:(UIView*)v{
    if (v == NULL)
        return;
    v.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
}


- (void) checkRentina:(UIView*)v changeSize:(BOOL)changeSize changeOrigin:(BOOL)changeOrigin{
    int h = screenSize.height;
    if (h>480 ){
        
        CGRect r = v.frame;
        if (changeSize)
            r.size.height = r.size.height*h/480;
        if (changeOrigin)
            r.origin.y = r.origin.y*h/480;
        v.frame = r;
    }
}
- (int) retinaHight:(int) height{
    int h = screenSize.height;
    if (h>480 ){
        
        return height * h /480;
    }else
        return height;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    // －－>20120623 comment-out because it will cause keyboard of web view not show
    // full screen
//    self.window.windowLevel = UIWindowLevelStatusBar + 1.0f; 
    // <--
    
    //self.window.backgroundColor = [UIColor whiteColor];
//    [window setRootViewController: tabBarController];
    deviceVersion= [[[UIDevice currentDevice] systemVersion] floatValue];
    if (deviceVersion>=6){
        
    }
    
    screenSize = [[UIScreen mainScreen] bounds].size;
    requests = [[NSString stringWithFormat:@"{}"] JSONValue];
    
    bUserSkillNeedUpdate = TRUE;

//    vcHome = [tabBarController.viewControllers objectAtIndex:0];
    
    floatMsg = [[NSMutableArray alloc] init];
    vMsgFloat = [[UIImageView alloc] initWithFrame:CGRectMake(0, screenSize.height-49-30, screenSize.width, 30)];
    UIImage *imageNormal = [UIImage imageNamed:@"msgbg.png"];
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [vMsgFloat setImage:stretchableImageNormal];
    [[self window] addSubview:vMsgFloat];
    vMsgFloat.hidden = YES;
//    lbMsgFloat = [LightView createLabel:CGRectMake(0, 0, 320, 30) parent:vMsgFloat text:@"" textColor:[UIColor whiteColor]];
//    vMsgFloat.backgroundColor = [UIColor grayColor];
//    lbMsgFloat.backgroundColor = [UIColor clearColor];
//    vMsgFloat.alpha = 0.6f;
    
    wvMsgFloat = [[UIWebView alloc] initWithFrame:CGRectMake(3, -5, 320, 30) ];
//    [vMsgFloat setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]];
    [vMsgFloat setOpaque:NO];
    [wvMsgFloat setBackgroundColor:[UIColor clearColor]];
    [wvMsgFloat setOpaque:NO];
    [vMsgFloat addSubview:wvMsgFloat];

    
    // set waiting must be here, because isWaiting() depend on the value of waiting.hidden
    // create waiting view
    self->waiting = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]  bounds]];
    [self->waiting setBackgroundColor:[UIColor clearColor]];
    [self->waiting setAlpha:0.8f]; 
    //  [self->waiting setUserInteractionEnabled:false];
    //[self->waiting setOpaque:TRUE];
    // Create and add the activity indicator  
    //  UIWebView *aiv = [[UIWebView alloc] initWithFrame:CGRectMake(waiting.bounds.size.width/2.0f - 234, waiting.bounds.size.height/2.0f-130, 468, 260 )];
    aiv = [[UIWebView alloc] initWithFrame:CGRectMake(screenSize.width-38, screenSize.height-38-21, 38, 38 )];
    //   UIWebView *aiv = [[UIWebView alloc] initWithFrame:CGRectMake(0, (480-260)/2, 468, 260 )];
    [aiv setBackgroundColor:[UIColor clearColor]];
    [aiv setOpaque:NO];
    
    //  [aiv setAlpha:0.0f];
    NSLog(@"%@", [NSString stringWithFormat:@"<html><body><img src = 'file://%@/button2.png'></body></html>", [[NSBundle mainBundle] bundlePath] ]);
    [aiv loadHTMLString:[NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><img width='30' src = \"file://%@\"></body></html>", [[NSBundle mainBundle] pathForResource:@"wait3" ofType:@"gif"] ] baseURL:Nil] ;
    //aiv.center = CGPointMake(waiting.bounds.size.width / 2.0f, waiting.bounds.size.height - 40.0f);  
    //   [aiv startAnimating];  
    [self->waiting addSubview:aiv];  
    //[aiv release];  

    // Auto dismiss after 3 seconds  
    //  [self performSelector:@selector(performDismiss) withObject:nil afterDelay:3.0f];  
    [window addSubview:self->waiting];
    //    [window bringSubviewToFront:self->waiting];
    waiting.hidden = YES;
    
    
    vAlert = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]  bounds]];
    [self->vAlert setBackgroundColor:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f]];
//    [self->vAlert setAlpha:0.5f]; 
    [vNetworkStatus removeFromSuperview];
    vNetworkStatus.image = [UIImage imageNamed:@"bg_dlg.png"];
    vNetworkStatus.backgroundColor = [UIColor clearColor];
    [vAlert addSubview:vNetworkStatus];
    vAlert.hidden = YES;
    [window addSubview:vAlert];
    
    
//    [vNetworkStatus setBackgroundColor:[UIColor colorWithRed:0.99f green:0.0f blue:0.0f alpha:0.3]];
    //    [lbAlertMsg setBackgroundColor:[UIColor colorWithRed:0.99f green:0.0f blue:0.0f alpha:0.3]];
    [lbAlertMsg setMinimumFontSize:0.1f];
    [lbAlertMsg setAdjustsFontSizeToFitWidth:YES];
    [lbAlertMsg setNumberOfLines:5];
    [btClose addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    session_id = [self readSessionId];
    NSLog(@"load session id %@", session_id);
    
    
    NSString * sFirstRun = [self readLocalProp:@"firstRun"];
    bIsFirstRun =  ((sFirstRun == NULL) || sFirstRun == [NSNull null]);
  

//[window bringSubviewToFront:vMsgFloat];
    
    if ([self initData]){
        // show welcome view

        [self showWelcomeView];
           }
    
    // get server list
    WHHttpClient* client1 = [[WHHttpClient alloc] init:self];
    [client1 setRetry:YES];  
    //    [client1 setResponseHandler:@selector(handleServerListError:)];
    [client1 sendHttpRequest:@"http://leaksmarket.heroku.com/whj/index.txt" selector:@selector(onServerListReturn:) json:NO showWaiting:NO];
    
    

    
//    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];

    return YES;
}


- (BOOL) initData{
      [self setTest];
    
    
    // clear cookie
    NSString* url=  [NSString stringWithFormat:@"http://%@:%@/", host, port];
    NSArray *cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ]
                        cookiesForURL:[NSURL URLWithString:url] ];
    
    if (cookies)
        for (int i = 0; i < [cookies count]; i++)
            [[ NSHTTPCookieStorage sharedHTTPCookieStorage ] deleteCookie:[cookies objectAtIndex:i]];
    
    //    if (true){
  
    //    [self saveLocalProp:@"showBoss" v:NULL];
    
    
    if (!session_id || debug_reg){
        //    if (true){
        /*        // show registeration
         UIImageView* vReg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
         [vReg setUserInteractionEnabled:YES];
         [window addSubview:vReg];
         
         UILabel* vTitle = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 20)];
         [vTitle setText:@"Please choose name and sex for your character"];
         [vReg addSubview:vTitle];
         */

        [window addSubview:vReg.view];
        [window bringSubviewToFront:vReg.view];
    
        return FALSE;
        
    }else{
        //}
        
        //    [self checkNetworkStatus];
        
//        data_user = [self readUserObject];
        
        
        
        // load user data
        
        //
        //        if (data_user == NULL || [data_user valueForKey:@"user"] == NULL || [[self getDataUser] valueForKey:@"race"] == NULL){
        //            data_user = NULL;
        
        // clear cookie
        //        NSString* url=  [NSString stringWithFormat:@"http://%@:%@/", host, port];
        //        NSArray *cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ]
        //                            cookiesForURL:[NSURL URLWithString:url] ];
        //        if (cookies)
        //            for (int i = 0; i < [cookies count]; i++)
        //                [[ NSHTTPCookieStorage sharedHTTPCookieStorage ] deleteCookie:[cookies objectAtIndex:i]];
        
        
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        [client setRetry:YES];    
        [client sendHttpRequest:@"/" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
        bFirstCallReturn = false;
        // start poll thread
        //        [self query_msg];
        //        }else{
        //         
        //        }
        

        //        [self initUI];
        return TRUE;
    }
}

- (void) onServerListReturn:(NSString*)data{
    if (data)
    {
        int _uid = -1;
        id uid = NULL;
        if (data_user){
            uid= [[self getDataUser] valueForKey:@"id"] ;
            if (uid)
                _uid= [uid intValue];
        }
        if (_uid >=0){
            _uid = _uid- _uid/10*10;
        }
        NSString *suid = [NSString stringWithFormat:@"%d", _uid];
        NSObject* server_assigned = NULL;
        NSObject* serverList = [data JSONValue];
        if (serverList){
            server_assigned = [serverList valueForKey:suid];
            if (!server_assigned)
                server_assigned = [serverList valueForKey:@"default"];
        }
        if (server_assigned){
            id _port =  [server_assigned valueForKey:@"port"];
            if (_port && _port != [NSNull null])
                if (!debug)
                    if (!bFirstCallReturn || ![host isEqualToString:[server_assigned valueForKey:@"server"]] || [port intValue] != [_port intValue]){
                        host = [server_assigned valueForKey:@"server"];
                        port = _port;
                        [self initData];
                    }
          
        }
        


    }
    
    

    
}

// needed because home view be on top  when it inited
- (void) topWelcomeView{
    [window bringSubviewToFront:vWelcome];
}
- (BOOL) isShowingWelcome{
    return bShowingWelcome;
}
- (void) showWelcomeView{
    bShowingWelcome = TRUE;
    vWelcome.backgroundColor = [UIColor whiteColor];
    vWelcome.opaque = YES;
    [vWelcome addSubview:lbVersion];
    [vWelcome addSubview:lbLoading];
    [self checkRentina:lbVersion changeSize:NO changeOrigin:YES];
    //[self checkRentina:lbLoading changeSize:NO changeOrigin:YES];
    [self checkRentina:vWelcome changeSize:YES changeOrigin:NO];
    if ([self isRetina4]){
         CGRect r = lbLoading.frame;
        r.origin.y += (568-480)/2;
        lbLoading.frame = r;
    }
    
    CGRect r = lbVersion.frame;
    r.origin.y = screenSize.height - r.size.height;
    lbVersion.frame = r;
    
    lbLoading.hidden = NO;
    //        [vWelcome addSubview:vCompanyLogo];
    //        [vWelcome addSubview:lbCompnayName];
   [window bringSubviewToFront:vWelcome];
    tabBarController.view.hidden = YES;
    [NSTimer scheduledTimerWithTimeInterval:(3.0)target:self selector:@selector(hideWelcomeView) userInfo:nil repeats:NO];	

}
- (void)playBackMusic{
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"back1" ofType:@"mp3"];       //创建音乐文件路径
    
    NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
    NSLog(@"%@",musicURL);
    if (thePlayer == NULL){
     thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    
    //创建播放器

    if (thePlayer !=NULL){
    [thePlayer setDelegate:self];
    
    [thePlayer prepareToPlay];
    [thePlayer setVolume:0.05];   //设置音量大小
    thePlayer.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环

//     thePlayer.currentTime = 15.0;//可以指定从任意位置开始播放  
        [thePlayer  play];
    }
    }
}
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    // perform any interruption handling here
    printf("Interruption Detected\n");
    [[NSUserDefaults standardUserDefaults] setFloat:[thePlayer currentTime] forKey:@"Interruption"];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    // resume playback at the end of the interruption
    printf("Interruption ended\n");
    [thePlayer play];
    
    // remove the interruption key. it won't be needed
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Interruption"];
}
- (void) hideWelcomeView{

    if (!bFirstCallReturn || !bSummarDidLoad || !preloaded) 
        return;
        bShowingWelcome = NO;
    vWelcome.hidden = YES;
    tabBarController.view.hidden = NO;
    [self playBackMusic];
    
}

- (void) showStatusView:(BOOL)bShow{
    vcStatus.view.hidden = !bShow;
}

- (void) reloadStatus{
    [vcStatus viewDidAppear:YES ];

}


- (void) showHelpView:(NSString*) url       {
// vHelpWebView.frame = CGRectMake(0, 60, 320, 480-60-49);
//        btCloseHelpView.frame = CGRectMake(320-25, 60, 25, 25);
    [self showHelpView:url frame: CGRectMake(0, 60, 320, 480-60-49)];
}

- (void) showHelpView:(NSString*) url frame:(CGRect)frame{       
    vHelpWebView.frame = frame;
    btCloseHelpView.frame = CGRectMake(frame.origin.x+frame.size.width-40, frame.origin.y, 40, 40);
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [vHelpWebView loadRequest:req];
    
    vHelp.hidden = NO;
    [window bringSubviewToFront:vHelp];
}

- (void) closeHelpView:(UIButton*) btn{
    vHelp.hidden = YES;
//    [vHelpWebView loadHTMLString:@"" baseURL:nil];
    [vHelpWebView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
}

- (void) updateUserext{
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        [client sendHttpRequest:@"/wh/ext" selector:@selector(onUpdateUserextReturn:) json:YES showWaiting:NO];
    
    
}
- (void) onUpdateUserextReturn:(NSString*) data{
    if ([data valueForKey:@"error"])
        return;
    [self setDataUserExt:data];
    [self reloadStatus];
}
-(void) updateUserData{
    
    if (data_user == NULL){
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        [client sendHttpRequest:@"/" selector:@selector(onReceiveStatus:) json:YES showWaiting:NO];
    }
    
}

- (void) preload{
    wvPreload.delegate = self;
    [wvPreload loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/preload.html", host, port]]]];
    [window sendSubviewToBack:wvPreload];
//    [window bringSubviewToFront:wvPreload];
//    wvPreload.hidden = NO;
}
- (void) onReceiveStatus:(NSObject *) data{
    [self setDataUser:data save:YES];
    NSLog(@"onReceiveStatus data_user %@", [data_user JSONRepresentation]);
    if (!bFirstCallReturn){
         [self initUI];
        [self preload];
    }
    bFirstCallReturn = TRUE;

    bUserSkillNeedUpdate = FALSE;
 //   if (!bShowingWelcome)
   //     [self hideWelcomeView]; // will be hidden after home view loading finished
    
    // show home view

//    [vcHome viewDidAppear:NO];
    [vcStatus viewDidAppear:NO];
    
    // check pending task
    NSString* str = [[self getDataUserext] valueForKey:@"prop"];
    NSObject* prop = [str JSONValue];
    NSObject* pending = [prop valueForKey:@"pending"];
    if (pending){
//        TrainingGround *vc = (TrainingGround*)vcTraining;
        NSString* skillName = [pending valueForKey:@"skill"];
        if (skillName == NULL || skillName == [NSNull null]){
            
        }
            else
                [vcTraining _startPractise:skillName _usepot:[pending valueForKey:@"usepot"]];
    }
    
   
    [self startRecover];
//    [self query_msg];
    [self float_msg];
    
    if (bIsFirstRun){
        [self saveLocalProp:@"firstRun" v:@"1"];
    }
    
//    [self performSelector:@selector(showTipMoreTab) withObject:NULL afterDelay:10];
    

}
- (void) hideTipMoreTab{
    vMoreTab.hidden = YES;
}
- (void) showTipMoreTab{
    if (vMoreTab. hidden == NO)
        return; // in case already triggered by HomeViewController
    if (bShowingWelcome){
        [self performSelector:@selector(showTipMoreTab) withObject:NULL afterDelay:6];
        return;
    }
     vMoreTab.frame = CGRectMake(screenSize.width-80, screenSize.height-50-30, 80, 50);
    vMoreTab. hidden  = NO;
    [[self window] bringSubviewToFront:vMoreTab];
    vMoreTab.animationDuration = 1;
    vMoreTab.animationRepeatCount = 5;
    vMoreTab.animationImages = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"moretab2.png"], [UIImage imageNamed:@"moretab3.png"], nil];
    [vMoreTab startAnimating];
    [self performSelector:@selector(hideTipMoreTab) withObject:NULL afterDelay:5];
}

- (void) float_msg{
    if (!bFirstCallReturn){
        [self performSelector:@selector(float_msg) withObject:NULL afterDelay:10];
        return;
    }
    if ([tabBarController selectedIndex]==0){
        vMsgFloat.hidden = YES;
        if ([floatMsg count] > 0)
            [floatMsg removeObjectAtIndex:0];
    }
        
    if ([floatMsg count] == 0){
        vMsgFloat.hidden = YES;
    }else{
        NSString* s = [floatMsg objectAtIndex:0];
        [floatMsg removeObject:s];
        if ([s length]>0){
            NSString * ss = [NSString stringWithFormat:@"<div style=\"overflow-x:scroll;width:298px;text-overflow:ellipsis;white-space:nowrap\">%@</div>", s];
        [wvMsgFloat loadHTMLString:ss baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/", host, port]]];
        vMsgFloat.hidden = NO;
        [window bringSubviewToFront:vMsgFloat];
        }else
            vMsgFloat.hidden = YES;
    }

    [self performSelector:@selector(float_msg) withObject:NULL afterDelay:3];

}

- (void) query_msg{
    if (!bFirstCallReturn){
        [self performSelector:@selector(query_msg) withObject:NULL afterDelay:10];
        return;
    }
    
//    id _t = [self readLocalProp:@"lastMsgTime"];
//    int t = 0;
//    if (_t){
//        t = [_t intValue];
//    }
//        
    NSString* url = [NSString stringWithFormat:@"/message/get?type=html&type2=json&delete=0"];
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client setRetry:YES];    
    [client sendHttpRequest:url selector:@selector(onGetMsgReturn:) json:YES showWaiting:NO];
}


- (void) onGetMsgReturn:(NSObject*) data{
    id _t = [data valueForKey:@"t"];
    NSArray* msg = [data valueForKey:@"msg"];
    
    if (_t){
        [self saveLocalProp:@"lastMsgTime" v:_t];
    }
 
    if ([msg count] >0){
//        [self showMsg:data type:1 hasCloseButton:NO];
        NSMutableArray * ar = [[NSMutableArray alloc] init];
        for (int i = 0; i < [msg count]; i++){
            NSString* s =[msg objectAtIndex:i];
            if (s != NULL && s != [NSNull null] && [s length] >0){
                s = [s stringByReplacingOccurrencesOfString:@"<div>" withString:@""];
                s = [s stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
                [ar addObject:s];
            }
        }
        [floatMsg addObjectsFromArray:ar];
    }
    
    [self performSelector:@selector(query_msg) withObject:NULL afterDelay:600];

    
}
- (void) setBgImg:(UIImage*) img{
    [bgView setImage:img];
}
- (void) showWaiting:(BOOL)bShow{
    waiting.hidden = !bShow;
    if (bShow)
        [window bringSubviewToFront:waiting];
}

- (BOOL) isWaiting{
    return waiting.hidden  == FALSE;
}

- (void) showNetworkDown{
    // create waiting view
//    vNetworkStatus.hidden = NO;
//    [NSTimer scheduledTimerWithTimeInterval:(3.0)target:self selector:@selector(hideNetworkStatus) userInfo:nil repeats:NO];	
//    [window bringSubviewToFront:vNetworkStatus];
    [self showMsg:@"No Network Connection" type:1 hasCloseButton:FALSE];
}
- (void) hideNetworkStatus{
    vAlert.hidden = YES;
}

- (void) showMsg:(NSString*)msg type:(int)type hasCloseButton:(BOOL)bCloseBt{
//    lbAlertMsg.backgroundColor = [UIColor grayColor];
//    lbAlertMsg.textAlignment = UITextAlignmentCenter;
    CGSize constraintSize= CGSizeMake(240, MAXFLOAT);
    CGSize expectedSize = [msg sizeWithFont:lbAlertMsg.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];

    if (type == 0){ // info
//        [vAlertImg setImage:[UIImage imageNamed:@"success.png"]];
        if (expectedSize.height > 73)
            lbAlertMsg.frame = CGRectMake(20, 20, 240, expectedSize.height);
        else
            lbAlertMsg.frame = CGRectMake(20, 20, 240, 73);
        vNetworkStatus.frame = CGRectMake(vNetworkStatus.frame.origin.x
                                          ,vNetworkStatus.frame.origin.y, vNetworkStatus.frame.size.width, lbAlertMsg.frame.size.height+40);
//        lbAlertMsg.contentMode = UIControlContentVerticalAlignmentCenter;
        vAlertImg.hidden = YES;
        if (expectedSize.height < 73){
            int y = (vNetworkStatus.frame.size.height - expectedSize.height)/2;
            lbAlertMsg.frame = CGRectMake(20, y, 240, expectedSize.height);
        }
    }
    else if (type == 1){ // warning
        [vAlertImg setImage:[UIImage imageNamed:@"warning.png"]];
        if (expectedSize.height > 73)
            lbAlertMsg.frame = CGRectMake(20, 20+46, 240, expectedSize.height);
        else
            lbAlertMsg.frame = CGRectMake(20, 20+46, 240, 73);
        vNetworkStatus.frame = CGRectMake(vNetworkStatus.frame.origin.x
                                          ,vNetworkStatus.frame.origin.y, vNetworkStatus.frame.size.width, lbAlertMsg.frame.size.height+46+40);
        vAlertImg.hidden = NO;
//         lbAlertMsg.contentMode = UIControlContentVerticalAlignmentCenter;
    }
    
//    if ( vNetworkStatus.frame .size.height < 113){
//        vNetworkStatus.frame = CGRectMake(vNetworkStatus.frame.origin.x
//                                          ,vNetworkStatus.frame.origin.y, vNetworkStatus.frame.size.width, 113);
//    }
//    int y = (vNetworkStatus.frame.size.height - lbAlertMsg.frame.size.height)/2;
//    
//
//    if (type == 0){
//       
//    }else if (type == 1){
//        y += vAlertImg.frame.size.height;
//    }
//    if (y < 20)
//        y = 20;
//    lbAlertMsg.frame = CGRectMake(20, y, 240, lbAlertMsg.frame.size.height);
    

    
 lbAlertMsg.text = msg;

/*
    
    [LightView resizeLabelToText:lbAlertMsg];
    int offset = lbAlertMsg.frame.size.height - 57;
    
//    lbAlertMsg.backgroundColor = [UIColor greenColor];
    if (offset > 0){
       CGRect r =  vNetworkStatus.frame;
        r.size.height = 127 + offset;
        vNetworkStatus.frame = r;
    }
*/    
    if (bCloseBt){
        btClose.hidden = NO;
    }else
//        [NSTimer scheduledTimerWithTimeInterval:(3.0)target:self selector:@selector(hideNetworkStatus) userInfo:nil repeats:NO];	
        [self performSelector:@selector(hideNetworkStatus) withObject:nil afterDelay:3];
    
    vNetworkStatus.hidden = NO;
    vAlert.hidden = NO;
    
    [window bringSubviewToFront:vAlert];
        
}

- (int) checkNetworkStatus{
    Reachability *r = [Reachability reachabilityWithHostName:host];
    switch ([r currentReachabilityStatus]) {
        case ReachableViaWWAN:
            // 你的设备使用3G网络
            NSLog(@"3Gネットワークを使う");
            networkStatus = 1;
            break;
        case ReachableViaWiFi:
            // 你的设备使用WiFi网络
            NSLog(@"WIFIネットワークを使う");        
            networkStatus = 2;
            break;
        case NotReachable:
            // 你的设备没有网络连接
            NSLog(@"ネットワーク無し");
//            if (networkStatus != 0){
//                networkStatus = 0;
//                [self showNetworkDown];
//            }
            networkStatus = 0;
            break;
    }
    return networkStatus;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{ NSLog(@"applicationDidEnterBackground");
    
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */

//    [self checkNetworkStatus];
//    if (networkStatus == 0){
//        [self showNetworkDown];
//        [NSTimer scheduledTimerWithTimeInterval:(3.0)target:self selector:@selector(checkNetworkStatus) userInfo:nil repeats:YES];
//    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (IBAction)closeFightMsg:(id)sender {
    vBattleMsgBg.hidden = YES;
//    [vBattleMsg loadHTMLString:@"" baseURL:nil];
    [vBattleMsg stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
      tabBarController.view.hidden = NO;
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Warriors__Heaven" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Warriors__Heaven.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void) showFightMsg:(NSString*) msg{
    [window bringSubviewToFront:vBattleMsgBg];
    vBattleMsgBg.hidden = NO;
    
    NSString* m = [NSString stringWithFormat:@"<html><body style=\"background-color: transparent\"><div style=\"background-color: #000;color:#cccccc;font-size:10pt;\"><style> </style>%@</div></body></html>", msg];
//    vBattleMsg.backgroundColor = [UIColor greenColor];
//    CGRect r = vBattleMsg.frame;
    [vBattleMsg loadHTMLString:m baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@", [self host], [self port]]]];
    [vBattleMsg becomeFirstResponder];
    tabBarController.view.hidden = TRUE;
}

/*
 * return example:
 {
 age = 30;
 id = 9;
 race = 0;
 sex = 1;
 sid = 1320346951bf2bc6293fb70cc2a71a05;
 title = "\U5973\U4fa0";
 user = queen;
 userext = {..
 }
 userskills ={..
 }
 */

- (NSObject*) getDataUser{
    return [data_user valueForKey:@"user"];
}

- (NSObject*) getDataUserext{
    NSObject* t = [self getDataUser];
    t = [t valueForKey:@"userext"];
    t = [t valueForKey:@"userext"];
    return t;
}
- (id) getDataUserextProp:(NSString*) name{
    NSString* prop = [[self getDataUserext] valueForKey:@"prop"];
    if (!prop)
        return NULL;
    NSObject* js = [prop JSONValue];
    if (!js) {
        return NULL;
    }
    return [js valueForKey:name];
    
}
- (void) setDataUserExt:(NSObject*)data{
    //    NSObject * v = [self getDataUser];
    //    [v setValue:eqs forKey:@"userskills"];
    [[data_user valueForKey:@"user"] setValue:data forKey:@"userext"];
}
- (void) closeAlert:(UIButton*) btn{
    vAlert.hidden = YES;
}

- (NSObject*) getDataUserskills{
    NSObject * v = [self getDataUser];
    return [v valueForKey:@"skills"];
}
- (NSObject*) setDataUserskills:(NSArray*) ar{
    NSObject * v = [self getDataUser];
//    NSObject* skills = [sefl getDataUserskills];
    [v setValue:ar forKey:@"skills"];
}

- (NSArray*) getDataUserEqs{
    NSObject * v = [self getDataUser];
    return [v valueForKey:@"objects"];
}
- (void) setDataUserEqs:(NSArray*)eqs{
//    NSObject * v = [self getDataUser];
//    [v setValue:eqs forKey:@"userskills"];
      [[data_user valueForKey:@"user"] setValue:eqs forKey:@"objects"];
}
- (void) setDataUser:(NSObject *)data save:(BOOL)save{

    data_user = data;
    if (save)
        [self saveDataUser];
    return;
    
}

- (NSObject*) readLocalProp:(NSString*) n{
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    if (! SaveDefaults) 
        return NULL;
    
    NSArray * Array = [SaveDefaults objectForKey:n];
    
    if (!Array || [Array count] == 0)
        return NULL;
    
    
    return  [Array objectAtIndex:0];
}
- (void) saveLocalProp:(NSString*)n v:(NSObject*)d{

    NSArray *Array = [NSArray arrayWithObjects:d, nil];
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    [SaveDefaults setObject:Array forKey:n]; 
}
- (void) saveDataUser{
   
    NSLog(@"save data_user %@", [data_user JSONRepresentation]);
    NSArray *Array = [NSArray arrayWithObjects:data_user, nil];
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    [SaveDefaults setObject:Array forKey:@"data_user"];
}

- (void) recover:(NSNumber*) n{
    
    if (tmRecoverStart != [n longValue])
        return;
    if (bRecovering)
        return;
    bRecovering = YES;
    [self performSelector:@selector(recover:) withObject:n afterDelay:2.0];
    
    
//    if (!data_user){
//         bRecovering = FALSE;
//        [self updateUserData ];
//        return;
//    }
    
    BOOL needReocovery = NO;
    NSMutableDictionary* ext = [self getDataUserext];
    int per = 100;  // recover 1/100 of maxhp every second
    
    int hp = [[[self getDataUserext] valueForKey:@"hp"] intValue];
    int maxhp = [[[self getDataUserext] valueForKey:@"maxhp"] intValue];
    if (hp < maxhp){
        hp += maxhp/per;
        if (hp > maxhp)
            hp = maxhp;
        if (hp < maxhp)
            needReocovery = YES;
        [ext setValue:[NSNumber numberWithInt:hp] forKey:@"hp"];
    }
    
    int st = [[[self getDataUserext] valueForKey:@"stam"] intValue];
    int maxst = [[[self getDataUserext] valueForKey:@"maxst"] intValue];
    if (st < maxst){
        st += maxst/per;
        if (st > maxst)
            st = maxst;
        if (st < maxst)
            needReocovery = YES;
        [ext setValue:[NSNumber numberWithInt:st] forKey:@"stam"];
    }
    
    int jingli = [[[self getDataUserext] valueForKey:@"jingli"] intValue];
    int max_jl = [[[self getDataUserext] valueForKey:@"max_jl"] intValue];
    if (jingli < max_jl){
        jingli += max_jl/per;
        if (jingli > max_jl)
            jingli = max_jl;
        if (jingli < max_jl)
            needReocovery = YES;
        [ext setValue:[NSNumber numberWithInt:jingli] forKey:@"jingli"];
    }
    
   // if (needReocovery && tmRecoverStart == [n longValue] && ext == [self getDataUserext]){
    bRecovering = FALSE;
        [self performSelectorOnMainThread:@selector(reloadStatus) withObject:NULL waitUntilDone:NO ];
//    }
    
}

- (void) startRecover{
    tmRecoverStart = time(&tmRecoverStart);
    
//    NSObject* t = [[self getDataUserext]valueForKey:@"updated_at"];
    
    [self performSelector:@selector(recover:) withObject:[NSNumber numberWithLong:tmRecoverStart] afterDelay:2.0];
    
    
}
- (void) setFirstCallReturn:(BOOL) b{
    bFirstCallReturn = b;
}

- (void) setUserBusy:(BOOL) busy{
    bUserBusy = busy;
}


+ (id) getProp:(NSObject*)prop name:(NSString*)name{
    NSObject* js = prop;
    if ([prop isKindOfClass:[NSString class]])
         js = [(NSString*)prop JSONValue];
    return [js valueForKey:name];
}

- (void) checkUpdated:(NSObject*) data{
    id updated = [data valueForKey:@"updated"];
    if (!updated)
        return;
    id user = [updated valueForKey:@"user"];
    if (user){
        [self setData_user:user];
        return;
    }
    id ext = [updated valueForKey:@"userext"];
    if (ext){
        [[[data_user valueForKey:@"user"] valueForKey:@"userext"] setValue:ext forKey:@"userext"];
    }
    id skills = [updated valueForKey:@"skills"];
    if (skills)
        [self setDataUserskills:skills];
    id eqs = [updated valueForKey:@"objects"];
    if (eqs)
        [self setDataUserEqs:eqs];
    
    NSLog(@"root: %@", [self getDataUser]);
}

- (BOOL) processReturnData:(NSObject*) data{
    NSString* error = [data valueForKey:@"error"];
    BOOL ret = FALSE;
    if (error){
        [self showMsg:error type:1 hasCloseButton:YES];
        ret = FALSE;
    }
    
    else{
        NSString* suc = [data valueForKey:@"OK"];
        [self showMsg:suc type:0 hasCloseButton:YES];
        ret = TRUE;
        
    }
    
    id userdata = [data valueForKey:@"user"];
    if (userdata){
        [self setData_user:userdata];
    }
    return ret;
    
}

- (void) showPurchaseView{
    [window addSubview:[vcPurchase view]];
//    [vcPurchase viewWillAppear:NO];
    [vcPurchase loadPage];
    [vcPurchase view].hidden = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request);
    NSString* url = [request.URL absoluteString];
    NSString* path = [request.URL path];
    if ( [path isEqualToString:@"/clientaction/closeintro"]){
        vPreface.hidden = YES;
        return FALSE;
    }/*else if ( [path hasPrefix:@"/clientaction/gototab/"]){
        NSString* tab = [path substringToIndex:22];
        int iTab = [tab intValue];
        [[self tabBarController] selectTab:iTab];
    }*/
    else if ( [url hasPrefix:@"mailto://teamcode/"]){
        NSString* tc = [[request.URL absoluteString] substringFromIndex:18] ;
        if ([MFMailComposeViewController canSendMail]){
   
            controller = [[MFMailComposeViewController alloc] init];
    
        controller.mailComposeDelegate = vcStatus;
        [controller setSubject:@"快来加入我的战队"];
         NSString* m = [NSString stringWithFormat:@"Hi, \n快来玩IPhone游戏《侠客行》吧，加入我们的战队就可获得装备哦。记住注册时填写我的战队Code \"%@\" ^_^.", tc];
        [controller setMessageBody:m isHTML:NO];
//            [vcStatus presentModalViewController:controller animated:YES];
//        [window.rootViewController presentModalViewController:controller animated:YES];
                        [window addSubview:controller.view];        
//            controller.view.hidden = NO;
            [window bringSubviewToFront:controller.view];
//        [window bringSubviewToFront:[vcHome view]];
//        [[vcStatus view] bringSubviewToFront:[controller view]];
//        [self vHelp].hidden = YES;
        }else{
            NSString* surl = @"mailto://";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:surl]];
        }
        return false;
    }else if ([url hasPrefix:@"safari://"]){
        NSString* surl = [[request.URL absoluteString] substringFromIndex:9] ;
//        surl = [surl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        surl = [surl stringByReplacingOccurrencesOfString:@":://" withString:@"://"]; 
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:surl]];
        return FALSE;
    }
    return TRUE;
}
- (IBAction)onClosePreface:(id)sender {
       vPreface.hidden = NO;
}
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {    
//    [activityIndicator startAnimating];       
//    if (webView.tag == 1000)
//        vHelp.hidden = YES;
//    NSString *surl = [webView.request.URL absoluteString];   
//    if (surl != nil && [surl isEqualToString:@"about:blank"] ){
//        return;
//    }
    if (webView.tag == 1000){
//        
//    if (myAlert==nil){        
//        myAlert = [[UIAlertView alloc] initWithTitle:nil 
//                                             message: @"Loading"
//                                            delegate: self
//                                   cancelButtonTitle: nil
//                                   otherButtonTitles: nil];
//        
//        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        activityView.frame = CGRectMake(120.f, 48.0f, 37.0f, 37.0f);
//        [myAlert addSubview:activityView];
//        [activityView startAnimating];
//        [myAlert show];
//    }
        [self showWaiting:YES];
    }
//    [self showWaiting:YES];
}

//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView.loading == YES)
        return;
//    [activityIndicator stopAnimating];    
//    UIView *view = (UIView *)[self.view viewWithTag:103];
//    [view removeFromSuperview];
    
//    NSString *surl = [webView.request.URL absoluteString];
//    NSLog(@"webViewDidFinishLoad %@", surl);
    //         if (surl != nil && [surl isEqualToString:@"about:blank"] ){
    //             return;
    //         }
    
     if (webView.tag == 1000){

//         
//         [myAlert dismissWithClickedButtonIndex:0 animated:YES];
//         myAlert = NULL;
         [self showWaiting:NO];
     }
//      [self showWaiting:NO];
//    if (webView.tag == 1000)
//        vHelp.hidden = NO;
//    
    // if webview == wvPreload
    if (webView.tag == 2000){ // preload
        preloaded = YES;
        [self hideRegView];
        [self hideWelcomeView];
    }

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (webView.tag == 2000){ // preload
        [self showNetworkDown];
        [self performSelector:@selector(preload) withObject:NULL afterDelay:3];
    }
}
-(BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
    return NO;
}

-(void) hideRegView{
    vReg.view.hidden = YES;
}
@end
