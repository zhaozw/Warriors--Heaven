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
#import "WHHttpClient.h"
#import "SBJson.h"

@implementation CharacterViewController
@synthesize vcStatus;
@synthesize vEquipment;
@synthesize vEq_cap;
@synthesize vEq_neck;
@synthesize vEq_handright;
@synthesize vEq_fingersRight;
@synthesize vEq_handleft;
@synthesize vEq_fingersleft;
@synthesize vEq_boots;
@synthesize vEq_trousers;
@synthesize vEq_armo;
@synthesize vEq_arm;

@synthesize vItemBg;
@synthesize eq_slots;
@synthesize eq_buttons;
@synthesize worneq_selected;
@synthesize sloteq_selected;

@synthesize vEqbtn_cap;
@synthesize vEqbtn_neck;
@synthesize vProfile;
@synthesize vEqbtn_handright;
@synthesize vEqbtn_arm;
@synthesize vEqbtn_fingersRight;
@synthesize vEqbtn_handleft;
@synthesize vEqbtn_fingersleft;
@synthesize vEqbtn_boots;
@synthesize vEqbtn_trousers;
@synthesize vEqbtn_armo;
@synthesize vEqInfoView;

@synthesize lbStrength;
@synthesize lbDext;
@synthesize lbIntellegence;
@synthesize lbWeight;
@synthesize lbDamage;
@synthesize lbDeffencce;

//@synthesize eq_list;
@synthesize pos_list;
//@synthesize woren_eq_list;
@synthesize ad;
@synthesize item_list;

@synthesize lbLongDesc;

@synthesize vItemInfoView;

@synthesize lbName;

@synthesize vLongDescContainer;

@synthesize vItemLongDescContainer;
@synthesize lbItemName;
@synthesize lbItemEffect;
@synthesize lbItemLongDesc;

@synthesize item_buttons;

@synthesize pos_map;

@synthesize lbEffect;

@synthesize vProp;
//@synthesize positions;

@synthesize vItemContainer;

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
UILabel* createLabel(CGRect frame, UIView* parent,NSString* text, UIColor* textColor){
    UILabel *c = [[UILabel alloc]initWithFrame:frame];
    [parent addSubview:c];
    [c setOpaque:NO];
    [c setAdjustsFontSizeToFitWidth:YES];
    [c setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];

    [c setBackgroundColor:[UIColor clearColor]];
    if (textColor)
        [c setTextColor:textColor];
    else
        [c setTextColor:[UIColor whiteColor]];
    c.text = text;
    return c;
}

- (int) calcWeight{
    NSArray* eqs = [ad getDataUserEqs];
    NSDictionary* data = [[NSMutableDictionary alloc] init ];
    NSArray* keys = [pos_map allKeys];
    int total_weight = 0;
    for (int i = 0; i< [keys count]; i++) {
        NSString* pos = [keys objectAtIndex:i];
        if ([pos characterAtIndex:0] >=48 && [pos characterAtIndex:0] <=57)
            continue;
        UIButton* btn = [pos_map valueForKey:pos];
        int index = [self findEpById:btn.tag];
        if (index < 0)
            continue;
        NSObject* o = [[eqs objectAtIndex:index] valueForKey:@"usereq"];
        int weight = [[o valueForKey:@"weight"] intValue];
        total_weight += weight;
    }
    return total_weight;
}

- (int) calcAttack{
    NSArray* eqs = [ad getDataUserEqs];
    NSDictionary* data = [[NSMutableDictionary alloc] init ];
    NSArray* keys = [pos_map allKeys];
    int t_damage = 0;
    for (int i = 0; i< [keys count]; i++) {
        NSString* pos = [keys objectAtIndex:i];
        if ([pos characterAtIndex:0] >=48 && [pos characterAtIndex:0] <=57)
            continue;
        UIButton* btn = [pos_map valueForKey:pos];
        int index = [self findEpById:btn.tag];
        if (index < 0)
            continue;
        NSObject* o = [[eqs objectAtIndex:index] valueForKey:@"usereq"];
        int damage = [[o valueForKey:@"damage"] intValue];
        t_damage += damage;
    }
    return t_damage;
}
- (int) calcDefense{
    NSArray* eqs = [ad getDataUserEqs];
    NSDictionary* data = [[NSMutableDictionary alloc] init ];
    NSArray* keys = [pos_map allKeys];
    int t_damage = 0;
    for (int i = 0; i< [keys count]; i++) {
        NSString* pos = [keys objectAtIndex:i];
        if ([pos characterAtIndex:0] >=48 && [pos characterAtIndex:0] <=57)
            continue;
        UIButton* btn = [pos_map valueForKey:pos];
        int index = [self findEpById:btn.tag];
        if (index < 0)
            continue;
        NSObject* o = [[eqs objectAtIndex:index] valueForKey:@"usereq"];
        int damage = [[o valueForKey:@"defense"] intValue];
        t_damage += damage;
    }
    return t_damage;
}

