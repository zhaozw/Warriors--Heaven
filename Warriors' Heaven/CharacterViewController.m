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
#import "LightView.h"

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
@synthesize lbStatus;
@synthesize vcObjDetail;
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
@synthesize btItemDetail;
@synthesize btEqDetail;


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
        NSObject* o = [eqs objectAtIndex:index];
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
        NSObject* o = [eqs objectAtIndex:index] ;
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
        NSObject* o = [eqs objectAtIndex:index] ;
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
    createLabel(CGRectMake(margin_left+0, margin_top+0, 30, height), vProp, @"力", tColor);
    lbStrength = createLabel(CGRectMake(margin_left+40, margin_top+0, 30, height), vProp, @"0", NULL);
    
    createLabel(CGRectMake(margin_left+110, margin_top+0, 30, height), vProp, @"敏捷", tColor);
    lbDext = createLabel(CGRectMake(margin_left+150, margin_top+0, 30, height), vProp, @"0", NULL);
    
    createLabel(CGRectMake(margin_left+220, margin_top+0, 30, height), vProp, @"悟性", tColor);
    lbIntellegence = createLabel(CGRectMake(margin_left+260, margin_top+0, 30, height), vProp, @"0", NULL);
    
    createLabel(CGRectMake(margin_left+0, margin_top+row_margin*1+20, 30, height), vProp, @"負荷", tColor);
    lbWeight = createLabel(CGRectMake(margin_left+40, margin_top+row_margin*1+20, 30, height), vProp, @"0", NULL);
    
    createLabel(CGRectMake(margin_left+110, margin_top+row_margin*1+20, 40, height), vProp, @"ダメージ", tColor);
    lbDamage = createLabel(CGRectMake(margin_left+150, margin_top+row_margin*1+20, 30, height), vProp, @"0", NULL);
    
    
    createLabel(CGRectMake(margin_left+220, margin_top+row_margin*1+20, 30, 18), vProp, @"防御", tColor);
    lbDeffencce = createLabel(CGRectMake(margin_left+260, margin_top+row_margin*1+20, 30, height), vProp, @"0", NULL);
}

- (void) reloadEqUI{
//    [LightView removeAllSubview:vEqContainer];
//    [LightView removeAllSubview:vItemContainer];
    for (int i = 0; i< [eq_slots count]; i++){
        UIView* uiv = [eq_slots objectAtIndex:i];
        [uiv removeFromSuperview];
    }
    for (int i = 0; i< [item_slots count]; i++){
        UIView* uiv = [item_slots objectAtIndex:i];
        [uiv removeFromSuperview];
    }
    NSDictionary* ext = [ad getDataUserext];
    int max_eq = [[ad getDataUserextProp:@"max_eq"] intValue];
    NSLog(@"ROOT2:%@", [ad getDataUser]);
    int row_count = 0;
    if (max_eq <= 0 ){
        row_count = 1;
        max_eq = 5;
    }
    else
        row_count = (max_eq-1)/5 + 1;
    CGRect rect = vEquipment.frame;
    vEqContainer.frame = CGRectMake(10, 10, rect.size.width -20, 60*2);
    vEqContainer.contentSize = CGSizeMake(0, 60*row_count);
   
    
   

    int max_item = [[ad getDataUserextProp:@"max_item"] intValue];
    int item_row_count = 0;
    if (max_item <= 0 ){
        item_row_count = 1;
        max_item = 5;
    }
    else
        item_row_count = (max_item-1)/5 + 1;
    item_row_count = 1;
    vItemBg.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height, rect.size.width, 20+item_row_count*60+50);
    vItemContainer.frame = CGRectMake(10, 10, rect.size.width -20,item_row_count*60);
    //    vItemContainer.backgroundColor = [UIColor redColor];
    vItemContainer.contentSize = CGSizeMake(60*max_item, 0);

    
    
    
    
    eq_buttons = [[NSMutableArray alloc] initWithCapacity:max_eq];
    eq_slots = [[NSMutableArray alloc] initWithCapacity:max_eq];
    item_slots = [[NSMutableArray alloc] initWithCapacity:max_item];
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
    
    //    eq_list = [[NSMutableArray alloc] initWithCapacity:max_eq+1];
    //    [eq_list addObject:[NSNull null]];
    for (int i = 0; i< max_eq; i++){
        UIImageView* slot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eqslot.png"]];
        slot.frame = CGRectMake(i%5*60, i/5*60, 60, 60);
        [slot setUserInteractionEnabled:YES];
        [vEqContainer addSubview:slot];
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
        [item_slots addObject:slot];
        [slot setTag:i+1];
        
        EGOImageButton *v = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        //        [eq_buttons addObject:v];
        //        [v setTag:i+1];
        [v addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        //        [v setTintColor:[UIColor redColor]];
        [item_buttons addObject:v];
        //        [v setBackgroundColor:[UIColor yellowColor]];
        [slot addSubview:v];
        [item_list addObject:[NSNull null]];
    }
    
    
    //int offset = 60*max_item -vItemContainer.frame.size.width;
    //  if (offset > 0)
   
    [vItemContainer scrollRectToVisible:CGRectMake(400, 0, 10, 10) animated:YES];
    
    // set scrollview frame
    CGRect r_last = vItemBg.frame;
    UIScrollView* vv = ( UIScrollView* )self.view;
    int t = r_last.origin.y+r_last.size.height;
    NSLog(@"set content size to %d, %d", 320, t);
    vv.contentSize = CGSizeMake(0, t-480);
    //    self.view.frame = CGRectMake(0,0,320,480);
    
    

}

