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
    vBg = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    vImage = [[EGOImageView alloc] initWithFrame:CGRectMake(5, 5, 130, 130)];
    vImage.contentMode = UIViewContentModeScaleAspectFit;
    [[self view ]addSubview:vBg];
    [[self view ] addSubview:vImage];
    [[self view] sendSubviewToBack:vBg];
    [[ad window] addSubview:[self view]];
    
//    vEquipment.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
//    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(5, 139, 310, 300)];
//    [v addSubview:lbDesc];
//    [v addSubview:vEquipment];
//    [v addSubview:lbEq];
//    [v addSubview:btnClose];
}

- (void) loadPlayer:(id) data{
    if (!data)
        return;
    for (int i = 0; i <[vEquipment.subviews count]; i++){
        [[vEquipment.subviews objectAtIndex:i] removeFromSuperview];
    }
    
    id ext = [data valueForKey:@"userext"];
    NSString *title = [ext valueForKey:@"title"];
    int uid = [[ext valueForKey:@"uid"] intValue];
    NSString * name = [ext valueForKey:@"name"];
    int level = [[ext valueForKey:@"level"] intValue];
    int profile = [[ext valueForKey:@"profile"] intValue];
    [vImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"p_%db.png", profile]]];
    lbTitle.text = name;
    lbLevel.text = [NSString stringWithFormat:@"%d", level];
    lbDesc.text = @"";
    btnFight.tag = uid;
    [vBg setImage:[UIImage imageNamed:@"fight_result.png"]];
    
    
    
    NSArray* eqs = [ext valueForKey:@"equipments"];
      [self loadEq:eqs];
    
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
    for (int i = 0; i <[vEquipment.subviews count]; i++){
        [[vEquipment.subviews objectAtIndex:i] removeFromSuperview];
    }
    hero = [data valueForKey:@"name"];
    NSString* name = [data valueForKey:@"dname"];
    NSString* title = [data valueForKey:@"title"];
    NSString* desc = [data valueForKey:@"desc"];
    NSArray* eqs = [data valueForKey:@"equipments"];
    NSString* image = [data valueForKey:@"image"];
    NSString* homeImage = [data valueForKey:@"homeImage"];
    
    lbTitle.text = name;
    lbLevel.text = title;
    lbDesc.text = desc;
    [vBg setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/game/%@", [ad host], [ad port], homeImage]]];
    [vImage setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/game/%@", [ad host], [ad port], image]]];

    [self loadEq:eqs];
    [self view].hidden = NO;
    
}


- (void) setOnFight:(id)c  sel:(SEL) sel{
    if (c && sel){
        [btnFight removeTarget:self action:@selector(onFight:) forControlEvents:UIControlEventTouchUpInside];
        [btnFight addTarget:c action:sel forControlEvents:UIControlEventTouchUpInside];
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
}

- (IBAction)onTouchClose:(id)sender {
    [self view].hidden = YES;
}

- (IBAction)onFight:(id)sender {
//    WHHttpClient* client = [[WHHttpClient alloc] init:self];
//    NSString* url = [[NSString alloc] initWithFormat:@"/wh/fightHero?name=%@", hero];
//    [client sendHttpRequest:url selector:@selector(onFightReturn:) json:YES showWaiting:YES];
    
    lbDesc.hidden = YES;
    vEquipment.hidden = YES;
    lbEq.hidden = YES;
    btnClose.hidden = YES;
    btnFight.hidden = YES;
    
    vFightView.hidden = NO;
    NSString * url = [NSString stringWithFormat:@"http://%@:%@/wh/fightHero?name=%@", ad.host, ad.port, ad.session_id, hero];
    wvFight.backgroundColor = [UIColor clearColor];
    
    [wvFight loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    

    

}
@end
