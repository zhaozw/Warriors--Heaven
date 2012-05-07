//
//  ObjDetailViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjDetailViewController.h"
#import "WHHttpClient.h"

@implementation ObjDetailViewController
@synthesize vImage;
@synthesize lbSellPrice;
@synthesize lbRank;
@synthesize lbEffect;
@synthesize lbTitle;
@synthesize lbDesc;
@synthesize lbPrice;
@synthesize btnUse;
@synthesize ad;
@synthesize obj;

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
    ad = [UIApplication sharedApplication].delegate;
}

- (void)viewDidUnload
{
    [self setLbSellPrice:nil];
    [self setLbRank:nil];
    [self setLbEffect:nil];
    [self setLbTitle:nil];
    [self setLbDesc:nil];
    [self setVImage:nil];
    [self setLbPrice:nil];
    [self setBtnUse:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onSell:(id)sender {

    WHHttpClient* client = [[WHHttpClient alloc] init:[self parentViewController] ];
    [client sendHttpRequest:[NSString stringWithFormat:@"/usereqs/sell?id=%d", [[obj valueForKey:@"id"] intValue]] selector:@selector(onSellReturn:) json:YES showWaiting:YES];

}


- (IBAction)onClose:(id)sender {
    self.view.hidden = YES;
}

- (IBAction)onUse:(id)sender {
    WHHttpClient* client = [[WHHttpClient alloc] init:[self parentViewController] ];
    [client sendHttpRequest:[NSString stringWithFormat:@"/usereqs/use?id=%d", [[obj valueForKey:@"id"] intValue]] selector:@selector(onUseReturn:) json:YES showWaiting:YES];
}



- (void) loadObjDetail:(NSObject*) o{
    obj = o;
    NSDictionary* eq = o;
    NSString *str = [NSString stringWithFormat:@"%@", [eq valueForKey:@"dname"]];
    [lbTitle setText:str];
//    CGSize size = [str sizeWithFont:lbName.font];
//    lbName.frame = CGRectMake(0, 0, size.width, 18);
//    lbEffect.frame = CGRectMake(size.width+5, 0, 100, 18);
    [lbEffect setText:[NSString stringWithFormat:@"%@", [eq valueForKey:@"effect"]]];
    [lbDesc setText:[[NSString alloc] initWithFormat:@"%@", [eq valueForKey:@"desc"]]];
    [lbRank setText:[[eq valueForKey:@"rank"] stringValue]];
    NSString* filepath = [eq valueForKey:@"image"];
    if (filepath == NULL || filepath.length == 0)
        filepath = [NSString stringWithFormat:@"%@.png", [eq valueForKey:@"eqname"]];
    filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, filepath];
    [vImage setImageURL:[NSURL URLWithString:filepath]];
    int price = [[eq valueForKey:@"price"] intValue]/2;
    lbPrice.text = [[NSNumber numberWithInt:price] stringValue];
    [self view].hidden = NO;
    
    int type = [[eq valueForKey:@"eqtype"] intValue];
    if ( type != 2){
        btnUse.hidden = YES;
    }else{
        btnUse.hidden = NO;
    }
}

- (void) hideDetailView{
    [self view].hidden = YES;
}
@end
