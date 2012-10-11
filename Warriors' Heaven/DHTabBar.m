//
//  DHTabBar.m
//  UITabBarDemo
//
//  Created by DotHide on 11-8-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DHTabBar.h"
#import "DotHide_TabBarController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>
#import "AppDelegate.h"

@interface DHTabBar (Private)

-(UIImage*) tabBarImage:(UIImage*)startImage size:(CGSize)targetSize backgroundImage:(UIImage*)backgroundImage;

@end

@implementation DHTabBar

@synthesize buttons,currentSelectedIndex;
@synthesize viewController;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (id)initWithBackgroundImage:(UIImage *)bgImage 
					ViewCount:(NSUInteger)count 
			   ViewController:(DotHide_TabBarController *)vc{
	if (self = [super init]) {
		//create scroll view
        float scrollViewHeight = 49;
        float scrollViewWidth  = 320;
		tabBarScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollViewWidth, scrollViewHeight)];
		[tabBarScrollView setCanCancelContentTouches:NO];
		[tabBarScrollView setClipsToBounds:NO];
		tabBarScrollView.showsHorizontalScrollIndicator = NO;

		
		slideBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slide"]];
		CGRect slideBgFrame = slideBg.frame;
		self.viewController = vc;
		CGRect tabBarFrame = viewController.tabBar.frame;
		self.frame = tabBarFrame;
        
		//添加背景图片
		CGRect bgImageFrame = CGRectMake(0, 0, 320, 49);
		UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
		bgImageView.frame = bgImageFrame;
		[self addSubview:bgImageView];
//		[bgImageView release];
		
		//遍历buttons
		self.buttons = [NSMutableArray arrayWithCapacity:count];
		double btnWidth = 320 / 5;
		double btnHeight = 49;
		slideBgFrame.size.width = btnWidth;
		slideBgFrame.origin.x = vc.selectedIndex * btnWidth;
		slideBg.frame = slideBgFrame;
		for (int i = 0; i < count; i++) {
			UIViewController *v = [viewController.viewControllers objectAtIndex:i];
//			NSLog(@"%@", [v description]);
			UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
			btn.tag = i;
            
			//设定btn的响应方法
			[btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
//			UIImage *btnImage = [self tabBarImage:v.tabBarItem.image 
//											 size:btn.frame.size 
//								  backgroundImage:nil];
            UIImage *btnImage;
            if (i == 0)
                btnImage = [UIImage imageNamed:@"tab_home.png"];
            else if (i == 1)
                btnImage = [UIImage imageNamed:@"tab_character.png"];
            else if (i == 2)
                btnImage = [UIImage imageNamed:@"tab_fight.png"];
            else if (i == 3)
                btnImage = [UIImage imageNamed:@"tab_train.png"];
            else if (i == 4)
                btnImage = [UIImage imageNamed:@"tab_shop.png"];
            else if (i == 5)
                btnImage = [UIImage imageNamed:@"tab_team.png"];
            else if (i == 6)
                btnImage = [UIImage imageNamed:@"tab_quest.png"];
            else if (i == 7)
                btnImage = [UIImage imageNamed:@"tab_rank.png"];
            else if (i == 8)
                btnImage = [UIImage imageNamed:@"tab_help.png"];
            else
                btnImage = [self tabBarImage:v.tabBarItem.image size:btn.frame.size backgroundImage:nil];
            [btn setImage:btnImage forState:UIControlStateNormal];
//            btn.backgroundColor = [UIColor clearColor];
//            [btn setBackgroundImage:btnImage forState:UIControlStateNormal];
//			btn.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 5, 0);
            [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [btn setContentMode:UIViewContentModeScaleAspectFit];
            btn.adjustsImageWhenHighlighted = NO;
            
			//NSLog(@"%@",[btn.imageView.superview description]);
	/*		UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, btnHeight - 18, btnWidth, btnHeight - 30)];
			title.font = [UIFont systemFontOfSize:10];
			title.textColor = [UIColor whiteColor];
			title.backgroundColor = [UIColor clearColor];
			title.text = v.tabBarItem.title;
			title.textAlignment = UITextAlignmentCenter;
			[btn addSubview:title];
//			[title release];*/
			[buttons addObject:btn];
			[tabBarScrollView addSubview:btn];
			[tabBarScrollView addSubview:slideBg];
		}
		[self addSubview:tabBarScrollView];
        [tabBarScrollView setContentSize:CGSizeMake(count * btnWidth, scrollViewHeight)];
      
//        tabBarScrollView.backgroundColor = [UIColor redColor];
//        tabBarScrollView.superview.backgroundColor = [UIColor greenColor];

    }
    
    
	return self;
}

