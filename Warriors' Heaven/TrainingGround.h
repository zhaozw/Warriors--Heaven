//
//  TrainingGround.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"

@interface TrainingGround : UIViewController
@property (strong, nonatomic) IBOutlet StatusViewController *vcStatus;
@property (strong, nonatomic) IBOutlet UIView* skillsView;
@end
