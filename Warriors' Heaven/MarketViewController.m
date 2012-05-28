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
#import "EGOImageButton.h"
#import "AppDelegate.h"

@implementation MarketViewController
@synthesize btEquipment;
@synthesize btFixure;
@synthesize btPremierEq;
@synthesize vEquipment;
@synthesize vFixure;
@synthesize vPremierEq;
@synthesize btSpecial;
@synthesize vSpecial;
@synthesize currentSelectedList;
@synthesize btCurrentSelected;
@synthesize vcObjDetail;
@synthesize ad;

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
//    item_list = [[NSMutableArray alloc ] init];
    currentSelectedList = 1; // equipment
    vEquipment.frame = CGRectMake(0, 130, 320, 500);
    [vEquipment setBackgroundColor:[UIColor clearColor]];
    
    vFixure.frame = CGRectMake(0, 130, 320, 500);
    [vFixure setBackgroundColor:[UIColor clearColor]];
    vFixure.hidden = YES;
    
    vPremierEq.frame = CGRectMake(0, 130, 320, 500);
    vPremierEq.hidden = YES;
    [vPremierEq setBackgroundColor:[UIColor clearColor]];
 
    vSpecial.frame = CGRectMake(0, 130, 320, 500);
    vSpecial.hidden = YES;
    [vSpecial setBackgroundColor:[UIColor clearColor]];
    
    [btEquipment setSelected: YES];
    [btEquipment setHighlighted:YES];
    btCurrentSelected = btEquipment;
    btEquipment.tag = 1;
    btFixure.tag = 2;
    btPremierEq.tag = 3;
    [btEquipment addTarget:self action:@selector(selectList:) forControlEvents:UIControlEventTouchUpInside];
    [btFixure addTarget:self action:@selector(selectList:) forControlEvents:UIControlEventTouchUpInside];
    [btPremierEq addTarget:self action:@selector(selectList:) forControlEvents:UIControlEventTouchUpInside];
    [btSpecial addTarget:self action:@selector(selectList:) forControlEvents:UIControlEventTouchUpInside];

//     [self addChildViewController:vcObjDetail];
    [[ad window] addSubview:[vcObjDetail view]];
    vcObjDetail.view.frame=CGRectMake(0, 60, 320, 420);
    [vcObjDetail setViewType:@"buy"];
   
    [self updateData];
    
    
}

- (void)viewDidUnload
{
    [self setBtEquipment:nil];
    [self setBtFixure:nil];
    [self setBtPremierEq:nil];
    [self setVEquipment:nil];
    [self setVFixure:nil];
    [self setVPremierEq:nil];
    [self setVcObjDetail:nil];
    [self setBtSpecial:nil];
    [self setVSpecial:nil];
    [self setBtSpecial:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) highlightButton:(UIButton*) btn{
    
    btn.selected = YES;
    btn.highlighted = YES;
    btCurrentSelected.selected = NO;
    btCurrentSelected.highlighted = NO;
    btCurrentSelected = btn;
    
}

- (void) selectList:(UIButton*)btn{
    currentSelectedList = btn.tag;
    [self performSelector:@selector(highlightButton:) withObject:btn afterDelay:0.0];
//    WHHttpClient* client = [[WHHttpClient alloc] init:self];
//    [client sendHttpRequest:[NSString stringWithFormat:@"/tradables?type=%d", btn.tag] selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    UIView* v = NULL;
    if (currentSelectedList == 1){
        v = vEquipment;
        vFixure.hidden = YES;
        vPremierEq.hidden = YES;
        vSpecial.hidden = YES;
    } 
    else if (currentSelectedList == 2){
        v = vFixure;
        vEquipment.hidden = YES;
        vPremierEq.hidden = YES;
        vSpecial.hidden = YES;
    }
    else if (currentSelectedList == 3){
        v = vPremierEq;
        vEquipment.hidden = YES;
        vFixure.hidden = YES;
        vSpecial.hidden = YES;
    }else if (currentSelectedList == 4){
        v = vSpecial;
        vEquipment.hidden = YES;
        vFixure.hidden = YES;
        vPremierEq.hidden = YES;
    }    
    
    v.hidden = NO;
    CGRect r = v.frame;
    
    
    if (r.size.height+130 > 480){
        UIScrollView* scv = [self view];
        scv.contentSize = CGSizeMake(0, r.size.height+130-480);
    }

    
}

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    [ad setBgImg:[UIImage imageNamed:@"bg_market.jpg"] ];
//   
//    if (currentSelectedList == 1)
//        [client sendHttpRequest:@"/tradables?type=1" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
//    else if (currentSelectedList == 2){
//        [client sendHttpRequest:@"/tradables?type=2" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
//    }
//    else if (currentSelectedList == 3){
//         [client sendHttpRequest:@"/tradables?type=3" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
//    }

}