- (void) initPropView{
    vProp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_prop.png"]];
    vProp.backgroundColor = [UIColor clearColor];
    vProp.opaque = NO;
    vProp.frame = CGRectMake(0, 80, 320, 80);
    
    [[self view] addSubview:vProp];
    int margin_left = 5;
    int margin_top=20;
    int height = 18;
    int row_margin =5;
    UIColor *tColor = [UIColor yellowColor];
    createLabel(CGRectMake(margin_left+0, margin_top+0, 30, height), vProp, @"力量", tColor);
    lbStrength = createLabel(CGRectMake(margin_left+40, margin_top+0, 30, height), vProp, @"0", NULL);
    
    createLabel(CGRectMake(margin_left+110, margin_top+0, 30, height), vProp, @"敏捷", tColor);
    lbDext = createLabel(CGRectMake(margin_left+150, margin_top+0, 30, height), vProp, @"0", NULL);
    
    createLabel(CGRectMake(margin_left+220, margin_top+0, 30, height), vProp, @"悟性", tColor);
    lbIntellegence = createLabel(CGRectMake(margin_left+260, margin_top+0, 30, height), vProp, @"0", NULL);
    
    createLabel(CGRectMake(margin_left+0, margin_top+row_margin*1+20, 30, height), vProp, @"负荷", tColor);
    lbWeight = createLabel(CGRectMake(margin_left+40, margin_top+row_margin*1+20, 30, height), vProp, @"0", NULL);
    
    createLabel(CGRectMake(margin_left+110, margin_top+row_margin*1+20, 30, height), vProp, @"攻击", tColor);
    lbDamage = createLabel(CGRectMake(margin_left+150, margin_top+row_margin*1+20, 30, height), vProp, @"0", NULL);
    
    
    createLabel(CGRectMake(margin_left+220, margin_top+row_margin*1+20, 30, 18), vProp, @"防御", tColor);
    lbDeffencce = createLabel(CGRectMake(margin_left+260, margin_top+row_margin*1+20, 30, height), vProp, @"0", NULL);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ad = [UIApplication sharedApplication].delegate;
    
    [self initPropView];
    
    NSString* prof = [NSString stringWithFormat:@"p_%@m.png", [[ad getDataUser] valueForKey:@"profile"]];
    [vProfile setImage:[UIImage imageNamed:prof]];
    
    UIImage *imageNormal = [UIImage imageNamed:@"bg_12.png"];
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    [vEquipment setImage:stretchableImageNormal];
    [vEquipment addSubview:vEqInfoView];
    
    vItemInfoView = [[UIView alloc] init];
    [vItemInfoView setBackgroundColor:[UIColor clearColor]];
    [vItemBg addSubview:vItemInfoView];
    
    
/*    positions = [[NSMutableArray alloc] initWithObjects:
                 @"head", 
                 @"neck",
                 @"handright",
                 @"arm",
                 @"fingerright",
                 @"handleft",
                 @"fingerleft",
                 @"foot",
                 @"leg",
                 @"body", nil];*/
    pos_map = [[NSMutableDictionary alloc] init];
    [pos_map setValue:NULL forKey:@"head"];
    [pos_map setValue:NULL forKey:@"neck"];
    [pos_map setValue:NULL forKey:@"handright"];
    [pos_map setValue:NULL forKey:@"arm"];
    [pos_map setValue:NULL forKey:@"fingerright"];
    [pos_map setValue:NULL forKey:@"handleft"];
    [pos_map setValue:NULL forKey:@"fingerleft"];
    [pos_map setValue:NULL forKey:@"foot"];
    [pos_map setValue:NULL forKey:@"leg"];
    [pos_map setValue:NULL forKey:@"body"];



    
    
    NSDictionary* ext = [ad getDataUserext];
    int max_eq = [[ext valueForKey:@"max_eq"] intValue];
    int row_count = 0;
    if (max_eq <= 0 ){
        row_count = 1;
        max_eq = 5;
    }
    else
        row_count = (max_eq-1)/5 + 1;
    vEqInfoView.frame = CGRectMake(10, 10+row_count*60, 300, 80);
    [vEqInfoView setBackgroundColor:[UIColor clearColor]];
    CGRect rect = vEquipment.frame;
    int max_item = [[ext valueForKey:@"max_item"] intValue];
    int item_row_count = 0;
    if (max_item <= 0 ){
        item_row_count = 1;
        max_item = 5;
    }
    else
        item_row_count = (max_item-1)/5 + 1;
    item_row_count = 1;
    vItemBg.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height, rect.size.width, 20+item_row_count*60+50);
    vItemContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, rect.size.width -20,item_row_count*60)];
//    vItemContainer.backgroundColor = [UIColor redColor];
    vItemContainer.opaque = NO;
    [vItemContainer setScrollEnabled:YES];
    [vItemBg addSubview:vItemContainer];
    vItemInfoView.frame = CGRectMake(10, 10+item_row_count*60, 300, 80);
    
    
    
    
    eq_buttons = [[NSMutableArray alloc] initWithCapacity:10];
    eq_slots = [[NSMutableArray alloc] initWithCapacity:10];
/*    woren_eq_list = [[NSMutableArray alloc] initWithObjects:
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                    [NSNull null],
                     nil];*/
    pos_list = [[NSMutableArray alloc] initWithObjects:
            [NSNull null],
           @"head",
           @"neck",
           @"hand right",
           @"arm",
           @"finger right",
           @"hand left",
           @"finger left",
           @"foot",
           @"leg",
           @"body",
        nil ];
