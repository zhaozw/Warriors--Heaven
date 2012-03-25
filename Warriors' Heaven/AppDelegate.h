//
//  AppDelegate.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotHide_TabBarController.h"
#import "StatusViewController.h"
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    DotHide_TabBarController *tabBarController;
    UIViewController *viewcontroller;
    UIWindow *window;
    UIImageView *bgView;
    NSString* session_id;
    UIView *waiting;
    HomeViewController *vcHome;

    
    NSObject* data_user;
//    NSObject* data_userext;
    NSString* host;
    NSString* port;

    int networkStatus;
    BOOL bUserSkillNeedUpdate;
    
    NSObject* requests;
}
@property (strong, nonatomic) IBOutlet HomeViewController *vcHome;
@property (strong, nonatomic) IBOutlet UIView *vNetworkStatus;
@property (nonatomic, retain) NSObject* requests;
@property (nonatomic, assign) int networkStatus;
@property (nonatomic, assign)  BOOL bUserSkillNeedUpdate;
@property (nonatomic, copy) NSString* host;
@property (nonatomic, copy) NSString* port;
@property (nonatomic, copy) NSString* session_id;
//@property (nonatomic, retain) NSObject* data_userext;
@property (nonatomic, retain) NSObject* data_user;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) IBOutlet StatusViewController *vcStatus;
//@property (nonatomic, retain) UIImageView *bgView;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIViewController *viewcontroller;
@property (nonatomic, retain) IBOutlet DotHide_TabBarController *tabBarController;

@property (strong, nonatomic) IBOutlet UIImageView* bgView;

@property (strong, nonatomic) IBOutlet UIWebView *vBattleMsg;
@property (strong, nonatomic) IBOutlet UIView *vBattleMsgBg;

- (IBAction)closeFightMsg:(id)sender;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void) showWaiting:(BOOL)bShow;
- (BOOL) isWaiting;
- (void) setBgImg:(UIImage*) img;
- (void) showNetworkDown;
- (void) checkNetworkStatus;
- (void) showFightMsg:(NSString*) msg;
- (void) updateUserData;
- (NSObject*) getDataUser;
- (NSObject*) getDataUserext;
@end
