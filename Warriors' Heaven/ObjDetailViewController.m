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
@synthesize slbPrice;
@synthesize btTrade;
@synthesize lbHp;
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
    [self view ].hidden = YES;
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
    [self setSlbPrice:nil];
    [self setBtTrade:nil];
    [self setLbHp:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (IBAction)onClose:(id)sender {
    self.view.hidden = YES;
}

- (IBAction)onUse:(id)sender {
    WHHttpClient* client = [[WHHttpClient alloc] init:[self parentViewController] ];
    [client sendHttpRequest:[NSString stringWithFormat:@"/usereqs/use?id=%d", [[obj valueForKey:@"id"] intValue]] selector:@selector(onUseReturn:) json:YES showWaiting:YES];
}


- (void) setViewType:(NSString*) type{
     NSObject* p = [self parentViewController];
    if ([type isEqualToString:@"buy"]){
        viewType = @"buy";
        [btTrade setTitle:@"购买" forState:UIControlStateNormal];
//        [btTrade addTarget:[self parentViewController] action:@selector(onBuy:) forControlEvents:UIControlEventTouchUpInside];
        slbPrice.text = @"买入价格";
    }
    else if ([type isEqualToString:@"sell"]){
       
        viewType = @"sell";
        [btTrade setTitle:@"卖出" forState:UIControlStateNormal];
//        [btTrade addTarget:[self parentViewController] action:@selector(onSell1:) forControlEvents:UIControlEventTouchUpInside];
         slbPrice.text = @"卖出价格";
    }
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
//    id nodeHP = [AppDelegate getProp:[eq valueForKey:@"prop"] name:@"hp"];
    id nodeHP = [eq valueForKey:@"hp"];
    id nodeMaxHP = [eq valueForKey:@"max_hp"];
    if (nodeHP && nodeMaxHP){
        int hp = [nodeHP intValue];
        int percentage = hp  *100/[ nodeMaxHP intValue];
//        [lbHp setText:[NSString stringWithFormat:@"%d%%", percentage]];
        [lbHp setText:[NSString stringWithFormat:@"%d", hp]];
    }else{
         [lbHp setText:@"N/A"];
    }
    NSString* filepath = [eq valueForKey:@"image"];
    if (filepath == NULL || filepath.length == 0)
        filepath = [NSString stringWithFormat:@"%@.png", [eq valueForKey:@"eqname"]];
    filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, filepath];
    [vImage setImageURL:[NSURL URLWithString:filepath]];
     int price = [[eq valueForKey:@"price"] intValue];
    int sell_price = [[eq valueForKey:@"sell_price"] intValue];
    if ([viewType isEqualToString:@"sell"])
        price = sell_price;
   
    lbPrice.text = [[NSNumber numberWithInt:price] stringValue];
    [self view].hidden = NO;
    
    int _id =  [[eq valueForKey:@"id"] intValue];
    btTrade.tag = _id;
    btnUse.tag = _id;
    int type = [[eq valueForKey:@"eqtype"] intValue];
    if ( type != 2){
        btnUse.hidden = YES;
    }else{
        btnUse.hidden = NO;
    }
}
- (void) setOnTrade:(id)c  sel:(SEL) sel{
    if (c && sel){
//        [btTrade removeTarget:self action:@selector(onFight:) forControlEvents:UIControlEventTouchUpInside];
        [btTrade addTarget:c action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void) setOnUse:(id)c  sel:(SEL) sel{
    if (c && sel){
        [btnUse removeTarget:self action:@selector(onUse:) forControlEvents:UIControlEventTouchUpInside];
        [btnUse addTarget:c action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void) hideDetailView{
    [self view].hidden = YES;
}
@end
