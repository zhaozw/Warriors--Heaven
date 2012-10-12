//
//  HomeViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"
#import "AppDelegate.h"
#import "EGOImageView.h"


@class AppDelegate;
//@class CharacterViewController;
@interface HomeViewController : UIViewController<UIWebViewDelegate>{
    UIImageView * bgView;
    __unsafe_unretained IBOutlet UILabel *lbGold;
    __unsafe_unretained IBOutlet UIButton *btGold;
    __unsafe_unretained IBOutlet UIImageView *viewReport;
    
    // handle http request
    NSMutableData* buf;
    UIView *waiting;
    NSString * cookie;
    int hideWebViewCount;
   UIWebView* wvMap;
    UIImageView* vMap;
    UIImageView* vScrollAni;
}
@property (strong, nonatomic) IBOutlet UIButton *btGotoCharView;
//@property (strong, nonatomic) IBOutlet CharacterViewController *vcChar;
@property (strong, nonatomic) IBOutlet UIButton *lbComment;
- (IBAction)onTouchChar:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btChar;
@property (strong, nonatomic) IBOutlet UIView *vHomeUnder;
@property (strong, nonatomic) IBOutlet UIView *vHome;
@property (strong, nonatomic) IBOutlet UIScrollView *vBadge;
@property (strong, retain) AppDelegate *ad;
@property (strong, nonatomic) IBOutlet UIWebView *vSummary;
@property (strong, nonatomic) IBOutlet UILabel *lbStatus;
@property (strong, nonatomic) IBOutlet StatusViewController *vcStatus;
- (IBAction)onTouchTeam:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btCloseFloat1;

@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet EGOImageView *playerProfile;
@property (nonatomic, retain) UIImageView *bgView;
- (void)sendHttpRequest:(NSString*)cmd;
-(void)viewWillAppear:(BOOL)animated;
@property (strong, nonatomic) IBOutlet UILabel *lbUserName;
@property (strong, nonatomic) EGOImageView* vSeasonImag;
@property (strong, nonatomic)  UILabel *lbDate;
@property (strong, nonatomic)  UILabel *lbMonth;
@property (strong, nonatomic)  UILabel *lbTiming;
@property (strong, nonatomic)  UILabel *lbTimingInfo;
@property (strong, nonatomic) IBOutlet UIImageView *vProfileBg;
- (IBAction)onCloseFloat1:(id)sender;

- (IBAction)onTouchFight:(id)sender;

- (IBAction)onClickStatus:(id)sender;
- (IBAction)onTouchSkill:(id)sender;
// handle network
// 收到响应时, 会触发
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse;
// 你可以在里面判断返回结果, 或者处理返回的http头中的信息

// 每收到一次数据, 会调用一次
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data;


// 当然buffer就是前面initWithRequest时同时声明的.

// 网络错误时触发
- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error;

// 全部数据接收完毕时触发
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn;

- (void) onReceiveStatus:(NSObject*) json;
- (void) recoverWebView;
- (void) floatWebView;
- (IBAction)onGotoCharView:(id)sender;

//- (void) reload;
@end