- (NSObject*) getObjById:(int) index{
    if (!item_list) {
        return NULL;
    }
    for (int i = 0; i< [item_list count]; i++){
        NSObject* o = [item_list objectAtIndex:i];
        int _id = [[o valueForKey:@"id"] intValue];
        if (_id == index){
            return o;
        }
    }
    return NULL;
}

- (void) updateData{
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/tradables" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
}
- (void) onReceiveStatus:(NSArray*) data{
    // start next update in 24 hours
    [self performSelector:@selector(updateData) withObject:NULL afterDelay:3600*24];
     AppDelegate * ad = [UIApplication sharedApplication].delegate;
    item_list = data;
    UIView* v = NULL;
//    if (currentSelectedList == 1){
//        v = vEquipment;
//        vFixure.hidden = YES;
//        vPremierEq.hidden = YES;
//    } 
//    else if (currentSelectedList == 2){
//        v = vFixure;
//        vEquipment.hidden = YES;
//        vPremierEq.hidden = YES;
//    }
//    else if (currentSelectedList == 3){
//        v = vPremierEq;
//        vEquipment.hidden = YES;
//        vFixure.hidden = YES;
//    }
//    
    NSArray* svs = [v subviews];
    for (int i =0; i< [svs count]; i++){
        UIView* sv = [svs objectAtIndex:i];
        [sv removeFromSuperview];
    }
    int count = [data count];
    int count_eq = 0;
    int count_fx = 0;
    int count_pr = 0;
    int count_sp = 0;
    int row_height = 60;
    int row_margin = 1;
    int y = 300;
    for (int i = 0; i< count; i++){
        NSObject* d = [data objectAtIndex:i];
      
//        NSObject* json = [d valueForKey:@"tradable"];
        NSObject* json = d;
        int _id = [[json valueForKey:@"id"] intValue];
        int obtype = [[json valueForKey:@"obtype"] intValue];
        NSString *desc = [json valueForKey:@"desc"];
        NSString* name = [json valueForKey:@"name"];
        NSString* dname = [json valueForKey:@"dname"];
        NSString* price = [[json valueForKey:@"price"] stringValue];
        NSString* number = [[json valueForKey:@"number"] stringValue];
        NSString* soldnum = [[json valueForKey:@"soldnum"] stringValue];
        int _type = [[json valueForKey:@"obtype"] intValue];
        int rank = [[json valueForKey:@"rank"] intValue];
        
        int index;
        switch (obtype) {
            case 1:
                index = count_eq;
                break;
            case 2:
                index = count_fx;
                break;
            case 3:
                index = count_pr;
                break;
            case 4:
                index = count_sp;
                break;               
            default:
                break;
        }
        y = 10+ index*(row_height+row_margin);
        UIView * row = [[UIView alloc] initWithFrame:CGRectMake(0,y, 320, row_height)];
        //        if (i/2*2 == i)
        //            [row setBackgroundColor:[UIColor redColor]];
        //        else
        //            [row setBackgroundColor:[UIColor greenColor]];
        [row setOpaque:NO];
        [row setBackgroundColor:[UIColor clearColor]];
        
        UIImageView* rowbg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, row_height)];
        rowbg.userInteractionEnabled = YES;
        rowbg.backgroundColor = [UIColor grayColor];
        rowbg.image = [UIImage imageNamed:@"shelf7.jpg"];
        rowbg.alpha = 0.2f;
        [row addSubview:rowbg];
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
        NSString* filepath = [json valueForKey:@"image"];
        if (filepath == NULL || filepath.length == 0)
            filepath = [NSString stringWithFormat:@"%@.png", name];
        
            
      /*  if (_type == 1)
            filepath = [NSString stringWithFormat:@"http://%@:%@/game/obj/equipments/%@", ad.host, ad.port, filepath];
        else
            filepath = [NSString stringWithFormat:@"http://%@:%@/game/obj/fixures/%@", ad.host, ad.port, filepath];*/
        filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, filepath];
        NSLog(@"filepath=%@", filepath);
