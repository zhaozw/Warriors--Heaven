//
//  BossViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BossViewController.h"
#import "WHHttpClient.h"
#import "BossViewController.h"
#import "LightView.h"
#import "SBJson.h"

@implementation BossViewController
@synthesize lbTitle;
@synthesize lbLevel;
@synthesize vEquipment;
@synthesize btnFight;
@synthesize lbDesc;
@synthesize btnClose;
@synthesize lbEq;
@synthesize vFightView;
@synthesize wvFight;
@synthesize lbRace;
@synthesize lbTitle2;
@synthesize vWebBG;
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
  //  vBg = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    vImage = [[EGOImageView alloc] initWithFrame:CGRectMake(5, 5, 130, 130)];
    vImage.contentMode = UIViewContentModeScaleAspectFit;
   // [[self view ]addSubview:vBg];
    [[self view ] addSubview:vImage];
//    [[self view] sendSubviewToBack:vBg];
    [vWebBG setBackgroundColor:[UIColor clearColor]];
    [vWebBG setOpaque:NO];
    [[ad window] addSubview:[self view]];
    vWebBG.delegate = self;
//    vEquipment.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
//    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(5, 139, 310, 300)];
//    [v addSubview:lbDesc];
//    [v addSubview:vEquipment];
//    [v addSubview:lbEq];
//    [v addSubview:btnClose];
    
    vWaitBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:vWaitBG];
    vWaitBG.backgroundColor = [UIColor blackColor];
    vWaitBG.hidden = YES;
    vWaitBG.alpha =0.9;
}

- (void) loadPlayer:(id) data{
    if (!data)
        return;
    [LightView removeAllSubview:vEquipment];
    NSLog(@"%@", [data JSONRepresentation]);
    
    id ext = [data valueForKey:@"userext"];
    NSString *title = [ext valueForKey:@"title"];
    int uid = [[ext valueForKey:@"uid"] intValue];
    NSString * name = [ext valueForKey:@"name"];
    int level = [[ext valueForKey:@"level"] intValue];
    int profile = [[ext valueForKey:@"profile"] intValue];
    if (profile > 5) {
        NSString* sProf = [NSString stringWithFormat:@"http://%@:%@/game/profile/p_%db.png", ad.host, ad.port, profile];
        [vImage setImageURL:[NSURL URLWithString:sProf]];
    }else
        [vImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"p_%db.png", profile]]];
    lbTitle.text = name;
    lbLevel.text = [NSString stringWithFormat:@"%d", level];
    lbDesc.text = @"";
    if (title != NULL && title != [NSNull null] )
        lbTitle2.text = title;
    btnFight.tag = uid;
    
//    [vBg setImage:[UIImage imageNamed:@"fight_result.png"]];
    
    
//    NSMutableArray *pos_map = [[NSMutableArray alloc] initWithObjects:@"head"
//                               ,@"head"
//                               ,@"neck"
//                               ,@"handright"
//                               ,@"arm"
//                               ,@"fingerright"
//                               ,@"handleft"
//                               ,@"fingerleft"
//                               ,@"foot"
//                               ,@"leg"
//                               ,@"body"
//                               ,nil];
    
    NSArray* eqs = [ext valueForKey:@"equipments"];
//    NSMutableArray* carrying = [[NSMutableArray alloc] init];
//    NSString* prop = [ext valueForKey:@"prop"];
//    NSObject* js = [prop JSONValue];
//    NSObject* es = [js valueForKey:@"eqslot"];
//    NSObject* eqslot = es;
//    if ([es isKindOfClass:[NSString class]])
//        eqslot = [(NSString*)es JSONValue];
//    
//    if (eqslot){
//        //        NSObject* epslot = [sepslot JSONValue];
//        int epid = -1;
//      
//        for (int i = 0; i< [pos_map count]; i++) {
//            
//            NSString* pos = [pos_map objectAtIndex:i];
//            NSString* v = [eqslot valueForKey:pos];
//            if ([v isKindOfClass:[NSString class]]){
//                NSArray *vs =[v componentsSeparatedByString:@"@"];
//                epid = [[vs objectAtIndex:1] intValue];
//            }else
//                epid = [v intValue];
//            
//            if (epid <=0)
//                continue;
//     
//            id obj = NULL;
//            for (int j= 0; j<[eqs count]; j++){
//                id o = [eqs objectAtIndex:j];
//                int _id1 = [[o valueForKey:@"id"] intValue];
//                if (_id1 == epid){
//                    obj = o;
//                    break;
//                }
//            }
//            
//            if (obj == NULL)
//                continue;
//            
//            [carrying addObject:obj];
//                     
//        }
//    }

    
    
    
      