//切换tabbar
- (void)selectedTab:(UIButton *)button{
    AppDelegate* ad = [UIApplication sharedApplication].delegate;
    [ad closeHelpView:NULL];
    int old_index = self.currentSelectedIndex;
	self.currentSelectedIndex = button.tag;


    // show animation
        UIViewController* vc1 = [self.viewController.viewControllers objectAtIndex:old_index ]; 
    UIViewController* vc2 = [self.viewController.viewControllers objectAtIndex:self.currentSelectedIndex ]; 
    if (old_index != self.currentSelectedIndex){
        
        
    //    if (old_index == 0){
    //      /*  [UIView beginAnimations:@"curlup" context:nil];//开始一个动画块，第一个参数为动画块标识
    ////         [UIView setAnimationDelegate:self];
    //        [UIView setAnimationDuration:2.0f];//设置动画的持续时间
    //        
    ////        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//设置动画块中的动画属性变化的曲线，此方法必须在beginAnimations方法和commitAnimations，默认即为UIViewAnimationCurveEaseInOut效果。详细请参见UIViewAnimationCurve
    //        
    ////        [UIView setAnimationRepeatAutoreverses:NO];//设置是否自动反转当前的动画效果
    //        
    //        
    //        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:vc1.view cache:YES];//设置过渡的动画效果，此处第一个参数可使用上面5种动画效果
    //        
    //        
    ////        [vc2.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];//页面翻转
    //        
    //        [UIView commitAnimations];//提交动画
    //       */
    //        CATransition *animation  = [CATransition animation ];  
    //        [animation  setDuration:0.3f];   
    //        [animation  setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];   
    //        [animation  setType :@"pageCurl"];  
    //        [animation  setSubtype: kCATransitionFromBottom];  
    //        [vc1.view.layer addAnimation:animation  forKey:@"Reveal" ]; 
    
        if (self.currentSelectedIndex == 3 || self.currentSelectedIndex==7){ // training or rank
            viewController.selectedIndex = self.currentSelectedIndex;
        }else{
      /*      
            
            CATransition *animation2 = [CATransition animation];
            animation2.delegate = self;

            animation2.duration = 0.2f;
            
            //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation2.type = kCATransitionPush;//设置上面4种动画效果
            //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
            
            if (old_index < self.currentSelectedIndex){     
                animation2.subtype = kCATransitionFromLeft;
            }else if (old_index > self.currentSelectedIndex) {
                animation2.subtype = kCATransitionFromRight;
            }
            [vc1.view.layer addAnimation:animation2 forKey:@"animationID2"]; 
            
        CATransition *animation = [CATransition animation];
            
        animation.duration = 0.2f;
            
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;//设置上面4种动画效果
        //设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom

          if (old_index < self.currentSelectedIndex){     
              animation.subtype = kCATransitionFromRight;
          }else if (old_index > self.currentSelectedIndex) {
              animation.subtype = kCATransitionFromLeft;
          }
            animation.delegate = self;
            UIView* sup = viewController.selectedViewController.view.superview;
//            [sup addSubview:vc2.view];
//            [vc2.view.layer addAnimation:animation forKey:@"animationID2"]; 
        
    
            oldvc = vc1;
       */
            if (self.currentSelectedIndex == 1){ // character
                    [ad setBgImg:[UIImage imageNamed:@"bg8.jpg"] ];
            }else if (self.currentSelectedIndex == 6){ // mission
                 [ad setBgImg:[UIImage imageNamed:@"bg6.jpg"] ];
            }else{
                [ad setBgImg:[UIImage imageNamed:@"bg5.jpg"] ];
            }
            
            UIView* fromView = vc1.view;
            UIView* toView = vc2.view;
            // Get the size of the view area.d
            CGRect viewSize = fromView.frame;
            BOOL scrollRight = self.currentSelectedIndex > old_index;
            
            // Add the to view to the tab bar view.
            [fromView.superview addSubview:toView];
            
            // Position it off screen.
            toView.frame = CGRectMake((scrollRight ? 320 : -320), viewSize.origin.y, 320, viewSize.size.height);
            
            [UIView animateWithDuration:0.2f
                             animations: ^{
                                 
                                 // Animate the views on and off the screen. This will appear to slide.
                                 fromView.frame =CGRectMake((scrollRight ? -320 : 320), viewSize.origin.y, 320, viewSize.size.height);
                                 toView.frame =CGRectMake(0, viewSize.origin.y, 320, viewSize.size.height);
                             }
             
                             completion:^(BOOL finished) {
                                 if (finished) {
                                     // Remove the old view from the tabbar view.
                                     [fromView removeFromSuperview];
                                     viewController.selectedIndex = self.currentSelectedIndex;
                                 }
                             }];
        }
    }


//        viewController.selectedIndex = self.currentSelectedIndex;
    // change tab button
	[self performSelector:@selector(slideTabBg:) withObject:button];
}


