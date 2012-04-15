//
//  ResearchViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LightView.h"

@interface ResearchViewController : UIViewController
@property (strong, nonatomic) IBOutlet LightView *vUnRead;
@property (strong, nonatomic) IBOutlet LightView *vRead;
@property (strong, retain) AppDelegate *ad;
- (void) buildRearchList;
-(void)viewWillAppear:(BOOL)animated;
@end
