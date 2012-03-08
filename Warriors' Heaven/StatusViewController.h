//
//  StatusViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lbGold;
@property (strong, nonatomic) IBOutlet UIProgressView *pbAmbition;
@property (strong, nonatomic) IBOutlet UIProgressView *pvHP;
@property (strong, nonatomic) IBOutlet UILabel *lbHP;
@property (strong, nonatomic) IBOutlet UILabel *lbAmbition;
@property (strong, nonatomic) IBOutlet UILabel *lbExp;
@property (strong, nonatomic) IBOutlet UILabel *lbLevel;
- (void) onReceiveStatus:(NSObject*) json;
@end
