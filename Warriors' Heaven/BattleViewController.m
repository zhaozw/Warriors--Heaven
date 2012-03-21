//
//  BattleViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleViewController.h"
#import "AppDelegate.h"
#import "WHHttpClient.h"

@implementation BattleViewController
@synthesize vcStatus;

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
    [self addChildViewController:vcStatus];
    [self.view addSubview:vcStatus.view];
    
  
    
        
}

- (void) onReceiveStatus:(NSArray*) data{
    int count = [data count];
    

    
    
    int row_height = 70;
    int row_margin = 1;
    int y = 300;
    for (int i = 0; i< count; i++){
        NSObject* d = [data objectAtIndex:i];
        NSObject* json = [d valueForKey:@"userext"];
        NSNumber *uid = [json valueForKey:@"uid"];
        NSString* name = [json valueForKey:@"name"];
        NSString* level = [[json valueForKey:@"level"] stringValue];
        y = 100+ i*(row_height+row_margin);
        UIView * row = [[UIView alloc] initWithFrame:CGRectMake(0,y, 320, row_height)];
        //        if (i/2*2 == i)
        //            [row setBackgroundColor:[UIColor redColor]];
        //        else
        //            [row setBackgroundColor:[UIColor greenColor]];
        [row setOpaque:NO];
        [row setBackgroundColor:[UIColor clearColor]];
        //        [row setAlpha:0.6f];
        /* NSString *host = [(AppDelegate*)[UIApplication sharedApplication].delegate host];
         NSString *port = [(AppDelegate*)[UIApplication sharedApplication].delegate port];
         NSString* sUrl = [[NSString alloc] initWithFormat:@"http://%@:%@/images/npc.jpg", host, port];
         //        NSURL* url = [NSURL URLWithString:sUrl];
         //        NSLog(@"urlhost = %@:%d",url.host, [url.port intValue]);
         
         NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:sUrl]];
         UIImage * img = [[UIImage alloc] initWithData:data];
         //        NSError *error = nil;
         //        UIImage * img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://127.0.0.1/images/home.jpg"] options:NSDataReadingMappedIfSafe error:&error]];
         //        NSLog(@"error %@", [error description]);
         UIImageView *logo = [[UIImageView alloc] initWithImage:img];*/
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"p_%d.jpg", i] ] ];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        
        [logo setFrame:CGRectMake(1, 5, 50, 50)];
        [row addSubview:logo];
        
        UILabel* lbInfo = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 50, 30)];
        [lbInfo setOpaque:NO];
        //        lbInfo setContentMode:<#(UIViewContentMode)#>
        [lbInfo setAdjustsFontSizeToFitWidth:YES];
        [lbInfo setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [lbInfo setTextColor:[UIColor whiteColor]];
        [lbInfo setBackgroundColor:[UIColor clearColor]];
        [lbInfo setText:[[NSString alloc] initWithFormat:@"%@", name]];
        [row addSubview:lbInfo];
        
        UILabel* lbLevel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 100, 30)];
        [lbLevel setOpaque:NO];
        [lbLevel setAdjustsFontSizeToFitWidth:NO];
        //[lbLevel setMinimumFontSize:8.0f];
        [lbLevel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [lbLevel setTextColor:[UIColor yellowColor]];
        [lbLevel setBackgroundColor:[UIColor clearColor]];
        [lbLevel setText:[[NSString alloc] initWithFormat:@"Level %@", level]];
        [row addSubview:lbLevel];
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setFrame:CGRectMake(240, 10, 70, 35)];
        [btn setTitle:@"Fight" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(fight:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
        [btn setTag:uid];
        [row addSubview:btn];   
        
        [self.view addSubview:row];
    }

}
- (void) fight:(UIButton* )button{
    NSLog(@"fight");

    
    // send request
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    NSString* url = [[NSString alloc] initWithFormat:@"/wh/fight?enemy=%@", [button tag]];
    [client sendHttpRequest:url selector:@selector(onReceiveStatus:) showWaiting:YES];
    
    // show result
    
    UIImageView * resultView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [resultView setImage:[UIImage imageNamed:@"fight_result.png"]];
    
    
    UIImageView * resView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 30, 230, 110)];
    [resView setImage:[UIImage imageNamed:@"fight_result_fail.png"]];
    [resultView addSubview:resView];
    
    UILabel* lbInfo = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 320, 60)];
    [lbInfo setOpaque:NO];
    //[lbInfo setAdjustsFontSizeToFitWidth:YES];
    [lbInfo setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
    [lbInfo setTextColor:[UIColor grayColor]];
    [lbInfo setBackgroundColor:[UIColor clearColor]];
    [lbInfo setText:[[NSString alloc] initWithFormat:@"skill point        HP             EXP"]];
    [resultView addSubview:lbInfo];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(120, 360, 70, 35)];
    [btn setTitle:@"Close" forState: UIControlStateNormal];
    [btn addTarget:self action:@selector(closeresult:) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
    //[btn setShowsTouchWhenHighlighted:TRUE];
    [resultView addSubview:btn];
    
    [resultView setUserInteractionEnabled: TRUE];
    [self.view addSubview: resultView];
 
    [self.view bringSubviewToFront:resultView];
}

- (void) closeresult:(UIButton* )button{
    NSLog(@"closeResult");
    
    UIView* pv = [button superview];
    [pv setHidden: TRUE];
    NSArray * subviewsArr = [pv subviews];
    for(UIView *v in subviewsArr )
    {
        [v removeFromSuperview];
    }
    // [button removeFromSuperview];
    [pv removeFromSuperview];
    
}


- (void)viewDidUnload
{
    [self setVcStatus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    [ad setBgImg:[UIImage imageNamed:@"background.PNG"] ];
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/wh/listPlayerToFight" selector:@selector(onReceiveStatus:) showWaiting:YES];
}

@end
