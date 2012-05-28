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

@interface ObjDetailViewController : UIViewController{
    NSString* viewType;
}
@property (strong, nonatomic) NSObject* obj;
@property (strong, nonatomic) IBOutlet UILabel *lbSellPrice;
@property (strong, nonatomic) IBOutlet UILabel *lbRank;
@property (strong, nonatomic) IBOutlet UILabel *lbEffect;
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbDesc;
@property (strong, nonatomic) IBOutlet UILabel *lbPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnUse;
@property (strong, nonatomic) IBOutlet UILabel *slbPrice;
@property (strong, nonatomic) IBOutlet UIButton *btTrade;
@property (strong, nonatomic) IBOutlet UILabel *lbHp;
- (void) loadObjDetail:(NSObject*) obj;
- (void) hideDetailView;
- (void) setViewType:(NSString*) type;
- (IBAction)onClose:(id)sender;
- (IBAction)onUse:(id)sender;
@property (strong, nonatomic) IBOutlet EGOImageView *vImage;
@property (strong, retain) AppDelegate * ad;
- (void) setOnTrade:(id)c  sel:(SEL) sel;
@end
