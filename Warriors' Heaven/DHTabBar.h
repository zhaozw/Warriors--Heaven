//
//  DHTabBar.h
//  UITabBarDemo
//
//  Created by DotHide on 11-8-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class DotHide_TabBarController;
@interface DHTabBar : UIView {
	NSMutableArray *buttons;
	DotHide_TabBarController *viewController;
	int currentSelectedIndex;
	UIImageView *slideBg;
	UIScrollView *tabBarScrollView;
    UIViewController* oldvc;
}

@property (nonatomic, assign) int currentSelectedIndex;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) DotHide_TabBarController *viewController;

- (id)initWithBackgroundImage:(UIImage *)bgImage 
					ViewCount:(NSUInteger)count 
			   ViewController:(DotHide_TabBarController *)vc;
- (void)selectedTab:(UIButton *)button;
@end
