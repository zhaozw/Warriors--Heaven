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


@implementation AppDelegate

@synthesize window;
@synthesize bgView;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize vcStatus;
@synthesize viewcontroller;
@synthesize tabBarController;
@synthesize session_id;
//@synthesize data_userext;
@synthesize data_user;
@synthesize host;
@synthesize port;
@synthesize vWelcome;
@synthesize vHelp;
@synthesize vHelpWebView;
@synthesize btCloseHelpView;
@synthesize vcHome;
@synthesize vNetworkStatus;
@synthesize vAlertImg;
@synthesize btClose;
@synthesize lbAlertMsg;
@synthesize networkStatus;
@synthesize bUserSkillNeedUpdate;
@synthesize vBattleMsg;
@synthesize vBattleMsgBg;
@synthesize requests;

- (id) init{
    /////////////////
    // init data
    /////////////////
    
    // init const
//host = @"192.168.0.24";
    host = @"localhost";
    //    host = @"127.0.0.1";
    //    host = @"wh.joyqom.com";
    //    host = @"192.168.1.119";
    port = @"3006";
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    // full screen
    self.window.windowLevel = UIWindowLevelStatusBar + 1.0f;
    //self.window.backgroundColor = [UIColor whiteColor];
    
    requests = [[NSString stringWithFormat:@"{}"] JSONValue];
    
    bUserSkillNeedUpdate = TRUE;
    // load session id from local
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    NSArray * Array = [SaveDefaults objectForKey:@"sessionid"];
    
    session_id = [Array objectAtIndex:0];
    NSLog(@"load session id %@", session_id);
    
    
    //    [self checkNetworkStatus];
    
    // load user data
    
    Array = [SaveDefaults objectForKey:@"data_user"];
    NSString* userdata = [Array objectAtIndex:0];
    NSLog(@"datauser: %@", data_user);
    
//    if (userdata == NULL){
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        [client sendHttpRequest:@"/" selector:@selector(onReceiveStatus:) json:NO showWaiting:NO];
//    }else{
//        data_user = [userdata JSONValue];
//    }

    
 
    /////////////////
    // init UI
    /////////////////

    

 
   // CGRect rect = [[UIScreen mainScreen] bounds];
    bgView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
    //[bgView1 setBackgroundColor:[UIColor redColor]];
    [bgView setImage:[UIImage imageNamed:@"background.PNG"]];
    //[bgView setHidden:FALSE];
//    [bgView setAlpha:0.5f];
    
    [window addSubview:bgView];
    [window addSubview:tabBarController.view];
    
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
    
    
    // create waiting view
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
    [window addSubview:self->waiting];
//    [window bringSubviewToFront:self->waiting];
    waiting.hidden = YES;
    
    
    [vBattleMsgBg setBackgroundColor:[UIColor blackColor]];
    [vBattleMsg setBackgroundColor:[UIColor blackColor]];
    
    [lbAlertMsg setBackgroundColor:[UIColor colorWithRed:0.99f green:0.0f blue:0.0f alpha:0.3]];
    [lbAlertMsg setMinimumFontSize:0.1f];
    [lbAlertMsg setAdjustsFontSizeToFitWidth:YES];
    [lbAlertMsg setNumberOfLines:3];
    [btClose addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    // init help view
    vHelp.frame = CGRectMake(20, 60, 250, 300);
    vHelp.backgroundColor = [UIColor redColor];
    vHelpWebView.frame = CGRectMake(0, 0, 250, 300);
    vHelpWebView.backgroundColor = [UIColor clearColor];
    [vHelpWebView setOpaque:NO];
    btCloseHelpView.frame = CGRectMake(230, 0, 20, 20);
    [btCloseHelpView addTarget:self action:@selector(closeHelpView:) forControlEvents:UIControlEventTouchUpInside];
    vHelp.hidden = YES;
    
    
    // show welcome view
    vWelcome.backgroundColor = [UIColor whiteColor];
    vWelcome.opaque = YES;
    [window bringSubviewToFront:vWelcome];
    [NSTimer scheduledTimerWithTimeInterval:(5.0)target:self selector:@selector(hideWelcomeView) userInfo:nil repeats:NO];	
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) hideWelcomeView{
    vWelcome.hidden = YES;
}

- (void) showStatusView:(BOOL)bShow{
    vcStatus.view.hidden = !bShow;
}

- (void) showHelpView:(NSString*) url{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    [vHelpWebView loadRequest:req];
    vHelp.hidden = NO;
    [window bringSubviewToFront:vHelp];
}

- (void) closeHelpView:(UIButton*) btn{
    vHelp.hidden = YES;
}
-(void) updateUserData{
    
    if (data_user == NULL){
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        [client sendHttpRequest:@"/" selector:@selector(onReceiveStatus:) json:NO showWaiting:NO];
    }
    
}
- (void) onReceiveStatus:(NSString *) data{
    data_user = [data JSONValue];
    NSLog(@"data_user %@", [data_user JSONRepresentation]);
    NSArray *Array = [NSArray arrayWithObjects:data, nil];
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    [SaveDefaults setObject:Array forKey:@"data_user"];
    
    [vcHome viewDidAppear:NO];
    [vcStatus viewDidAppear:NO];
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
    vNetworkStatus.hidden = YES;
}

- (void) showMsg:(NSString*)msg type:(int)type hasCloseButton:(BOOL)bCloseBt{
    if (type == 0)
        [vAlertImg setImage:[UIImage imageNamed:@"success.png"]];
    else if (type == 1)
        [vAlertImg setImage:[UIImage imageNamed:@"warning.png"]];
        
    lbAlertMsg.text = msg;
    
    if (bCloseBt){
        btClose.hidden = NO;
    }else
        [NSTimer scheduledTimerWithTimeInterval:(3.0)target:self selector:@selector(hideNetworkStatus) userInfo:nil repeats:NO];	
      vNetworkStatus.hidden = NO;
    
    [window bringSubviewToFront:vNetworkStatus];
        
}

- (void) checkNetworkStatus{
    Reachability *r = [Reachability reachabilityWithHostName:host];
    switch ([r currentReachabilityStatus]) {
        case ReachableViaWWAN:
            // 你的设备使用3G网络
            NSLog(@"使用3G网络");
            networkStatus = 1;
            break;
        case ReachableViaWiFi:
            // 你的设备使用WiFi网络
            NSLog(@"使用wifi网络");        
            networkStatus = 2;
            break;
        case NotReachable:
            // 你的设备没有网络连接
            NSLog(@"没有网络");
//            if (networkStatus != 0){
//                networkStatus = 0;
//                [self showNetworkDown];
//            }
            break;
    }
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
    [vBattleMsg loadHTMLString:@"" baseURL:nil];
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
    
    NSString* m = [NSString stringWithFormat:@"<html><body style=\"background-color: transparent\"><div style=\"background-color: #000;color:#cccccc\">%@</div></body></html>", msg];
    [vBattleMsg loadHTMLString:m baseURL:nil];
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
    return [[[data_user valueForKey:@"user"] valueForKey:@"userext"] valueForKey:@"userext"];
}
- (void) setDataUserExt:(NSArray*)data{
    //    NSObject * v = [self getDataUser];
    //    [v setValue:eqs forKey:@"userskills"];
    [[data_user valueForKey:@"user"] setValue:data forKey:@"userext"];
}
- (void) closeAlert:(UIButton*) btn{
    vNetworkStatus.hidden = YES;
}

- (NSObject*) getDataUserskills{
    NSObject * v = [self getDataUser];
    return [v valueForKey:@"userskills"];
}

- (NSObject*) getDataUserEqs{
    NSObject * v = [self getDataUser];
    return [v valueForKey:@"usereqs"];
}
- (void) setDataUserEqs:(NSArray*)eqs{
//    NSObject * v = [self getDataUser];
//    [v setValue:eqs forKey:@"userskills"];
      [[data_user valueForKey:@"user"] setValue:eqs forKey:@"usereqs"];
}
@end
