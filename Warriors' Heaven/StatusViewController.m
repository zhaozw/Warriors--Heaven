//
//  StatusViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatusViewController.h"
#import "WHHttpClient.h"

@implementation StatusViewController
@synthesize lbGold;
@synthesize pbAmbition;
@synthesize pvHP;
@synthesize lbHP;
@synthesize lbAmbition;
@synthesize lbExp;
@synthesize lbLevel;

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
   
}

- (void) viewDidAppear:(BOOL) animated{
     WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/wh/userext" selector:@selector(onReceiveStatus:) showWaiting:NO];

}
- (void) onReceiveStatus:(NSObject*) json{
    NSLog(@"StatusViewController receive data:%@", json);
    json = [json valueForKey:@"userext"];
   // NSNumber* exp = [json  valueForKey:@"exp"];
    lbExp.text = [[json  valueForKey:@"exp"] stringValue];
    lbGold.text = [[json  valueForKey:@"gold"] stringValue];
    //lbAmbition = [json  valueForKey:@"exp"];
    lbLevel.text = [[json  valueForKey:@"level"] stringValue];
    NSString* strHp = [[json  valueForKey:@"hp"] stringValue];
    int hp = [strHp intValue];
        NSString* strMaxHp = [[json  valueForKey:@"maxhp"] stringValue];
    int maxhp = [strMaxHp intValue];
    lbHP.text = [[NSString alloc] initWithFormat:@"%@/%@", strHp, strMaxHp] ;
    [pvHP setProgress:((float)hp ) / ((float)maxhp) ];
}

- (void)viewDidUnload
{
    [self setLbGold:nil];
    [self setPbAmbition:nil];
    [self setPvHP:nil];
    [self setLbHP:nil];
    [self setLbAmbition:nil];
    [self setLbExp:nil];
    [self setLbLevel:nil];
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