//        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"p_%d.jpg", i] ] ];
        EGOImageButton* logo = [[EGOImageButton alloc] init];
        [logo setImageURL:[NSURL URLWithString:filepath]];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [logo addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [logo setTag:_id];
        logo.backgroundColor = [UIColor clearColor];
        [logo setFrame:CGRectMake(1, 5, 50, 50)];
        [row addSubview:logo];
        
        UILabel* lbInfo = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 100, 15)];
        [lbInfo setOpaque:NO];
        //        lbInfo setContentMode:<#(UIViewContentMode)#>
//        [lbInfo setAdjustsFontSizeToFitWidth:YES];
        [lbInfo setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [lbInfo setTextColor:[UIColor whiteColor]];
        [lbInfo setBackgroundColor:[UIColor clearColor]];
        [lbInfo setText:[[NSString alloc] initWithFormat:@"%@", dname]];
        [row addSubview:lbInfo];
        
        UILabel* lbPrice = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 100, 15)];
        [lbPrice setOpaque:NO];
        [lbPrice setAdjustsFontSizeToFitWidth:NO];
        //[lbLevel setMinimumFontSize:8.0f];
        [lbPrice setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [lbPrice setTextColor:[UIColor yellowColor]];
        [lbPrice setBackgroundColor:[UIColor clearColor]];
        [lbPrice setText:[[NSString alloc] initWithFormat:@"Price %@", price]];
        [row addSubview:lbPrice];
        
//        UIImageView* vRank = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star.png"]];
        UIView* vRank = [[UIView alloc] init];
        vRank.frame = CGRectMake(60, 35, 15*rank, 15);
        [vRank setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"star.png"]]];
        [vRank setOpaque:NO];
        [row addSubview:vRank];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [btn setFrame:CGRectMake(240, 10, 70, 35)];
        [btn setTitle:@"Buy" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(onBuy:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
        [btn setTag:_id];
        [row addSubview:btn];   
        
        if (obtype == 1){
            [vEquipment addSubview:row];
            count_eq ++;
        }
        else if (obtype == 2){
            count_fx++;
            [vFixure addSubview:row];
        }
        else if (obtype == 3){
            [vPremierEq addSubview:row];
            count_pr++;
        }
        else if (obtype == 4){
            [vSpecial addSubview:row];
            count_sp++;
        }
//        [v addSubview:row];
    }
    
    
    CGRect r = vEquipment.frame;
    r.size.height = 10+ count_eq*(row_height+row_margin);
    vEquipment.frame = r;

    r = vFixure.frame;
    r.size.height = 10+ count_fx*(row_height+row_margin);
    vFixure.frame = r;
 
     r = vPremierEq.frame;
    r.size.height = 10+ count_pr*(row_height+row_margin);
    vPremierEq.frame = r;

    r = vSpecial.frame;
    r.size.height = 10+ count_sp*(row_height+row_margin);
    vSpecial.frame = r;
    
    
//    v.hidden = NO;
//    r = v.frame;
//
//    
//    if (r.size.height+130 > 480){
//        UIScrollView* scv = [self view];
//        scv.contentSize = CGSizeMake(0, r.size.height+130-480);
//    }
    
}
- (void) selectItem:(UIButton*) btn{
    NSObject* o = [self getObjById:btn.tag];
    [vcObjDetail loadObjDetail:o];
    [[self view] bringSubviewToFront:[vcObjDetail view]];
}

- (void) onBuyReturn:(NSObject*) data{
    NSString* s = [data valueForKey:@"error"];
    if (s){
        [ad showMsg:s type:0 hasCloseButton:YES];
        return;
    }
 
    s =  [data valueForKey:@"msg"];
    [ad showMsg:s type:1 hasCloseButton:YES];
    [ad checkUpdated:data];
//    int gold = [[data valueForKey:@"gold"] intValue];
//    [[ad getDataUserext] setValue:[NSNumber numberWithInt:gold]  forKey:@"gold"];
    [ad reloadStatus];
    ad.bUserEqNeedUpdated = YES;
}
- (void) onBuy:(UIButton*) btn{
    int _id = btn.tag;
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:[NSString stringWithFormat:@"/tradables/buy/%d", _id] selector:@selector(onBuyReturn:) json:YES showWaiting:YES];
    
    
}

@end