//    eq_list = [[NSMutableArray alloc] initWithCapacity:max_eq+1];
//    [eq_list addObject:[NSNull null]];
    for (int i = 0; i< max_eq; i++){
        UIImageView* slot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eqslot.png"]];
        slot.frame = CGRectMake(10+i*60, 10, 60, 60);
        [slot setUserInteractionEnabled:YES];
        [vEquipment addSubview:slot];
        [eq_slots addObject:slot];
        [slot setTag:i+1];
        
        EGOImageButton *v = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        [eq_buttons addObject:v];
//        [v setTag:i+1];
        [v addTarget:self action:@selector(selectEq:) forControlEvents:UIControlEventTouchUpInside];
//        [v setTintColor:[UIColor redColor]];
        [slot addSubview:v];
        [pos_map setValue:v forKey:[[NSNumber numberWithInt:i] stringValue]];

//        [eq_list addObject:[NSNull null]];
    }
    
    item_list = [[NSMutableArray alloc] initWithCapacity:max_item+1];
    [item_list addObject:[NSNull null]];
    item_buttons = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< max_item; i++){
        UIImageView* slot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eqslot.png"]];
        slot.frame = CGRectMake(i*60, 0, 60, 60);
        [slot setUserInteractionEnabled:YES];
        [vItemContainer addSubview:slot];
//        [eq_slots addObject:slot];
        [slot setTag:i+1];
        
        EGOImageButton *v = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
//        [eq_buttons addObject:v];
//        [v setTag:i+1];
        [v addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        //        [v setTintColor:[UIColor redColor]];
        [item_buttons addObject:v];
        [slot addSubview:v];
        [item_list addObject:[NSNull null]];
    }
    
    
    //int offset = 60*max_item -vItemContainer.frame.size.width;
  //  if (offset > 0)
        vItemContainer.contentSize = CGSizeMake(60*max_item, 0);
    [vItemContainer scrollRectToVisible:CGRectMake(400, 0, 10, 10) animated:YES];

    
    
    // initialize posistion

   
    int k=1;
    vEqbtn_cap = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    [vEqbtn_cap addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_cap addSubview:vEqbtn_cap];
    [vEq_cap setTag:k];
//    [vEqbtn_cap setTag:k];
    [pos_map  setValue:vEqbtn_cap forKey:@"head"];
    k++;
    
//    [vEq_cap setTag:(int)@"head"];
//    [vEq_cap setValue:@"head" forKey:@"pos"];
    
    vEqbtn_neck = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_neck addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_neck addSubview:vEqbtn_neck];
    [vEq_neck setTag:2];
//    [vEqbtn_neck setTag:2];
    [pos_map  setValue:vEqbtn_neck forKey:@"neck"];
    k++;
    
    vEqbtn_handright = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_handright addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_handright addSubview:vEqbtn_handright];
    [vEq_handright setTag:3];
//    [vEqbtn_handright setTag:3];
    [pos_map  setValue:vEqbtn_handright forKey:@"handright"];
    k++;
    
    vEqbtn_arm = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_arm addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_arm addSubview:vEqbtn_arm];
    [vEq_arm setTag:4];
//    [vEqbtn_arm setTag:4];
    [pos_map  setValue:vEqbtn_arm forKey:@"arm"];
    k++;
    
    vEqbtn_fingersRight = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_fingersRight addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_fingersRight addSubview:vEqbtn_fingersRight];
        [vEq_fingersRight setTag:(int)5];
//    [vEqbtn_fingersRight setTag:5];
    [pos_map  setValue:vEqbtn_fingersRight forKey:@"fingerrigh"];
    k++;
    
    vEqbtn_handleft = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_handleft addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_handleft addSubview:vEqbtn_handleft];
        [vEq_handleft setTag:6];
//    [vEqbtn_handleft setTag:6];
    [pos_map  setValue:vEqbtn_handleft forKey:@"handleft"];
    k++;
    
    vEqbtn_fingersleft = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_fingersleft addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_fingersleft addSubview:vEqbtn_fingersleft];
        [vEq_fingersleft setTag:7];
//    [vEqbtn_fingersleft setTag:7];
    [pos_map  setValue:vEqbtn_fingersleft forKey:@"fingerleft"];
    k++;
    
    vEqbtn_boots = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_boots addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_boots addSubview:vEqbtn_boots];
        [vEq_boots setTag:8];
//    [vEqbtn_boots setTag:8];
    [pos_map  setValue:vEqbtn_boots forKey:@"foot"];
    k++;
    NSLog(@"vEqbtn_boots=%@", vEqbtn_boots);
    
    vEqbtn_trousers = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_trousers addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_trousers addSubview:vEqbtn_trousers];
        [vEq_trousers setTag:9];
//    [vEqbtn_trousers setTag:9];
    [pos_map  setValue:vEqbtn_trousers forKey:@"leg"];
    k++;
    
    vEqbtn_armo = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_armo addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_armo addSubview:vEqbtn_armo];
        [vEq_armo setTag:10];
