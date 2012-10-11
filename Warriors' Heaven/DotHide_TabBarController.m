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
        // preload for EGOButton
        for (int i = 0; i < 9; i++){
            UIViewController* c = [self.viewControllers objectAtIndex:i];
            c.view;
        }
		//self.selectedIndex = 0; this will cause home view display on top of welcome view
		firstTime = NO;
	}
	tabBarView = [[DHTabBar alloc] initWithBackgroundImage:bgImage
												 ViewCount:9
											ViewController:self];
	[self.view addSubview:tabBarView];
	self.moreNavigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    NSLog(@"first view loaded");
//    CGRect r = tabBarView.frame;
//    CGRect rr = self.view.frame;
//    CGRect rrr = tabBarView.superview.frame;
//    CGRect rrrr = tabBarView.superview.superview.frame;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	firstTime = YES;
//    [self.tabBar setDelegate:self];
    self.delegate = self;

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

- (void)selectTab:(int)tag{
    UIButton* btn = [tabBarView viewWithTag:tag];
    if (btn)
        [tabBarView selectedTab:btn];
    else
        NSLog(@"button not found, tag=%d", tag);
}
//- (void)tabBar:(UITabBar *)atabBar didSelectItem:(UITabBarItem *)item{
//        NSLog(@"DFDF");
//}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"DFDF");
//    
//}
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//     NSLog(@"DFDF");
//}

@end
