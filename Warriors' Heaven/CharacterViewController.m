//
//  CharacterViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterViewController.h"
#import "AppDelegate.h"
#import "EGOImageButton.h"

@implementation CharacterViewController
@synthesize vcStatus;
@synthesize vEquipment;

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
    
    // add status view
//    [self addChildViewController:vcStatus];
//    [self.view addSubview:vcStatus.view];
}

- (void)viewDidUnload
{
    [self setVcStatus:nil];
    [self setVEquipment:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"character view update");

        AppDelegate * ad = [UIApplication sharedApplication].delegate;
        [ad setBgImg:[UIImage imageNamed:@"background.PNG"] ];
    
    EGOImageButton *v = [[EGOImageButton alloc] initWithPlaceholderImage:[UIImage imageNamed:@"tab_team.png"]];
    v.frame = CGRectMake(10, 10, 60, 60);
    NSArray * ar = [[NSArray alloc] initWithObjects:
                    @"http://192.168.0.24:3006/images/p_1.jpg",
                    @"http://192.168.0.24:3006/images/p_2.jpg",
                    nil];

    srand(time(nil));
    int i = rand()%2;
    NSLog(@"rand %d", i);
    [v setImageURL:[NSURL URLWithString:[ar objectAtIndex:i]]];
    [v setTag:i];
    [v addTarget:self action:@selector(selectEq:) forControlEvents:UIControlEventTouchUpInside];
    [v  setBackgroundColor:[UIColor yellowColor]];
    [v setTintColor:[UIColor redColor]];
//    [v setHighlighted:YES];
    [vEquipment addSubview:v];
    
    
    
}

- (void) highlightButton:(UIButton*)btn{
//    [btn drawRect:CGRectMake(0, 0, 50, 50)];
    [btn setSelected:YES];
    [btn setHighlighted:YES];
}

- (void) selectEq:(UIButton*)btn{
   
    [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
 
   // [self performSelector:@selector(highlightButton:) withObject:btn afterDelay:0.0];
}


@end
