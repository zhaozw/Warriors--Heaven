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
//#import "TrainingGround.h"
#import "HomeViewController.h"
@class HomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    DotHide_TabBarController *tabBarController;
    UIViewController *viewcontroller;
    UIWindow *window;
    UIImageView *bgView;
    NSString* session_id;
    UIView *waiting;
//    HomeViewController *vcHome;
    UIView *vAlert;

    BOOL bFirstCallReturn;
    BOOL bShowingWelcome;
    NSObject* data_user;
//    NSObject* data_userext;
    NSString* host;
    NSString* port;

    int networkStatus;
    BOOL bUserSkillNeedUpdate; // need update from server
    BOOL bUserSkillNeedReload; // need update locally

    NSObject* requests;
    BOOL bRecovering;
    UIViewController* vcTraining;
//    BOOL bUpadtingStatus;
    BOOL bUserBusy;
    UIImageView *vMsgFloat;
    UIWebView* wvMsgFloat;
    NSMutableArray* floatMsg;
    BOOL debug;
}
@property (nonatomic, assign)    BOOL bUserEqNeedUpdated; // need update locally
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vWelcome;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *vHelp;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *vHelpWebView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btCloseHelpView;
@property (strong, nonatomic) IBOutlet HomeViewController *vcHome;
@property (strong, nonatomic) IBOutlet UIView *vNetworkStatus;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vAlertImg;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btClose;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbAlertMsg;
@property (nonatomic, retain) NSObject* requests;
@property (nonatomic, assign) int networkStatus;
@property (nonatomic, assign)  BOOL bUserSkillNeedUpdate;
@property (nonatomic, assign)  BOOL bUserSkillNeedReload;
@property (nonatomic, copy) NSString* host;
@property (nonatomic, copy) NSString* port;
@property (nonatomic, copy) NSString* session_id;
//@property (nonatomic, retain) NSObject* data_userext;
@property (nonatomic, assign)  time_t tmRecoverStart;
@property (strong, atomic)  NSMutableArray* floatMsg;

// sample data:
// {"user":{"userext":{"userext":{"level":10,"max_eq":"5","fame":0,"race":"","max_item":10,"str":20,"name":"queen","created_at":null,"updated_at":"2012-03-24T21:16:48Z","dext":20,"s
@property (nonatomic, retain) NSObject* data_user;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) IBOutlet StatusViewController *vcStatus;
//@property (nonatomic, retain) UIImageView *bgView;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIViewController *viewcontroller;
@property (nonatomic, retain) IBOutlet DotHide_TabBarController *tabBarController;

@property (unsafe_unretained, nonatomic) IBOutlet UIViewController *vReg;
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
- (void) setDataUserExt:(NSObject*)data;
- (NSObject*) getDataUserskills;
- (NSArray*) getDataUserEqs;
- (void) setDataUserEqs:(NSArray*)eqs;
- (id) getDataUserextProp:(NSString*) name;
// type: 0: success 1: warning
- (void) showMsg:(NSString*)msg type:(int)type hasCloseButton:(BOOL)bCloseBt;
//- (void) addFloatMsg:(NSString*)msg;
- (void) showHelpView:(NSString*) url;
- (void) showStatusView:(BOOL)bShow;
- (void) setSessionId:(NSString *)session_id;
- (void) initUI;
- (void) saveDataUser;
- (void) setDataUser:(NSObject *)data save:(BOOL)save;

- (void) startRecover;
- (void) reloadStatus;

- (void) hideWelcomeView;
- (void) setFirstCallReturn:(BOOL) b;
- (void) setUserBusy:(BOOL) busy;
- (void) updateUserext;
- (void) query_msg;

- (void) saveLocalProp:(NSString*)n v:(NSObject*)d;
- (NSObject*) readLocalProp:(NSString*)n;
- (void) checkUpdated:(NSObject*) data;
- (NSObject*) setDataUserskills:(NSArray*) ar;
+ (id) getProp:(NSObject*)prop name:(NSString*)name;
- (void) float_msg;
@end
