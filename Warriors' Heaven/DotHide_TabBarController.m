//
//  DotHide_TabBarController.m
//  UITabBarDemo
//
//  Created by DotHide on 11-8-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DotHide_TabBarController.h"
#import "DHTabBar.h"

@implementation DotHide_TabBarController

@synthesize tabBarView;
@synthesize firstTime;

- (void)viewWillAppear:(BOOL)animated{
	//NSLog(@"%@", [self.viewControllers description]);
	[self hideRealTabBar];
	UIImage *bgImage = [UIImage imageNamed:@"TabBarGradient.png"];
	if (firstTime) {
		self.selectedIndex = 0;
		firstTime = NO;
	}
	tabBarView = [[DHTabBar alloc] initWithBackgroundImage:bgImage
												 ViewCount:7
											ViewController:self];
	[self.view addSubview:tabBarView];
	self.moreNavigationController.navigationBarHidden = YES;
	[super viewWillAppear:animated];
    NSLog(@"first view loaded");
}

- (void)viewDidLoad{
	[super viewDidLoad];
	firstTime = YES;
}

- (void)viewDidUnload{
	[super viewDidUnload];
//	[tabBarView release];
	tabBarView = nil;
}

- (void)hideRealTabBar{
	for(UIView *view in self.view.subviews){
		if([view isKindOfClass:[UITabBar class]]){
			view.hidden = YES;
			break;
		}
	}
}

- (void)dealloc{
//	[tabBarView release];
//	[super dealloc];
}

@end