//    [self loadEq:carrying];
    
    
    [self loadEq:eqs];
    
    //  [aiv setAlpha:0.0f];
    NSLog(@"%@", [NSString stringWithFormat:@"<html><body><img src = 'file://%@/button2.png'></body></html>", [[NSBundle mainBundle] bundlePath] ]);
    [vWebBG loadHTMLString:[NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><img style=\"position:absolute;left:0;top:0\" width='320' height='480' src = \"file://%@\"></body></html>", [[NSBundle mainBundle] pathForResource:@"playerview" ofType:@"gif"] ] baseURL:Nil] ;
     [self view].hidden = NO;
}
- (void) loadEq:(NSArray*) eqs{
    
    int count_per_row = 5;
    int height = 50;
    int width = 50;
    int margin_item_horizon = 5;
    int margin_item_vertical = 5;
    int margin_left = 2;
    int margin_top = 2;
    int textHeight = 18;
    int i = 0;
    int x= 0;
    int y = 0;
    for (i= 0; i< [eqs count]; i++){
        NSObject* eq = [eqs objectAtIndex:i];
        NSString* eqImage = [eq valueForKey:@"image"];
        int postion_x = i%count_per_row;
        int row= i/count_per_row;
        x = margin_left+postion_x*(width+margin_item_horizon);
        y = margin_top+row*(height+margin_item_vertical+textHeight);
        EGOImageView *v = [[EGOImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        v.imageURL =  [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/game/%@", [ad host], [ad port], eqImage]];
        [vEquipment addSubview:v];
        
        NSString* dname = [eq valueForKey:@"dname"];
        UILabel* t = [LightView createLabel:CGRectMake(x-margin_item_horizon/2, y+height, width+margin_item_horizon/2, textHeight) parent:vEquipment text:dname textColor:[UIColor yellowColor]];
        t.textAlignment = UITextAlignmentCenter;
        
    }
    
    CGRect rect = vEquipment.frame;
    //    i --;
    //    int row= i/count_per_row;
    //    rect.size.height = margin_top+row*(height+margin_item_vertical+textHeight)+ height + textHeight+2;
    rect.size.height = y + height+ textHeight+2;
    vEquipment.frame = rect;
}
- (void) loadHero:(NSObject*) data{
    if (!data)
        return;
    [LightView removeAllSubview:vEquipment];
    hero = [data valueForKey:@"name"];
    NSString* name = [data valueForKey:@"dname"];
    NSString* title = [data valueForKey:@"title"];
    NSString* desc = [data valueForKey:@"desc"];
    NSArray* eqs = [data valueForKey:@"equipments"];
    NSString* image = [data valueForKey:@"image"];
    NSString* homeImage = [data valueForKey:@"homeImage"];
    NSString* race = [data valueForKey:@"race"];
    int level = [[data valueForKey:@"level"] intValue];

    lbTitle.text = name;
    lbLevel.text = [NSString stringWithFormat:@"%d", level];
    lbDesc.text = desc;
    lbTitle2.text = title;
    if ([race isEqualToString:@"human"]){
        lbRace.text = @"人类";
    }else if ([race isEqualToString:@"orc"]){
        lbRace.text = @"兽族";
    }else if ([race isEqualToString:@"mag"]){
        lbRace.text = @"魔族";
    }
   // [vBg setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/game/%@", [ad host], [ad port], homeImage]]];
    NSString *sHomeImageUrl = [NSString stringWithFormat:@"http://%@:%@/game/%@", [ad host], [ad port], homeImage];
     [vWebBG loadHTMLString:[NSString stringWithFormat:@"<html><body style='background:transparent;background-color: transparent' ><img style=\"position:absolute;left:0;top:0\" width='320' height='480' src = \"%@\"></body></html>", sHomeImageUrl] baseURL:Nil] ;
//    [vWebBG loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/game/%@", [ad host], [ad port], homeImage]]]];
    [vImage setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/game/%@", [ad host], [ad port], image]]];

    [self loadEq:eqs];
    [self view].hidden = NO;
    
}


- (void) setOnFight:(id)c  sel:(SEL) sel{
    if (c && sel){
        [btnFight removeTarget:self action:@selector(onFight:) forControlEvents:UIControlEventTouchUpInside];
        [btnFight addTarget:c action:sel forControlEvents:UIControlEventTouchUpInside];
    }else{
        btnFight.hidden = YES;
    }
}
                    

- (void)viewDidUnload
{
    [self setLbTitle:nil];
    [self setLbLevel:nil];
    [self setVEquipment:nil];
    [self setLbDesc:nil];
    [self setBtnFight:nil];
    [self setBtnClose:nil];
    [self setLbEq:nil];
    [self setVFightView:nil];
    [self setWvFight:nil];
    [self setVWebBG:nil];
    [self setLbTitle2:nil];
    [self setLbRace:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onCloseFightView:(id)sender {
    
    vFightView.hidden = YES;
    
    lbDesc.hidden =     NO;
    vEquipment.hidden = NO;
    lbEq.hidden =       NO;
    btnClose.hidden =   NO;
    btnFight.hidden =   NO;
    [wvFight loadHTMLString:@"" baseURL:nil];
    [ad updateUserext];
    ad.bUserEqNeedUpdated = YES;
}

- (IBAction)onTouchClose:(id)sender {
    [self view].hidden = YES;
}

- (IBAction)onFight:(id)sender {
//    WHHttpClient* client = [[WHHttpClient alloc] init:self];
//    NSString* url = [[NSString alloc] initWithFormat:@"/wh/fightHero?name=%@", hero];
//    [client sendHttpRequest:url selector:@selector(onFightReturn:) json:YES showWaiting:YES];
    // check hp and stam
    NSDictionary* ext = [ad getDataUserext];
    if (ext){
        int hp = [[ext valueForKey:@"hp"] intValue];
        int stam = [[ext valueForKey:@"stam"] intValue];
        if (hp < 0 ){
            [ad showMsg:@"你的hp不够，好好休息吧" type:1 hasCloseButton:YES];   
            return;
        }
        if (stam <0){
            [ad showMsg:@"你的体力不够，好好休息吧" type:1 hasCloseButton:YES];   
            return;
        }
        
        
    }
    
    
    lbDesc.hidden = YES;
    vEquipment.hidden = YES;
    lbEq.hidden = YES;
    btnClose.hidden = YES;
    btnFight.hidden = YES;
    
    vFightView.hidden = NO;
    NSString * url = [NSString stringWithFormat:@"http://%@:%@/wh/fightHero?name=%@", ad.host, ad.port, hero];
    wvFight.backgroundColor = [UIColor clearColor];
    
    [wvFight loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    

    

}
- (void) setOnClose:(id)c sel:(SEL) sel{
    [btnClose addTarget:c action:sel forControlEvents:UIControlEventTouchUpInside];
}

//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {    
    [ad showWaiting:YES];
//    return;
//    vWaitBG.hidden = NO;
//    [self.view bringSubviewToFront:vWaitBG];
    self.view.hidden = YES;
//    if (myAlert==nil){        
//        myAlert = [[UIAlertView alloc] initWithTitle:nil 
//                                             message: @"Loading"
//                                            delegate: self
//                                   cancelButtonTitle: nil
//                                   otherButtonTitles: nil];
//        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        activityView.frame = CGRectMake(120.f, 48.0f, 37.0f, 37.0f);
//        [myAlert addSubview:activityView];
//        [activityView startAnimating];
//        [myAlert show];
//    }
}

//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [ad showWaiting:NO];
//    return;
//    vWaitBG.hidden = YES;

//    UIView *view = (UIView *)[self.view viewWithTag:103];
//    [view removeFromSuperview];
//    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
//    myAlert = NULL;
    self.view.hidden =    NO;
}
@end
