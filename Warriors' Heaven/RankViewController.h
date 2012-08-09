//
//  RankViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RankViewController : UIViewController<UIWebViewDelegate>{
    UIActivityIndicatorView *activityIndicator;
    UIAlertView* myAlert;
}
@property (strong, nonatomic) IBOutlet UIWebView *vRankWeb;

@end
