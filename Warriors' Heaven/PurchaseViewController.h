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

@class AppDelegate;
@interface PurchaseViewController : UIViewController<UIWebViewDelegate>{
    AppDelegate * ad ;
    InAppPurchaseManager* iapm;
}
@property (strong, nonatomic) IBOutlet UIWebView *vwPurchase;
- (IBAction)onClose:(id)sender;


@end