//    [vEqbtn_armo setTag:10];
    [pos_map  setValue:vEqbtn_armo forKey:@"body"];
    k++;
    

    // init info view for eq
    vLongDescContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 18, 300, 30)];
    [vLongDescContainer setContentSize:CGSizeMake(500, 0)];
    [vLongDescContainer setBackgroundColor:[UIColor clearColor]];
    lbName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 18)];
    [vEqInfoView addSubview:lbName];
    [lbName setOpaque:NO];
    [lbName setAdjustsFontSizeToFitWidth:YES];
    [lbName setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [lbName setTextColor:[UIColor whiteColor]];
    [lbName setBackgroundColor:[UIColor clearColor]];
    
    lbEffect = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 18)];
    [vEqInfoView addSubview:lbEffect];
    [lbEffect setOpaque:NO];
    [lbEffect setAdjustsFontSizeToFitWidth:YES];
    [lbEffect setFont:[UIFont fontWithName:@"Helvetica" size:11.0f]];
    [lbEffect setTextColor:[UIColor yellowColor]];
    [lbEffect setBackgroundColor:[UIColor clearColor]];
    
    lbLongDesc = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 600, 20)];
    [lbLongDesc setOpaque:NO];
    [lbLongDesc setAdjustsFontSizeToFitWidth:YES];
    [lbLongDesc setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [lbLongDesc setTextColor:[UIColor whiteColor]];
    [lbLongDesc setBackgroundColor:[UIColor clearColor]];
    [vLongDescContainer addSubview:lbLongDesc];
    [vEqInfoView addSubview:vLongDescContainer];
    
    [vEqInfoView setBackgroundColor:[UIColor clearColor]];
    // add status view
//    [self addChildViewController:vcStatus];
//    [self.view addSubview:vcStatus.view];
    
    // init infoview for items
    vItemLongDescContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 18, 300, 30)];
    [vItemLongDescContainer setContentSize:CGSizeMake(500, 0)];
    [vItemLongDescContainer setBackgroundColor:[UIColor clearColor]];
    lbItemName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 18)];
    [vItemInfoView addSubview:lbItemName];
    [lbItemName setOpaque:NO];
    [lbItemName setAdjustsFontSizeToFitWidth:YES];
    [lbItemName setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [lbItemName setTextColor:[UIColor whiteColor]];
    [lbItemName setBackgroundColor:[UIColor clearColor]];
    
    lbItemEffect = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 18)];
    [vItemInfoView addSubview:lbItemEffect];
    [lbItemEffect setOpaque:NO];
    [lbItemEffect setAdjustsFontSizeToFitWidth:YES];
    [lbItemEffect setFont:[UIFont fontWithName:@"Helvetica" size:11.0f]];
    [lbItemEffect setTextColor:[UIColor yellowColor]];
    [lbItemEffect setBackgroundColor:[UIColor clearColor]];
    
    lbItemLongDesc = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 600, 20)];
    [lbItemLongDesc setOpaque:NO];
    [lbItemLongDesc setAdjustsFontSizeToFitWidth:YES];
    [lbItemLongDesc setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [lbItemLongDesc setTextColor:[UIColor whiteColor]];
    [lbItemLongDesc setBackgroundColor:[UIColor clearColor]];
    [vItemLongDescContainer addSubview:lbItemLongDesc];
    [vItemInfoView addSubview:vItemLongDescContainer];
    
    // set scrollview frame
    CGRect r_last = vItemBg.frame;
    UIScrollView* vv = ( UIScrollView* )self.view;
    int t = r_last.origin.y+r_last.size.height;
    NSLog(@"set content size to %d, %d", 320, t);
    vv.contentSize = CGSizeMake(0, t-480);
//    self.view.frame = CGRectMake(0,0,320,480);
}

