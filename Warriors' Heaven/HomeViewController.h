//
//  HomeViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController{
    UIImageView * bgView;
    __unsafe_unretained IBOutlet UILabel *lbGold;
    __unsafe_unretained IBOutlet UIButton *btGold;
    __unsafe_unretained IBOutlet UIImageView *viewReport;
}

@property (strong, nonatomic) IBOutlet UIImageView *playerProfile;
@property (nonatomic, retain) UIImageView *bgView;

@end