- (void) initUI{
    item_selected = NULL;
    [self initPropView];
    
//    NSString* prof = [NSString stringWithFormat:@"p_%@b.png", [[ad getDataUser] valueForKey:@"profile"]];
//    [vProfile setImage:[UIImage imageNamed:prof]];
    // set player profile
    id prof = [[ad getDataUser] valueForKey:@"profile"];
    int iProf = 0;
    if (prof != NULL && prof != [NSNull null] )
        iProf = [prof intValue];
    
    if (iProf > 5){
        NSString* sProf = [NSString stringWithFormat:@"http://%@:%@/game/profile/p_%db.png", ad.host, ad.port, iProf];
        [vProfile setImageURL:[NSURL URLWithString:sProf]];
    }else{
        NSString* sProf = [NSString stringWithFormat:@"p_%db.png", iProf];
        
        [vProfile setImage:[UIImage imageNamed:sProf]];
    }
    

    
    UIImage *imageNormal = [UIImage imageNamed:@"bg_12.png"];
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    [vEquipment setImage:stretchableImageNormal];
    [vEquipment addSubview:vEqInfoView];
     [vEqInfoView setBackgroundColor:[UIColor clearColor]];
     vEqInfoView.frame = CGRectMake(10, 10+60*2, 300, 80);
    
    vItemInfoView = [[UIView alloc] init];
    vItemInfoView.frame = CGRectMake(10, 10+60, 300, 80);
    [vItemInfoView setBackgroundColor:[UIColor clearColor]];
    [vItemBg addSubview:vItemInfoView];
    vItemContainer = [[UIScrollView alloc] init];
    vItemContainer.opaque = NO;
    [vItemContainer setScrollEnabled:YES];
    [vItemBg addSubview:vItemContainer];
    vEqContainer = [[UIScrollView alloc] init];
    vEqContainer.opaque = NO;
    [vEqContainer setScrollEnabled:YES];
    [vEquipment addSubview:vEqContainer];
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
    
    
    
    
    
    // initialize position
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
    [pos_map  setValue:vEqbtn_fingersRight forKey:@"fingerright"];
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
    
    lbEffect = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 18)];
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
    
    btEqDetail = [LightView createButton:CGRectMake(250, 0, 60, 25) parent:vEqInfoView text:@"Detail" tag:0];
    btEqDetail.hidden = YES;
    [btEqDetail addTarget:self action:@selector(onEqDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    lbItemEffect = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 18)];
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
    
    //    btItemDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btItemDetail.frame = CGRectMake(250, 0, 60, 25);
    //    [vItemInfoView addSubview:btItemDetail];
    //    [btItemDetail setOpaque:NO];
    //    [btItemDetail.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    //    [btItemDetail.titleLabel setTextColor:[UIColor whiteColor]];
    //    [btItemDetail setBackgroundColor:[UIColor clearColor]];
    //    [btItemDetail setBackgroundImage:@"btn_tab_light.png" forState:UIControlStateNormal];
    //    [btItemDetail setTitle:@"Detail" forState:UIControlStateNormal];
    btItemDetail = [LightView createButton:CGRectMake(250, 0, 60, 25) parent:vItemInfoView text:@"Detail" tag:0];
    [btItemDetail addTarget:self action:@selector(onItemDetail:) forControlEvents:UIControlEventTouchUpInside];
    btItemDetail.hidden = YES;
    
    

