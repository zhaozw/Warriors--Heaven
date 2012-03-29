//
//  MarketViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MarketViewController.h"
#import "AppDelegate.h"
#import "WHHttpClient.h"
#import "EGOImageView.h"

@implementation MarketViewController
@synthesize btEquipment;
@synthesize btFixure;
@synthesize btPremierEp;
@synthesize vEquipment;
@synthesize vFixure;
@synthesize vPremierEp;
@synthesize currentSelectedList;

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
    
    currentSelectedList = 1; // equipment
    vEquipment.frame = CGRectMake(0, 100, 320, 500);
    
    vFixure.frame = CGRectMake(0, 100, 320, 500);
    vFixure.hidden = YES;
    vPremierEp.frame = CGRectMake(0, 100, 320, 500);
    vPremierEp.hidden -= YES;
}

- (void)viewDidUnload
{
    [self setBtEquipment:nil];
    [self setBtFixure:nil];
    [self setBtPremierEp:nil];
    [self setVEquipment:nil];
    [self setVFixure:nil];
    [self setVPremierEp:nil];
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
    [ad setBgImg:[UIImage imageNamed:@"bg_market.jpg"] ];
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    if (currentSelectedList == 1)
        [client sendHttpRequest:@"/tradables?type=1" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    else if (currentSelectedList == 2){
        [client sendHttpRequest:@"/tradables?type=2" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    }
    else if (currentSelectedList == 3){
         [client sendHttpRequest:@"/tradables?type=3" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    }

}

- (void) onReceiveStatus:(NSArray*) data{
     AppDelegate * ad = [UIApplication sharedApplication].delegate;
    int count = [data count];
    int row_height = 70;
    int row_margin = 1;
    int y = 300;
    for (int i = 0; i< count; i++){
        NSObject* d = [data objectAtIndex:i];
        NSObject* json = [d valueForKey:@"tradable"];
        NSNumber *uid = [json valueForKey:@"desc"];
        NSString* name = [json valueForKey:@"name"];
        NSString* price = [[json valueForKey:@"price"] stringValue];
        NSString* number = [[json valueForKey:@"number"] stringValue];
        NSString* soldnum = [[json valueForKey:@"soldnum"] stringValue];
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
        NSString* filepath = [json valueForKey:@"file"];
        if (filepath == NULL || filepath.length == 0)
            filepath = [NSString stringWithFormat:@"%@.png", name];
        filepath = [NSString stringWithFormat:@"http://%@:%@/game/obj/equipments/%@", ad.host, ad.port, filepath];
        NSLog(@"filepath=%@", filepath);
//        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"p_%d.jpg", i] ] ];
        EGOImageView* logo = [[EGOImageView alloc] init];
        [logo setImageURL:[NSURL URLWithString:filepath]];
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
        
        UILabel* lbPrice = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 100, 30)];
        [lbPrice setOpaque:NO];
        [lbPrice setAdjustsFontSizeToFitWidth:NO];
        //[lbLevel setMinimumFontSize:8.0f];
        [lbPrice setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [lbPrice setTextColor:[UIColor yellowColor]];
        [lbPrice setBackgroundColor:[UIColor clearColor]];
        [lbPrice setText:[[NSString alloc] initWithFormat:@"Price %@", price]];
        [row addSubview:lbPrice];
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setFrame:CGRectMake(240, 10, 70, 35)];
        [btn setTitle:@"Buy" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(fight:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
        [btn setTag:uid];
        [row addSubview:btn];   
        
        [vEquipment addSubview:row];
    }
    

    
}

@end