///*
// *动画结束后的委托函数，移除动画视图
// */
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    // do real view change
//    if (flag && self.currentSelectedIndex != viewController.selectedIndex){
//        viewController.selectedIndex = self.currentSelectedIndex;
//        [oldvc.view removeFromSuperview];
//    }
//
//    
// 
//}
//切换滑块位置
- (void)slideTabBg:(UIButton *)btn{
	[UIView beginAnimations:nil context:nil];  
	[UIView setAnimationDuration:0.20];  
	[UIView setAnimationDelegate:self];
	slideBg.frame = btn.frame;
	[UIView commitAnimations];
	CAKeyframeAnimation * animation; 
	animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
	animation.duration = 0.50; 
	animation.delegate = self;
	animation.removedOnCompletion = YES;
	animation.fillMode = kCAFillModeForwards;
	NSMutableArray *values = [NSMutableArray array];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]]; 
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]]; 
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
	animation.values = values;
	[btn.layer addAnimation:animation forKey:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
//	[buttons release];
//	[viewController release];
//    [super dealloc];
}

-(UIImage*) tabBarBackgroundImageWithSize:(CGSize)targetSize backgroundImage:(UIImage*)backgroundImage
{
	// The background is either the passed in background image (for the blue selected state) or gray (for the non-selected state)
	UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
	if (backgroundImage)
	{
		// Draw the background image centered
		[backgroundImage drawInRect:CGRectMake((targetSize.width - CGImageGetWidth(backgroundImage.CGImage)) / 2, (targetSize.height - CGImageGetHeight(backgroundImage.CGImage)) / 2, CGImageGetWidth(backgroundImage.CGImage), CGImageGetHeight(backgroundImage.CGImage))];
	}
	else
	{
		[[UIColor lightGrayColor] set];
		UIRectFill(CGRectMake(0, 0, targetSize.width, targetSize.height));
	}
	
	UIImage* finalBackgroundImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return finalBackgroundImage;
}

// Convert the image's fill color to black and background to white
-(UIImage*) blackFilledImageWithWhiteBackgroundUsing:(UIImage*)startImage
{
	// Create the proper sized rect
	CGRect imageRect = CGRectMake(0, 0, CGImageGetWidth(startImage.CGImage), CGImageGetHeight(startImage.CGImage));
	
	// Create a new bitmap context
	CGContextRef context = CGBitmapContextCreate(NULL, imageRect.size.width, imageRect.size.height, 8, 0, CGImageGetColorSpace(startImage.CGImage), kCGImageAlphaPremultipliedLast);
	
	CGContextSetRGBFillColor(context, 1, 1, 1, 1);
	CGContextFillRect(context, imageRect);
	
	// Use the passed in image as a clipping mask
	CGContextClipToMask(context, imageRect, startImage.CGImage);
	// Set the fill color to black: R:0 G:0 B:0 alpha:1
	CGContextSetRGBFillColor(context, 0, 0, 0, 1);
	// Fill with black
	CGContextFillRect(context, imageRect);
	
	// Generate a new image
	CGImageRef newCGImage = CGBitmapContextCreateImage(context);
	UIImage* newImage = [UIImage imageWithCGImage:newCGImage scale:startImage.scale orientation:startImage.imageOrientation];
	
	// Cleanup
	CGContextRelease(context);
	CGImageRelease(newCGImage);
	
	return newImage;
}

// Create a tab bar image
-(UIImage*) tabBarImage:(UIImage*)startImage 
				   size:(CGSize)targetSize 
		backgroundImage:(UIImage*)backgroundImageSource
{
	// The background is either the passed in background image (for the blue selected state) or gray (for the non-selected state)
	UIImage* backgroundImage = [self tabBarBackgroundImageWithSize:startImage.size backgroundImage:backgroundImageSource];
	
	// Convert the passed in image to a white backround image with a black fill
	UIImage* bwImage = [self blackFilledImageWithWhiteBackgroundUsing:startImage];
	
	// Create an image mask
	CGImageRef imageMask = CGImageMaskCreate(CGImageGetWidth(bwImage.CGImage),
											 CGImageGetHeight(bwImage.CGImage),
											 CGImageGetBitsPerComponent(bwImage.CGImage),
											 CGImageGetBitsPerPixel(bwImage.CGImage),
											 CGImageGetBytesPerRow(bwImage.CGImage),
											 CGImageGetDataProvider(bwImage.CGImage), NULL, YES);
	
	// Using the mask create a new image
	CGImageRef tabBarImageRef = CGImageCreateWithMask(backgroundImage.CGImage, imageMask);
	
	UIImage* tabBarImage = [UIImage imageWithCGImage:tabBarImageRef scale:startImage.scale orientation:startImage.imageOrientation];
	
	// Cleanup
	CGImageRelease(imageMask);
	CGImageRelease(tabBarImageRef);
	
	// Create a new context with the right size
	UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
	
	// Draw the new tab bar image at the center
	[tabBarImage drawInRect:CGRectMake((targetSize.width/2.0) - (startImage.size.width/2.0), (targetSize.height/2.0) - (startImage.size.height/2.0), startImage.size.width, startImage.size.height)];
	
	// Generate a new image
	UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

@end