- (void)viewDidUnload
{
    [self setVcStatus:nil];
    [self setVEquipment:nil];
    [self setVEq_cap:nil];
    [self setVEq_neck:nil];
    [self setVEq_handright:nil];
    [self setVEq_fingersRight:nil];
    [self setVEq_handleft:nil];
    [self setVEq_fingersleft:nil];
    [self setVEq_boots:nil];
    [self setVEq_trousers:nil];
    [self setVEq_armo:nil];
    [self setVEq_arm:nil];
    [self setVEqInfoView:nil];
    [self setVItemBg:nil];
    [self setVProfile:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) onLoadEq:(NSArray*) data{
    if (![data isKindOfClass:[NSArray class]])
        return;
//    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    [ad setBgImg:[UIImage imageNamed:@"background.PNG"] ];
    
    [vEqbtn_cap  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_neck  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_handright  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_arm  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_fingersRight  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_handleft  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_fingersleft  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_boots  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_trousers  setBackgroundColor:[UIColor clearColor]];
    [vEqbtn_armo  setBackgroundColor:[UIColor clearColor]];
    
    // reset
    NSArray* keys = [pos_map allKeys];
    for (int i = 0; i< [keys count]; i++){
        NSString* sk = [keys objectAtIndex:i];
        EGOImageButton* btn = [pos_map valueForKey:sk];
        btn.tag = 0;
        btn.imageURL = NULL;
        btn.backgroundColor = [UIColor clearColor];
    }
    worneq_selected = sloteq_selected = NULL;
    
    if (data == NULL || [data count]==0)
        return;
    [ad setDataUserEqs:data];
    
    int j = 0;
    int item_index = 0;
    // load equipment
//    [eq_buttons removeAllObjects];
    /* for (int i = 0; i< [data count]; i++){
        NSObject *o = [data objectAtIndex:i];
        NSObject* eq = [o valueForKey:@"usereq"];
        int slotNumber = [[eq valueForKey:@"eqslotnum"] intValue];
        int eqtype = [[eq valueForKey:@"eqtype"] intValue];
        
        NSString* filepath = [eq valueForKey:@"image"];
        if (filepath == NULL || filepath.length == 0)
            filepath = [NSString stringWithFormat:@"%@.png", [eq valueForKey:@"eqname"]];
        filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, filepath];
        NSLog(@"filepath=%@", filepath);
        
        if (eqtype == 1){
       if (slotNumber < 0 ){ //  equiped
            NSString* wearon = [o valueForKey:@"wearon"];
            if (wearon != NULL){
                if ([wearon isEqualToString:@"head"]){
                    [vEqbtn_cap setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_cap setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_cap setTag:1];
                    [woren_eq_list replaceObjectAtIndex:1 withObject:eq];
                }    else if ([wearon isEqualToString:@"neck"]){
                    [vEqbtn_neck setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_neck setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_neck setTag:2];
                    [woren_eq_list replaceObjectAtIndex:2 withObject:eq];
                }   else if ([wearon isEqualToString:@"hand righ"]){
                    [vEqbtn_handright setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_handright setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_handright setTag:3];
                    [woren_eq_list replaceObjectAtIndex:3 withObject:eq];
                }else if ([wearon isEqualToString:@"arm"]){
                    [vEqbtn_arm setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_arm setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_handright setTag:4];
                    [woren_eq_list replaceObjectAtIndex:4 withObject:eq];
                }else if ([wearon isEqualToString:@"fingers right"]){
                    [vEqbtn_fingersRight setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_fingersRight setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_fingersRight setTag:5];
                    [woren_eq_list replaceObjectAtIndex:5 withObject:eq];
                }    else  if ([wearon isEqualToString:@"hand left"]){
                    [vEqbtn_handleft setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_handleft setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_handleft setTag:6];
                    [woren_eq_list replaceObjectAtIndex:6 withObject:eq];
                }
                else if ([wearon isEqualToString:@"fingers left"]){
                    [vEqbtn_fingersleft setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_fingersleft setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_fingersleft setTag:7];
                    [woren_eq_list replaceObjectAtIndex:7 withObject:eq];
                } 
                else if ([wearon isEqualToString:@"foot"]){
                    [vEqbtn_boots setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_boots setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_boots setTag:8];
                    [woren_eq_list replaceObjectAtIndex:8 withObject:eq];
                } if ([wearon isEqualToString:@"leg"]){
                    [vEqbtn_trousers setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_trousers setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_trousers setTag:9];
                    [woren_eq_list replaceObjectAtIndex:9 withObject:eq];
                }  else if ([wearon isEqualToString:@"body"]){
                    [vEqbtn_armo setBackgroundColor:[UIColor yellowColor]];
                    [vEqbtn_armo setImageURL:[NSURL URLWithString: filepath]];
                    [vEqbtn_armo setTag:10];
                    [woren_eq_list replaceObjectAtIndex:10 withObject:eq];
                }   
            }
            continue;
        }
       
        // stocked equipments
        
        UIImageView* slot = [eq_slots objectAtIndex:slotNumber];
        EGOImageButton *v = [[slot subviews] objectAtIndex:0];
    
//        EGOImageButton *v = [[EGOImageButton alloc] initWithPlaceholderImage:[UIImage imageNamed:@"eq_slot.png"]];
//         v = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
 
//        NSArray * ar = [[NSArray alloc] initWithObjects:
//                        @"http://192.168.0.24:3006/images/p_1.jpg",
//                        @"http://192.168.0.24:3006/images/p_2.jpg",
//                        nil];
//        
//        srand(time(nil));
//        int i = rand()%2;
//        NSLog(@"rand %d", i);
//        [v setImageURL:[NSURL URLWithString:[ar objectAtIndex:i]]];
        [v setImageURL:[NSURL URLWithString: filepath]];
        [v  setBackgroundColor:[UIColor yellowColor]];
        [eq_list replaceObjectAtIndex:slotNumber+1 withObject:eq];
//        [v setTag:slotNumber];
//        [v setValue:eq forKey:@"wearon"];
      
        //    [v setHighlighted:YES];
//        [vEquipment addSubview:v];
//               [slot addSubview:v];
//        [eq_buttons addObject:v];
        }
        if (eqtype == 2){
          //  UIImageView* slot = [eq_slots objectAtIndex:slotNumber];
            EGOImageButton* btn = [item_buttons objectAtIndex:item_index];
            [btn setImageURL:filepath];
            item_index++;
        }
    }
     */
    
    // put ep on position
    NSString* prop = [[ad getDataUserext] valueForKey:@"prop"];
    NSObject* js = [prop JSONValue];
    NSMutableArray* arranged = [[NSMutableArray alloc] init];
    NSObject* es = [js valueForKey:@"eqslot"];
    NSObject* eqslot = es;
    if ([es isKindOfClass:[NSString class]])
        eqslot = [(NSString*)es JSONValue];

    if (eqslot){
//        NSObject* epslot = [sepslot JSONValue];
        int epid = -1;
        NSArray* keys = [pos_map allKeys];
        for (int i = 0; i< [keys count]; i++) {
     
            NSString* pos = [keys objectAtIndex:i];
            epid = [[eqslot valueForKey:pos] intValue];
            if (epid <=0)
                continue;
            EGOImageButton* btn = [pos_map valueForKey:pos];
            int index = [self findEpById:epid];
            if (index >=0){
                [arranged addObject:[NSNumber numberWithInt:index]];
                NSObject *o = [data objectAtIndex:index];
                NSObject* eq = [o valueForKey:@"usereq"];
//                int slotNumber = [[eq valueForKey:@"eqslotnum"] intValue];
                int eqtype = [[eq valueForKey:@"eqtype"] intValue];
                
                NSString* filepath = [eq valueForKey:@"image"];
                if (filepath == NULL || filepath.length == 0)
                    filepath = [NSString stringWithFormat:@"%@.png", [eq valueForKey:@"eqname"]];
                filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, filepath];
                NSLog(@"filepath=%@", filepath);
                [btn setImageURL:[NSURL URLWithString: filepath]];
                [btn setTag:epid];
                [btn setBackgroundColor:[UIColor yellowColor]];
          
            }
        }
    }
     NSLog(@"DATA count %d", [data count]);
    // proceed remaining item and eq
    for ( int i = 0; i< [data count]; i++){
        
        NSLog(@"DATA %d", i);
        // check if it's already arranged
        BOOL found = FALSE;
       
        NSLog(@"arranged count %d", [arranged count]);
        for (int j=0; j < [arranged count]; j++){
            if (i == [[arranged objectAtIndex:j] intValue]) {
                found = TRUE;
                break;
            }
        }
        if (found)
             continue;
        NSLog(@"DATA %d not found in arraged", i);
        NSObject *o = [data objectAtIndex:i];
             NSLog(@"DATA %d %@", i, o);
        NSObject* eq = [o valueForKey:@"usereq"];
        int eqtype = [[eq valueForKey:@"eqtype"] intValue];
        int eqid = [[eq valueForKey:@"id"] intValue];
        
        NSString* filepath = [eq valueForKey:@"image"];
        if (filepath == NULL || filepath.length == 0)
            filepath = [NSString stringWithFormat:@"%@.png", [eq valueForKey:@"eqname"]];
        filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, filepath];
       
        
        if (eqtype == 1){ //eq
            // found vacancy
            NSArray* keys = [pos_map allKeys];
            int i2 = 0;
            EGOImageButton* btn2 = NULL; 
            for ( ;i2< [keys count]; i2++) {
                NSString* str = [keys objectAtIndex:i2];
                int inte = [str characterAtIndex:0];
              
                if (inte <48 || inte >57)
                    continue;
                btn2 = [pos_map valueForKey:str];
                if (btn2.tag == 0)
                    break;
            }
            if (i2 < [keys count]){
                btn2.tag = eqid;
                 NSLog(@"filepath=%@, btn=%@", filepath, btn2);
                [btn2 setImageURL:[NSURL URLWithString:filepath]];
//                btn2.backgroundColor = [UIColor yellowColor];
//                [btn2 setTitle:filepath forState:UIControlStateNormal];
            }
            

        }
        
        if (eqtype == 2){ // item
            //  UIImageView* slot = [eq_slots objectAtIndex:slotNumber];
            NSLog(@"item_buttons count %d, index %d", [item_buttons count], item_index);
            if (item_index < [item_buttons count]) {// has room for item ?
                EGOImageButton* btn = [item_buttons objectAtIndex:item_index];
                [btn setImageURL:[NSURL URLWithString:filepath]];
                btn.tag = eqid;
                item_index++;
            }
        }
        
    }
    lbWeight.text = [NSString stringWithFormat:@"%d" ,[self calcWeight]];
    lbDamage.text = [NSString stringWithFormat:@"%d" ,[self calcAttack]];
    lbDeffencce.text = [NSString stringWithFormat:@"%d" ,[self calcDefense]];
}