//    [self addChildViewController:vcObjDetail];
    [ad.window addSubview:[vcObjDetail view]];
    [vcObjDetail hideDetailView];
    [vcObjDetail setViewType:@"sell"];
    [vcObjDetail setOnTrade:self sel:@selector(onSell1:)];
    [vcObjDetail setOnUse:self sel:@selector(onUse:)];
    vcObjDetail.view.frame=CGRectMake(0, 60, 320, 420);

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ad = [UIApplication sharedApplication].delegate;
    [self initUI];

}

- (void) onEqDetail:(UIButton*) btn{
    NSArray* eqs = [ad getDataUserEqs];
    NSObject* o = [eqs objectAtIndex:[self findEpById:btn.tag]];
    [vcObjDetail loadObjDetail:o];
    itemOnDetail = btn.tag;
    [[self view] bringSubviewToFront: [vcObjDetail view]];
}
- (void) onUseReturn:(NSObject*)data{
    [ad showMsg:[data valueForKey:@"OK"] type:0 hasCloseButton:YES]; 
    NSObject* ext  = [data valueForKey:@"userext"];
    if (ext)
        [ad setDataUserExt:ext];
    int index = [[data valueForKey:@"id"] intValue];
    NSMutableArray* eqs = [ad getDataUserEqs];
    NSObject* o = [eqs objectAtIndex:[self findEpById:index]];
    [eqs removeObject:o];
    [vcObjDetail hideDetailView];
    [ad reloadStatus];
//    [self reloadEq];
    [self viewWillAppear:NO];
}
- (void) onSellReturn:(NSObject* )data{
    NSObject* error = [data valueForKey:@"error"];
    if (error){
        [ad showMsg:error type:1 hasCloseButton:YES];
        id usereqs = [data valueForKey:@"usereqs"];
        if (usereqs){
            [ad setDataUserEqs:usereqs];
            [self reloadEq];
        }
            
        return;
    }
    
    int index = [[data valueForKey:@"id"] intValue];
    NSMutableArray* eqs = [ad getDataUserEqs];
    NSObject* o = [eqs objectAtIndex:[self findEpById:index]];
    [eqs removeObject:o];
    
    [vcObjDetail hideDetailView];
    
    int gold = [[data valueForKey:@"gold"] intValue];
    [[ad getDataUserext] setValue:[NSNumber numberWithInt:gold]  forKey:@"gold"];
    [ad reloadStatus];
    [self reloadEq];
    [ad showMsg:[data valueForKey:@"msg"] type:0 hasCloseButton:FALSE];
    
    item_selected = NULL;
    
    btItemDetail.hidden = YES;
    btEqDetail.hidden = YES;
    
    
    
}


