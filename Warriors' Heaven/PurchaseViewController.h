//
//  PurchaseViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "InAppPurchaseManager.h"
#import "TestIap.h"

@class AppDelegate;
@class InAppPurchaseManager;
@interface PurchaseViewController : UIViewController<UIWebViewDelegate>{
    AppDelegate * ad ;
    InAppPurchaseManager* iapm;
//    NSMutableArray* iapm_list;
    TestIap * iaptest;
    
}
@property (strong, nonatomic) IBOutlet UIWebView *vwPurchase;
- (IBAction)onClose:(id)sender;


@end