- (int) findEpById:(int)epid{
    if (epid <=0)
        return -1;
    NSArray* data = [ad getDataUserEqs];
    for (int i = 0; i< [data count]; i++){
        NSObject *o = [data objectAtIndex:i];
        NSObject* eq = [o valueForKey:@"usereq"];
        int slotNumber = [[eq valueForKey:@"eqslotnum"] intValue];
        int eqtype = [[eq valueForKey:@"eqtype"] intValue];
        int _epid = [[eq valueForKey:@"id"] intValue];
        if (_epid == epid)
            return i;
    }
    return -1;
}

- (IBAction)onSave:(id)sender {
    NSArray* eqs = [ad getDataUserEqs];
    NSDictionary* data = [[NSMutableDictionary alloc] init ];
    NSArray* keys = [pos_map allKeys];
    for (int i = 0; i< [keys count]; i++) {
        NSString* pos = [keys objectAtIndex:i];
        UIButton* btn = [pos_map valueForKey:pos];
        int index = [self findEpById:btn.tag];
        if (index < 0)
            continue;
        NSObject* o = [[eqs objectAtIndex:index] valueForKey:@"usereq"];
        NSObject* eqid = [o valueForKey:@"id"];
        [data setValue:eqid forKey:pos];
    }
    /*
    NSObject* o = [woren_eq_list objectAtIndex:vEqbtn_cap.tag];
    NSObject* eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"head"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_neck.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"neck"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_handright.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"handright"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_arm.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"arm"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_fingersRight.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"fingerright"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_handleft.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"handleft"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_fingersleft.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"fingerleft"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_boots.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"foot"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_trousers.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"leg"];
    
    o =  [woren_eq_list objectAtIndex:vEqbtn_armo.tag];
    eqid = [o valueForKey:@"id"];
    [data setValue:eqid forKey:@"body"];
   
    NSDictionary* ext = [ad getDataUserext];
    int max_eq = [[ext valueForKey:@"max_eq"] intValue];
    for ( int i = 0; i<max_eq; i++){
        EGOImageButton* btn = [eq_buttons objectAtIndex:i];
        NSObject* o =  [eq_list objectAtIndex:btn.tag];
        NSObject* eqid = [o valueForKey:@"id"];
        [data setValue:eqid forKey:[[NSNumber numberWithInt:i] stringValue]];
    } 
    */
    
    NSString * s = [NSString stringWithFormat:@"data=%@", [data JSONRepresentation]];
    NSLog(@"Post data %@", s);
    
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client postHttpRequest:@"/usereqs/save" data:s selector:@selector(onSaveEq:) json:YES showWaiting:YES];


    
}
- (void) onSaveEq:(NSObject*) data{
    if ([data valueForKey:@"error"]){
        [ad showMsg:[data valueForKey:@"error"] type:1 hasCloseButton:YES];
        return;
    }
    [ad setDataUserExt:data];
    [ad saveDataUser];
    
}


- (void) viewDidAppear:(BOOL)animated{
    NSObject* ext = [ad getDataUserext];
    lbDext.text = [[ext valueForKey:@"dext"] stringValue];
    lbStrength.text = [[ext valueForKey:@"str"] stringValue];
    lbIntellegence.text = [[ext valueForKey:@"it"] stringValue];
    
}
-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"character view update");
    

    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/usereqs" selector:@selector(onLoadEq:) json:YES showWaiting:YES];
}

