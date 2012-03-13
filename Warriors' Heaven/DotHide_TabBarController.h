//
//  DotHide_TabBarController.h
//  UITabBarDemo
//
//  Created by DotHide on 11-8-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHTabBar.h"

@interface DotHide_TabBarController : UITabBarController {
	DHTabBar *tabBarView;
	BOOL firstTime;
}

@property (nonatomic, retain) DHTabBar *tabBarView;
@property (nonatomic, assign) BOOL firstTime;

- (void)hideRealTabBar;
- (void)selectTab:(int)tag;

@end
