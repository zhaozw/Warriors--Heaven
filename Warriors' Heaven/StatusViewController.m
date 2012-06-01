//
//  StatusViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatusViewController.h"
#import "WHHttpClient.h"
#import "AppDelegate.h"
#import "SBJson.h"

@implementation StatusViewController
@synthesize lbGold;
@synthesize pvHP;
@synthesize lbHP;
@synthesize lbExp;
@synthesize lbLevel;
@synthesize pvStam;
@synthesize lbStam;
@synthesize lbJingli;
@synthesize pvJingli;

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
    [self.view setFrame:CGRectMake(0,0,320,100)];
    
//    WHHttpClient* client = [[WHHttpClient alloc] init:self];
//    [client sendHttpRequest:@"/wh/userext" selector:@selector(onReceiveStatus:) json:YES showWaiting:NO];
    
//    PDColoredProgressView *pvStam1 = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
//    [pvStam1 setTintColor: [UIColor greenColor]]; //or any other color you like
//  
//    pvStam1.progress = 0.5f;
//    pvStam1.frame = CGRectMake(240, 35, 56, 9);
//     [self.view addSubview: pvStam1];
    
    
//    NSArray *colors = [NSArray arrayWithObjects: 
//					   [UIColor redColor], 
//					   [UIColor purpleColor], 
//					   [UIColor blueColor],
//					   [UIColor colorWithRed: 27.0/255.0 green: 175.0/255.0 blue: 57.0/255.0 alpha: 1],
//					   [UIColor orangeColor], 
//					   [UIColor magentaColor],
//					   [UIColor brownColor],
//					   [UIColor blackColor],
//					   nil];
//	
//	int i = 0;
//	
//	for(i = 0 ; i < [colors count] ; i++)
//	{
//		PDColoredProgressView *progressView = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
//		CGRect frame = progressView.frame;
//		frame.size.width = 300;
//		frame.origin.x = 10;
//		frame.origin.y = 10 * (i + 1) + 10 * i;
//		progressView.frame = frame;
//        [progressView setProgress:(i+1) * (1.0/[colors count])];
//		[progressView setTintColor: [colors objectAtIndex: i]];
//		[self.view addSubview: progressView];
////		[progressView release];
//	}
}
- (void) viewWillAppear:(BOOL) animated{
    NSLog(@"Status view will appear");
}
- (void) viewDidAppear:(BOOL) animated{
       NSLog(@"Status view did appear");
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    NSObject* json = [ad getDataUserext];
    NSLog(@"USEREXT: %@", [json JSONRepresentation]);
    if (json){
//        json = [json valueForKey:@"userext"];
        // NSNumber* exp = [json  valueForKey:@"exp"];
        int level = [[json  valueForKey:@"level"]  intValue];
        int exp = [[json  valueForKey:@"exp"] intValue];
        int max_exp = (level+1)*(level+1)*(level+1);
        lbExp.text = [NSString stringWithFormat:@"%d/%d", exp, max_exp];
        lbGold.text = [[json  valueForKey:@"gold"] stringValue];
        //lbAmbition = [json  valueForKey:@"exp"];
        lbLevel.text = [[json  valueForKey:@"level"] stringValue];
        NSString* strHp = [[json  valueForKey:@"hp"] stringValue];
        int hp = [strHp intValue];
        NSString* strMaxHp = [[json  valueForKey:@"maxhp"] stringValue];
        int maxhp = [strMaxHp intValue];
        int jingli = [[json valueForKey:@"jingli"] intValue];
        int max_jl = [[json valueForKey:@"max_jl"] intValue];
        lbHP.text = [[NSString alloc] initWithFormat:@"%@/%@", strHp, strMaxHp] ;
        [pvHP setProgress:((float)hp ) / ((float)maxhp) ];
        lbStam.text = [[NSString alloc] initWithFormat:@"%@/%@", [[json valueForKey:@"stam"] stringValue], [[json valueForKey:@"maxst"] stringValue]];
        [pvStam setProgress:((float)[[json valueForKey:@"stam"] intValue])/[ [json valueForKey:@"maxst"] intValue]];
        lbJingli.text = [NSString stringWithFormat:@"%d/%d", jingli, max_jl];
        [pvJingli setProgress:((float)jingli) / max_jl ];
    }

}
- (void) onReceiveStatus:(NSObject*) json{
    NSLog(@"StatusViewController receive data:%@", json);
    
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    NSObject* user = [ad.data_user valueForKey:@"user"] ;
    NSObject* ext = [json valueForKey:@"userext"];
    [user setValue:ext forKey:@"userext"];
    
    [self viewDidAppear:NO];
}

- (void)viewDidUnload
{
    [self setLbGold:nil];
    [self setPvHP:nil];
    [self setLbHP:nil];
    [self setLbExp:nil];
    [self setLbLevel:nil];
    [self setPvStam:nil];
    [self setLbStam:nil];
    [self setLbJingli:nil];
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