- (void) onItemDetail:(UIButton*) btn{
    if (btn.tag == 0)
        return;
    NSArray* eqs = [ad getDataUserEqs];
    NSObject* eq = [eqs objectAtIndex:[self findEpById:btn.tag]];
    if (!eq)
        return;
    itemOnDetail = btn.tag;
//    NSObject* o = [eq valueForKey:@"equipment"];
    [vcObjDetail loadObjDetail:eq];
//    CGRect r =  vcObjDetail.view.frame;
//    UIScrollView* v = (UIScrollView* )self.view;
//    r.origin.y = v.contentOffset.y+60;
//    vcObjDetail.view.frame = r;
    [[self view] bringSubviewToFront: [vcObjDetail view]];
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
    [self setVcObjDetail:nil];
    [self setLbStatus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) reloadEq{
    
    NSArray* data = [ ad getDataUserEqs];
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
    int j = 0;
    int item_index = 0;
    
    
    for (int i = 0; i< [item_buttons count];i++){
        EGOImageButton* btn = [item_buttons objectAtIndex:i];
        
        btn.imageURL = NULL;
        btn.tag = 0;
        btn.backgroundColor = [UIColor clearColor];
    }
    
    // load equipment

    
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
            NSString* v = [eqslot valueForKey:pos];
            if ([v isKindOfClass:[NSString class]]){
                NSArray *vs =[v componentsSeparatedByString:@"@"];
                 epid = [[vs objectAtIndex:1] intValue];
            }else
                 epid = [v intValue];
           
            if (epid <=0)
                continue;
            EGOImageButton* btn = [pos_map valueForKey:pos];
            int index = [self findEpById:epid];
            if (index >=0){
                [arranged addObject:[NSNumber numberWithInt:index]];
                NSObject *o = [data objectAtIndex:index];
//                NSObject* eq = [o valueForKey:@"equipment"];
                NSObject* eq = o;
                //                int slotNumber = [[eq valueForKey:@"eqslotnum"] intValue];
                int eqtype = [[eq valueForKey:@"eqtype"] intValue];
                
                NSString* filepath = [eq valueForKey:@"image"];
                if (filepath == NULL || filepath.length == 0)
                    filepath = [NSString stringWithFormat:@"%@.png", [eq valueForKey:@"eqname"]];
                filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, filepath];
                NSLog(@"filepath=%@", filepath);
                [btn setImageURL:[NSURL URLWithString: filepath]];
                [btn setTag:epid];
//                [btn setBackgroundColor:[UIColor yellowColor]];
                
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
//        NSObject* eq = [o valueForKey:@"equipment"];
        NSObject* eq = o;
        int eqtype = [[eq valueForKey:@"eqtype"] intValue];
        int eqid = [[eq valueForKey:@"id"] intValue];
        
        NSString* filepath = [eq valueForKey:@"image"];
        if (filepath == NULL || filepath.length == 0)
            filepath = [NSString stringWithFormat:@"%@.png", [eq valueForKey:@"eqname"]];
        filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, filepath];
        
        
//        if (eqtype == 1){ //eq
//            if (i == 34){
//                i = 34;
//            }
//        }
        if (eqtype == 1 || eqtype == 3){ //eq
      
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
        
        if (eqtype == 2 || eqtype==4){ // item
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
    
    // reset info view
    [lbName setText:@""];
    [lbEffect setText:@""];
    [lbLongDesc setText:@""];
    btEqDetail.tag = 0;
    btEqDetail.hidden = YES;
    
    [lbItemName setText:@""];
    [lbItemEffect setText:@""];
    [lbItemLongDesc setText:@""];
    btItemDetail.tag = 0;
    btItemDetail.hidden = YES;
}

- (void) onLoadEq:(NSArray*) data{
    if (![data isKindOfClass:[NSArray class]])
        return;
//    AppDelegate * ad = [UIApplication sharedApplication].delegate;
//    [ad setBgImg:[UIImage imageNamed:@"background.PNG"] ];

    
    if (data == NULL || [data count]==0)
        return;
    [ad setDataUserEqs:data];
    
    [self reloadEq];
}

- (id) findObjById:(int)eqid{

    if (eqid <=0)
        return NULL;
    NSArray* data = [ad getDataUserEqs];
    for (int i = 0; i< [data count]; i++){
        NSObject *o = [data objectAtIndex:i];
//        NSObject* eq = [o valueForKey:@"equipment"];
        NSObject* eq = o;
        int _eqid = [[eq valueForKey:@"id"] intValue];
        if (_eqid == eqid)
            return eq;
    }

    return NULL;
}
- (int) findEpById:(int)epid{
    if (epid <=0)
        return -1;
    NSArray* data = [ad getDataUserEqs];
    for (int i = 0; i< [data count]; i++){
        NSObject *o = [data objectAtIndex:i];
//        NSObject* eq = [o valueForKey:@"equipment"];
        NSObject* eq = o;
//        int slotNumber = [[eq valueForKey:@"eqslotnum"] intValue];
//        int eqtype = [[eq valueForKey:@"eqtype"] intValue];
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
        NSObject* o = [eqs objectAtIndex:index];
        int eqid = [[o valueForKey:@"id"] intValue];
        NSString* v = [NSString stringWithFormat:@"%@@%d", [o valueForKey:@"eqname"], eqid];
        [data setValue:v forKey:pos];
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
    [client postHttpRequest:@"/usereqs/save" data:s selector:@selector(onSaveReturn:) json:YES showWaiting:YES];


    
}
- (void) onSaveReturn:(NSObject*) data{
    if ([data valueForKey:@"error"]){
        [ad showMsg:[data valueForKey:@"error"] type:1 hasCloseButton:YES];
        return;
    }
    [ad showMsg:[data valueForKey:@"OK"] type:0 hasCloseButton:NO];
    id ext = [data valueForKey:@"userext"];
    if (ext)
    {
        [ad setDataUserExt:ext];
        [ad saveDataUser];
    }
    
}


- (void) viewDidAppear:(BOOL)animated{
    NSObject* ext = [ad getDataUserext];
    lbDext.text = [[ext valueForKey:@"dext"] stringValue];
    lbStrength.text = [[ext valueForKey:@"str"] stringValue];
    lbIntellegence.text = [[ext valueForKey:@"it"] stringValue];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [ad showStatusView:YES];
    NSLog(@"character view update");
    [self reloadEqUI];
    [ad setBgImg:[UIImage imageNamed:@"bg8.jpg"] ];
    NSString* status = [[ad getDataUserext] valueForKey:@"sstatus"];
    if (status != NULL && status != nil && status !=[NSNull null])
        [self setStatus:status];
    else
        [self setStatus:@""];
    if (ad.bUserEqNeedUpdated) {
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        [client sendHttpRequest:@"/usereqs" selector:@selector(onLoadEq:) json:YES showWaiting:YES];
    }else{
        [self reloadEq];
    }
}

- (void) highlightButton:(UIButton*)btn{
//    [btn drawRect:CGRectMake(0, 0, 50, 50)];
//    [btn setSelected:YES];
//    [btn setHighlighted:YES];
     [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    
    if (sloteq_selected != btn){
        if (sloteq_selected){
            [sloteq_selected setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
            [sloteq_selected setBackgroundColor:[UIColor clearColor]];
        }
     
//        sloteq_selected = btn;
    }
    
    
//    for (int i= 0; i < [eq_buttons count]; i++){
//        UIButton* b = [eq_buttons objectAtIndex:i];
//        if (b && b!= btn){
//            [b setSelected:FALSE];
//            [b setHighlighted:NO];
//             [b setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
//        }
//    }
    EGOImageButton* _btn = btn;
    if (_btn.imageURL != NULL) {
        [btn setBackgroundColor:[UIColor yellowColor]];
        sloteq_selected = btn;
    }
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
            NSObject* eq = [eqs objectAtIndex:[self findEpById:btn.tag]] ;
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
//                [ad showMsg:@"You cannot wear it on this position" type:1 hasCloseButton:YES];
                [ad showMsg:@"この装備はここで使えない" type:1 hasCloseButton:YES];

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
            NSDictionary* eq = [eqs objectAtIndex:[self findEpById:btn.tag]];
            NSString *str = [NSString stringWithFormat:@"%@", [eq valueForKey:@"dname"]];
            [lbName setText:str];
            CGSize size = [str sizeWithFont:lbName.font];
            lbName.frame = CGRectMake(0, 0, size.width, 18);
            lbEffect.frame = CGRectMake(size.width+5, 0, 200, 18);
            [lbEffect setText:[NSString stringWithFormat:@"%@", [eq valueForKey:@"effect"]]];
            [lbLongDesc setText:[[NSString alloc] initWithFormat:@"%@", [eq valueForKey:@"intro"]]];
            [vLongDescContainer scrollRectToVisible:CGRectMake(0, 0, 2, 2) animated:NO];
            btEqDetail.tag = btn.tag;
            btEqDetail.hidden = NO;
        }
    }
    
    
}

- (void) highlightButton2:(UIButton*)btn{
    [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    if (worneq_selected && worneq_selected != btn){
        if (worneq_selected){
            [worneq_selected setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
            [worneq_selected setBackgroundColor:[UIColor clearColor]];
        }
    }
    EGOImageButton* _btn = (EGOImageButton*)btn;
    if (_btn.imageURL){
        worneq_selected = btn;
        [btn setBackgroundColor:[UIColor yellowColor]];
    }
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
        NSObject* eq = [eqs objectAtIndex:[self findEpById:sloteq_selected.tag]];
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
//            [ad showMsg:@"You cannot wear it on this position" type:1 hasCloseButton:YES];
            [ad showMsg:@"该装备不适合穿在这里" type:1 hasCloseButton:YES];
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
            NSDictionary* eq = [eqs objectAtIndex:[self findEpById:btn.tag]];
            
            NSString *str = [NSString stringWithFormat:@"%@", [eq valueForKey:@"dname"]];
            [lbName setText:str];
            CGSize size = [str sizeWithFont:lbName.font];
            lbName.frame = CGRectMake(0, 0, size.width, 18);
            lbEffect.frame = CGRectMake(size.width+5, 0, 200, 18);
            [lbEffect setText:[NSString stringWithFormat:@"%@", [eq valueForKey:@"effect"]]];
           
            btEqDetail.hidden = NO;
            btEqDetail.tag = btn.tag;
            [lbLongDesc setText:[[NSString alloc] initWithFormat:@"%@", [eq valueForKey:@"intro"]]];
            [vLongDescContainer scrollRectToVisible:CGRectMake(0, 0, 2, 2) animated:NO];
        }

    }
    
}

- (void) selectItem:(UIButton*)btn{
      NSArray* eqs = [ad getDataUserEqs];
    
    if (btn.tag != 0){
        NSDictionary* eq = [self findObjById:btn.tag];
        
        NSString *str = [NSString stringWithFormat:@"%@", [eq valueForKey:@"dname"]];
        [lbItemName setText:str];
        CGSize size = [str sizeWithFont:lbName.font];
        lbItemName.frame = CGRectMake(0, 0, size.width, 18);
        NSString* effect = [eq valueForKey:@"effect"];
        if (effect)
            [lbItemEffect setText:[NSString stringWithFormat:@"%@", effect]];
        
        btItemDetail.hidden = NO;
        btItemDetail.tag = btn.tag;
        
        [lbItemLongDesc setText:[[NSString alloc] initWithFormat:@"%@", [eq valueForKey:@"intro"]]];
        [vItemLongDescContainer scrollRectToVisible:CGRectMake(0, 0, 2, 2) animated:NO];
        CGRect r = btn.superview.frame;
        r.origin.x += 60;
    //    [vItemContainer scrollRectToVisible:btn.superview.frame animated:YES];
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
        [btn setBackgroundColor:[UIColor yellowColor]];
        if (item_selected && item_selected != btn){
            [item_selected setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
            [item_selected setBackgroundColor:[UIColor clearColor]];
        }
        item_selected = btn;
    }
    else{
        btItemDetail.hidden = YES;
    }
}

- (void) onSell1:(UIButton*)btn {
    NSArray* eqs = [ad getDataUserEqs];
    NSObject* eq = [eqs objectAtIndex:[self findEpById:itemOnDetail]];
    if (!eq)
        return;
    WHHttpClient* client = [[WHHttpClient alloc] init:self  ];
    [client sendHttpRequest:[NSString stringWithFormat:@"/usereqs/sell?id=%d", [[eq valueForKey:@"id"] intValue]] selector:@selector(onSellReturn:) json:YES showWaiting:YES];
    
}
- (void)onUse:(UIButton*)btn {
    NSArray* eqs = [ad getDataUserEqs];
    NSObject* eq = [eqs objectAtIndex:[self findEpById:itemOnDetail]];
    if (!eq)
        return;
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:[NSString stringWithFormat:@"/usereqs/use?id=%d", [[eq valueForKey:@"id"] intValue]] selector:@selector(onUseReturn:) json:YES showWaiting:YES];
}
- (void) setStatus:(NSString*) s{
    if (s != NULL && s != nil && s != [NSNull null])
        lbStatus.text = s;
}
@end
