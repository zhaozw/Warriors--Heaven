//
//  ObjDetailViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "EGOImageView.h"

@interface ObjDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lbSellPrice;
@property (strong, nonatomic) IBOutlet UILabel *lbRank;
@property (strong, nonatomic) IBOutlet UILabel *lbEffect;
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbDesc;
- (void) loadObjDetail:(NSObject*) obj;
- (void) hideDetailView;
- (IBAction)onSell:(id)sender;
- (IBAction)onClose:(id)sender;
@property (strong, nonatomic) IBOutlet EGOImageView *vImage;
@property (strong, retain) AppDelegate * ad;
@end