- (void) highlightButton:(UIButton*)btn{
//    [btn drawRect:CGRectMake(0, 0, 50, 50)];
//    [btn setSelected:YES];
//    [btn setHighlighted:YES];
     [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    
    if (sloteq_selected != btn){
        [sloteq_selected setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        sloteq_selected = btn;
    }
//    for (int i= 0; i < [eq_buttons count]; i++){
//        UIButton* b = [eq_buttons objectAtIndex:i];
//        if (b && b!= btn){
//            [b setSelected:FALSE];
//            [b setHighlighted:NO];
//             [b setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
//        }
//    }
//    EGOImageButton* _btn = btn;
//    if (_btn.imageURL != NULL) {
//        sloteq_selected = btn;
//    }
}


// when user click equipment slot
- (void) selectEq:(UIButton*)btn{
   
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    NSArray* eqs = [ad getDataUserEqs];
    EGOImageButton* _btn = btn; 
    if (worneq_selected != NULL){ // put equipment on position
        if (_btn.imageURL == NULL){
            // exchange equipment (set eqslotnum and wearon)
            NSURL * url = worneq_selected.imageURL;
           
            
            [worneq_selected setImageURL:NULL];
            [_btn setImageURL:url];
            
    //        if (worneq_selected.imageURL == NULL){
                [worneq_selected setBackgroundColor:[UIColor clearColor]];
    //        }else
    //            [worneq_selected setBackgroundColor:[UIColor yellowColor]];
    //        if (_btn.imageURL == NULL){
                [_btn setBackgroundColor:[UIColor clearColor]];
              
            _btn.tag = worneq_selected.tag;
              worneq_selected.tag = 0;
    //        }else
    //            [_btn setBackgroundColor:[UIColor yellowColor]];
//            NSLog(@"worneq_selected.tag=%d)", worneq_selected.tag);
//            NSObject* eq = [woren_eq_list objectAtIndex:worneq_selected.tag];
//            NSObject* eq = [eqs indexOfObject:[self findEpById:worneq_selected.tag]];
//            [eq_list replaceObjectAtIndex:btn.tag withObject:eq];
//            NSLog(@"eq_list %d = eq(%@)", btn.tag, eq);
//            [woren_eq_list replaceObjectAtIndex:worneq_selected.tag withObject:[NSNull null]];

        }else{
            NSString* pos = [pos_list objectAtIndex:worneq_selected.superview.tag];
            NSLog(@"worneq_selected.superview.tag=%d", worneq_selected.superview.tag);
//            NSObject* eq = [eq_list objectAtIndex:btn.tag];
            NSObject* eq = [[eqs objectAtIndex:[self findEpById:btn.tag]]  valueForKey:@"usereq"];
//            NSLog(@"eq=%@", eq);
            NSString* wearon = [eq valueForKey:@"pos"];
            
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF contains %@", wearon]; 
            
            NSLog(@"TEST %@ with %@", wearon, pos);
            
            if ([test evaluateWithObject:pos]){ 
                // exchange image
                NSURL * url = worneq_selected.imageURL;
                NSURL  * url2 = _btn.imageURL;
                [worneq_selected setImageURL:url2];
                [_btn setImageURL:url];
                int t = worneq_selected.tag;
                worneq_selected.tag = _btn.tag;
                _btn.tag = t;
//                NSObject* eq2 = [woren_eq_list objectAtIndex:worneq_selected.tag];
//                [woren_eq_list replaceObjectAtIndex:worneq_selected.tag withObject:eq];
//                [eq_list replaceObjectAtIndex:btn.tag withObject:eq2];
            }else{
                [ad showMsg:@"You cannot wear it on this position" type:1 hasCloseButton:YES];
            }
        }
  
        worneq_selected = NULL;
        sloteq_selected = NULL;
        
        lbWeight.text = [NSString stringWithFormat:@"%d" ,[self calcWeight]];
        lbDamage.text = [NSString stringWithFormat:@"%d" ,[self calcAttack]];
        lbDeffencce.text = [NSString stringWithFormat:@"%d" ,[self calcDefense]];
    }else{ // do not need put object on position
         if (_btn.imageURL != NULL)
             [_btn setBackgroundColor:[UIColor yellowColor]];
        [self performSelector:@selector(highlightButton:) withObject:btn afterDelay:0.0];
        // show info
//        NSArray * subviewsArr = [vEqInfoView subviews];
//        for(UIView *v in subviewsArr )
//        {
//            [v removeFromSuperview];
//        }
//        NSDictionary* eq = [eq_list objectAtIndex:btn.tag];
        if (btn.tag != 0){
            NSDictionary* eq = [[eqs objectAtIndex:[self findEpById:btn.tag]] valueForKey:@"usereq"];
            NSString *str = [NSString stringWithFormat:@"%@", [eq valueForKey:@"dname"]];
            [lbName setText:str];
            CGSize size = [str sizeWithFont:lbName.font];
            lbName.frame = CGRectMake(0, 0, size.width, 18);
            lbEffect.frame = CGRectMake(size.width+5, 0, 100, 18);
            [lbEffect setText:[NSString stringWithFormat:@"%@", [eq valueForKey:@"effect"]]];
            [lbLongDesc setText:[[NSString alloc] initWithFormat:@"%@", [eq valueForKey:@"desc"]]];
            [vLongDescContainer scrollRectToVisible:CGRectMake(0, 0, 2, 2) animated:NO];
        }
    }
    
    
}

- (void) highlightButton2:(UIButton*)btn{
    [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    if (worneq_selected && worneq_selected != btn)
        [worneq_selected setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    EGOImageButton* _btn = (EGOImageButton*)btn;
    if (_btn.imageURL)
        worneq_selected = btn;
    else
        worneq_selected = NULL;
}

- (void) selectWorenEq:(UIButton*) btn{
    NSArray* eqs = [ad getDataUserEqs];
    EGOImageButton* _btn = btn;
    if (sloteq_selected != NULL && sloteq_selected.imageURL != NULL){
//        id a = [NSNumber numberWithInt:btn.superview.tag] intValue];
//        NSString* pos = a;
//       
//        
//
//        id b =[NSNumber numberWithInt:sloteq_selected.tag];
//         NSObject* eq = b;

        
        NSString* pos = [pos_list objectAtIndex:btn.superview.tag];
        NSLog(@"sloteq_selected.tag=%d", sloteq_selected.tag);
//        NSObject* eq = [eq_list objectAtIndex:sloteq_selected.tag];
        NSObject* eq = [[eqs objectAtIndex:[self findEpById:sloteq_selected.tag]] valueForKey:@"usereq"];
        NSLog(@"eq=%@", eq);
        NSString* wearon = [eq valueForKey:@"pos"];
        
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", wearon]; 
        
        NSLog(@"TEST %@ with %@", wearon, pos);
        
        if ([test evaluateWithObject:pos]){ 
            
        
        // exchange equipment (set eqslotnum and wearon)
        NSURL * url = sloteq_selected.imageURL;
        
        NSURL  * url2 = _btn.imageURL;
        [sloteq_selected setImageURL:url2];
        [_btn setImageURL:url];
        
//        if (sloteq_selected.imageURL == NULL){
            [sloteq_selected setBackgroundColor:[UIColor clearColor]];
//        }else
//            [sloteq_selected setBackgroundColor:[UIColor yellowColor]];
//        
//        if (_btn.imageURL == NULL){
            [_btn setBackgroundColor:[UIColor clearColor]];
//        }else
//            [_btn setBackgroundColor:[UIColor yellowColor]];
            
//        [eq_list replaceObjectAtIndex:sloteq_selected.tag withObject:[NSNull null]];
//        [woren_eq_list replaceObjectAtIndex:btn.tag withObject:eq];
//            NSLog(@"worneq_selected=%@", btn);
//            NSLog(@"woren_eqlist[%d]=eq%@", btn.tag, eq);
        int t = sloteq_selected.tag;
        sloteq_selected.tag = _btn.tag;
        _btn.tag = t;
        worneq_selected = NULL;
        sloteq_selected = NULL;
        }else{
            [ad showMsg:@"You cannot wear it on this position" type:1 hasCloseButton:YES];
            worneq_selected = NULL;
//            sloteq_selected = NULL;
        }
        
        lbWeight.text = [NSString stringWithFormat:@"%d" ,[self calcWeight]];
        lbDamage.text = [NSString stringWithFormat:@"%d" ,[self calcAttack]];
        lbDeffencce.text = [NSString stringWithFormat:@"%d" ,[self calcDefense]];
    }else{
        if (_btn.imageURL != NULL)
          [_btn setBackgroundColor:[UIColor yellowColor]];
        if (_btn != worneq_selected)
            [self performSelector:@selector(highlightButton2:) withObject:btn afterDelay:0.0];
//        else
//            worneq_selected = NULL;
        if (btn.tag != 0){
            NSDictionary* eq = [[eqs objectAtIndex:[self findEpById:btn.tag]] valueForKey:@"usereq"];
            
            NSString *str = [NSString stringWithFormat:@"%@", [eq valueForKey:@"dname"]];
            [lbName setText:str];
            CGSize size = [str sizeWithFont:lbName.font];
            lbName.frame = CGRectMake(0, 0, size.width, 18);
            lbEffect.frame = CGRectMake(size.width+5, 0, 100, 18);
            [lbEffect setText:[NSString stringWithFormat:@"%@", [eq valueForKey:@"effect"]]];
           
            
            [lbLongDesc setText:[[NSString alloc] initWithFormat:@"%@", [eq valueForKey:@"desc"]]];
            [vLongDescContainer scrollRectToVisible:CGRectMake(0, 0, 2, 2) animated:NO];
        }

    }
    
}

- (void) selectItem:(UIButton*)btn{
      NSArray* eqs = [ad getDataUserEqs];
    
    if (btn.tag != 0){
        NSDictionary* eq = [[eqs objectAtIndex:[self findEpById:btn.tag]] valueForKey:@"usereq"];
        
        NSString *str = [NSString stringWithFormat:@"%@", [eq valueForKey:@"dname"]];
        [lbItemName setText:str];
        CGSize size = [str sizeWithFont:lbName.font];
        lbItemName.frame = CGRectMake(0, 0, size.width, 18);
        NSString* effect = [eq valueForKey:@"effect"];
        if (effect)
            [lbItemEffect setText:[NSString stringWithFormat:@"%@", effect]];
        
        
        [lbItemLongDesc setText:[[NSString alloc] initWithFormat:@"%@", [eq valueForKey:@"desc"]]];
        [vItemLongDescContainer scrollRectToVisible:CGRectMake(0, 0, 2, 2) animated:NO];
        CGRect r = btn.superview.frame;
        r.origin.x += 60;
    //    [vItemContainer scrollRectToVisible:btn.superview.frame animated:YES];
    }
}

@end
