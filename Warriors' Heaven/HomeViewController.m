//
//  HomeViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

@synthesize playerProfile;
@synthesize bgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    bgView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
//    
//    [bgView setImage:[UIImage imageNamed:@"background.png"]];
//    [self.view addSubview:bgView];
    UIImage *imageNormal = [UIImage imageNamed:@"reportboard.png"];
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:39];
    //设置帽端为12px,也是就左边的12个像素不参与拉伸,有助于圆角图片美观
    [self->viewReport setImage:stretchableImageNormal  ];
	
    // set player profile
    [playerProfile setImage:[UIImage imageNamed:@"default_player_m.png"]];
   // [playerProfile setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidUnload
{
    lbGold = nil;
    btGold = nil;
    viewReport = nil;
    [self setPlayerProfile:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
