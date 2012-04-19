//
//  MarketViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MarketViewController : UIViewController{
    int currentSelectedList;
}
@property(nonatomic, assign)     int currentSelectedList;
@property (strong, nonatomic) IBOutlet UIButton *btEquipment;
@property (strong, nonatomic) IBOutlet UIButton *btFixure;
@property (strong, nonatomic) IBOutlet UIButton *btPremierEq;
@property (strong, nonatomic) IBOutlet UIView *vEquipment;
@property (strong, nonatomic) IBOutlet UIView *vFixure;
@property (strong, nonatomic) IBOutlet UIView *vPremierEq;
@property (strong, nonatomic)  UIButton *btCurrentSelected;
@property (strong, retain) AppDelegate * ad;
@end
