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
#import "PurchaseViewController.h"
#import "CharacterViewController.h"
#import "TrainingGround.h"
#import <AVFoundation/AVFoundation.h>   

@class HomeViewController;
@class PurchaseViewController;
@class CharacterViewController;
@class TrainingGround;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UIWebViewDelegate, AVAudioPlayerDelegate>{
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
//    UIViewController* vcTraining;
//    BOOL bUpadtingStatus;
    BOOL bUserBusy;
    UIImageView *vMsgFloat;
    UIWebView* wvMsgFloat;
    NSMutableArray* floatMsg;
    BOOL debug;
    BOOL debug_reg;
    MFMailComposeViewController* controller ;
    UIWebView* wvMap;
    UIAlertView* myAlert;
    BOOL preloaded;
    float deviceVersion;
    AVAudioPlayer *thePlayer;
    
}
@property (unsafe_unretained, nonatomic) IBOutlet TrainingGround *vcTraining;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vMoreTab;
@property (nonatomic, assign) CGSize screenSize;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbLoading;
@property (nonatomic, assign)     BOOL bSummarDidLoad;
@property (nonatomic, assign)     BOOL bIsFirstRun;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbVersion;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbBattleResultTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *vPreface;
- (IBAction)onClosePreface:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *wvPreface;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *wvLoadingPreface;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbCompnayName;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vCompanyLogo;
@property (nonatomic, assign)    BOOL bUserEqNeedUpdated; // need update locally
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vWelcome;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *vHelp;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *vHelpWebView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btCloseHelpView;
//@property (strong, nonatomic) IBOutlet HomeViewController *vcHome;
@property (strong, nonatomic) IBOutlet UIImageView *vNetworkStatus;
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
//@property (unsafe_unretained, nonatomic) IBOutlet CharacterViewController *vcCharacter;

@property (strong, nonatomic) IBOutlet StatusViewController *vcStatus;
//@property (nonatomic, retain) UIImageView *bgView;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIViewController *viewcontroller;
@property (nonatomic, retain) IBOutlet DotHide_TabBarController *tabBarController;

@property (unsafe_unretained, nonatomic) IBOutlet UIViewController *vReg;
@property (strong, nonatomic) IBOutlet UIImageView* bgView;

@property (strong, nonatomic) IBOutlet UIWebView *vBattleMsg;
@property (strong, nonatomic) IBOutlet UIView *vBattleMsgBg;
@property (unsafe_unretained, nonatomic) IBOutlet PurchaseViewController *vcPurchase;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *wvPreload;
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
- (void) showHelpView:(NSString*) url frame:(CGRect)frame;
- (void) showStatusView:(BOOL)bShow;
- (void) setSessionId:(NSString *)session_id;
- (void) initUI;
- (void) saveDataUser;
- (void) setDataUser:(NSObject *)data save:(BOOL)save;

- (void) startRecover;
- (void) reloadStatus;
- (void) showWelcomeView;
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
- (BOOL) processReturnData:(NSObject*) data;

- (void) showPurchaseView;
- (bool) initData;
- (void) closeHelpView:(UIButton*) btn;
-(void) hideRegView;
- (void) preload;
- (float) getDeviceVersion;
- (void) checkRentina:(UIView*)v changeSize:(BOOL)changeSize changeOrigin:(BOOL)changeOrigin;
- (int) retinaHight:(int) height;
- (BOOL) isRetina4;
- (void) showTipMoreTab;
- (void) topWelcomeView;
@end
