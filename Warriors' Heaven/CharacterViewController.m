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

@synthesize eq_slots;
@synthesize eq_buttons;
@synthesize eq_selected;
@synthesize eqbtn_selected;

@synthesize vEqbtn_cap;
@synthesize vEqbtn_neck;
@synthesize vEqbtn_handright;
@synthesize vEqbtn_arm;
@synthesize vEqbtn_fingersRight;
@synthesize vEqbtn_handleft;
@synthesize vEqbtn_fingersleft;
@synthesize vEqbtn_boots;
@synthesize vEqbtn_trousers;
@synthesize vEqbtn_armo;

@synthesize eq_list;
@synthesize pos_list;
@synthesize woren_eq_list;

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
    
    UIImage *imageNormal = [UIImage imageNamed:@"bg_12.png"];
    UIImage *stretchableImageNormal = [imageNormal stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    [vEquipment setImage:stretchableImageNormal];
    
    eq_buttons = [[NSMutableArray alloc] initWithCapacity:10];
    eq_slots = [[NSMutableArray alloc] initWithCapacity:10];
    woren_eq_list = [[NSMutableArray alloc] initWithObjects:
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
                     nil];
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
    eq_list = [[NSMutableArray alloc] initWithCapacity:5+1];
    [eq_list addObject:[NSNull null]];
    for (int i = 0; i< 5; i++){
        UIImageView* slot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eqslot.png"]];
        slot.frame = CGRectMake(10+i*60, 10, 60, 60);
        [slot setUserInteractionEnabled:YES];
        [vEquipment addSubview:slot];
        [eq_slots addObject:slot];
        [slot setTag:i+1];
        
        EGOImageButton *v = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        [eq_buttons addObject:v];
        [v setTag:i+1];
        [v addTarget:self action:@selector(selectEq:) forControlEvents:UIControlEventTouchUpInside];
//        [v setTintColor:[UIColor redColor]];
        [slot addSubview:v];
        [eq_list addObject:[NSNull null]];
    }
    
    vEqbtn_cap = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    [vEqbtn_cap addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_cap addSubview:vEqbtn_cap];
    [vEq_cap setTag:1];
    [vEqbtn_cap setTag:1];
    
//    [vEq_cap setTag:(int)@"head"];
//    [vEq_cap setValue:@"head" forKey:@"pos"];
    
    vEqbtn_neck = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_neck addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_neck addSubview:vEqbtn_neck];
    [vEq_neck setTag:2];
    [vEqbtn_neck setTag:2];
    
    vEqbtn_handright = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_handright addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_handright addSubview:vEqbtn_handright];
    [vEq_handright setTag:3];
    [vEqbtn_handright setTag:3];
    
    vEqbtn_arm = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_arm addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_arm addSubview:vEqbtn_arm];
    [vEq_arm setTag:4];
    [vEqbtn_arm setTag:4];
    
    vEqbtn_fingersRight = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_fingersRight addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_fingersRight addSubview:vEqbtn_fingersRight];
        [vEq_fingersRight setTag:(int)5];
    [vEqbtn_fingersRight setTag:5];
    
    vEqbtn_handleft = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_handleft addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_handleft addSubview:vEqbtn_handleft];
        [vEq_handleft setTag:6];
    [vEqbtn_handleft setTag:6];
    
    vEqbtn_fingersleft = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_fingersleft addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_fingersleft addSubview:vEqbtn_fingersleft];
        [vEq_fingersleft setTag:7];
    [vEqbtn_fingersleft setTag:7];
    
    vEqbtn_boots = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_boots addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_boots addSubview:vEqbtn_boots];
        [vEq_boots setTag:8];
    [vEqbtn_boots setTag:8];
    NSLog(@"vEqbtn_boots=%@", vEqbtn_boots);
    
    vEqbtn_trousers = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_trousers addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_trousers addSubview:vEqbtn_trousers];
        [vEq_trousers setTag:9];
    [vEqbtn_trousers setTag:9];
    
    vEqbtn_armo = [[EGOImageButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   [vEqbtn_armo addTarget:self action:@selector(selectWorenEq:) forControlEvents:UIControlEventTouchUpInside];
    [vEq_armo addSubview:vEqbtn_armo];
        [vEq_armo setTag:10];
    [vEqbtn_armo setTag:10];
    
    // add status view
//    [self addChildViewController:vcStatus];
//    [self.view addSubview:vcStatus.view];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) onReceiveStatus:(NSArray*) data{
    if (![data isKindOfClass:[NSArray class]])
        return;
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
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
    
    int j = 0;
    
//    [eq_buttons removeAllObjects];
    for (int i = 0; i< [data count]; i++){
        NSObject *o = [data objectAtIndex:i];
        NSObject* eq = [o valueForKey:@"usereq"];
        int slotNumber = [[eq valueForKey:@"eqslotnum"] intValue];
        
        NSString* filepath = [eq valueForKey:@"file"];
        if (filepath == NULL || filepath.length == 0)
            filepath = [NSString stringWithFormat:@"%@.png", [eq valueForKey:@"eqname"]];
        filepath = [NSString stringWithFormat:@"http://%@:%@/game/obj/equipments/%@", ad.host, ad.port, filepath];
        NSLog(@"filepath=%@", filepath);

        if (slotNumber < 0 ){
            
            NSString* wearon = [o valueForKey:@"wearon"];
           
        
                      
                        
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
            
            continue;
        }
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
    
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"character view update");
    

    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/usereqs" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    }

- (void) highlightButton:(UIButton*)btn{
//    [btn drawRect:CGRectMake(0, 0, 50, 50)];
//    [btn setSelected:YES];
//    [btn setHighlighted:YES];
     [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    
    if (eqbtn_selected != btn){
        [eqbtn_selected setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        eqbtn_selected = btn;
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
//        eqbtn_selected = btn;
//    }
}

- (void) selectEq:(UIButton*)btn{
   
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    
    EGOImageButton* _btn = btn; 
    if (eq_selected != NULL){
        if (_btn.imageURL == NULL){
        // exchange equipment (set eqslotnum and wearon)
        NSURL * url = eq_selected.imageURL;
       
        NSURL  * url2 = _btn.imageURL;
        [eq_selected setImageURL:url2];
        [_btn setImageURL:url];
        
//        if (eq_selected.imageURL == NULL){
            [eq_selected setBackgroundColor:[UIColor clearColor]];
//        }else
//            [eq_selected setBackgroundColor:[UIColor yellowColor]];
//        if (_btn.imageURL == NULL){
            [_btn setBackgroundColor:[UIColor clearColor]];
//        }else
//            [_btn setBackgroundColor:[UIColor yellowColor]];
        NSLog(@"eq_selected.tag=%d)", eq_selected.tag);
        NSObject* eq = [woren_eq_list objectAtIndex:eq_selected.tag];
        [eq_list replaceObjectAtIndex:btn.tag withObject:eq];
        NSLog(@"eq_list %d = eq(%@)", btn.tag, eq);
        [woren_eq_list replaceObjectAtIndex:eq_selected.tag withObject:[NSNull null]];
        }else{
            NSString* pos = [pos_list objectAtIndex:eq_selected.superview.tag];
            NSLog(@"eq_selected.superview.tag=%d", eq_selected.superview.tag);
            NSObject* eq = [eq_list objectAtIndex:btn.tag];
//            NSLog(@"eq=%@", eq);
            NSString* wearon = [eq valueForKey:@"pos"];
            
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", wearon]; 
            
            NSLog(@"TEST %@ with %@", wearon, pos);
            
            if ([test evaluateWithObject:pos]){ 
                // exchange image
                NSURL * url = eq_selected.imageURL;
                NSURL  * url2 = _btn.imageURL;
                [eq_selected setImageURL:url2];
                [_btn setImageURL:url];
                
                NSObject* eq2 = [woren_eq_list objectAtIndex:eq_selected.tag];
                [woren_eq_list replaceObjectAtIndex:eq_selected.tag withObject:eq];
                [eq_list replaceObjectAtIndex:btn.tag withObject:eq2];
            }
        }
        eq_selected = NULL;
        eqbtn_selected = NULL;
    }else{
         if (_btn.imageURL != NULL)
             [_btn setBackgroundColor:[UIColor yellowColor]];
        [self performSelector:@selector(highlightButton:) withObject:btn afterDelay:0.0];
    }
}

- (void) highlightButton2:(UIButton*)btn{
    [btn setImageEdgeInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    if (eq_selected)
        [eq_selected setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    eq_selected = btn;
}

- (void) selectWorenEq:(UIButton*) btn{
    
    EGOImageButton* _btn = btn;
    if (eqbtn_selected != NULL && eqbtn_selected.imageURL != NULL){
//        id a = [NSNumber numberWithInt:btn.superview.tag] intValue];
//        NSString* pos = a;
//       
//        
//
//        id b =[NSNumber numberWithInt:eqbtn_selected.tag];
//         NSObject* eq = b;

        
        NSString* pos = [pos_list objectAtIndex:btn.superview.tag];
        NSLog(@"eqbtn_selected.tag=%d", eqbtn_selected.tag);
        NSObject* eq = [eq_list objectAtIndex:eqbtn_selected.tag];
        NSLog(@"eq=%@", eq);
        NSString* wearon = [eq valueForKey:@"pos"];
        
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", wearon]; 
        
        NSLog(@"TEST %@ with %@", wearon, pos);
        
        if ([test evaluateWithObject:pos]){ 
            
        
        // exchange equipment (set eqslotnum and wearon)
        NSURL * url = eqbtn_selected.imageURL;
        
        NSURL  * url2 = _btn.imageURL;
        [eqbtn_selected setImageURL:url2];
        [_btn setImageURL:url];
        
//        if (eqbtn_selected.imageURL == NULL){
            [eqbtn_selected setBackgroundColor:[UIColor clearColor]];
//        }else
//            [eqbtn_selected setBackgroundColor:[UIColor yellowColor]];
//        
//        if (_btn.imageURL == NULL){
            [_btn setBackgroundColor:[UIColor clearColor]];
//        }else
//            [_btn setBackgroundColor:[UIColor yellowColor]];
            
        [eq_list replaceObjectAtIndex:eqbtn_selected.tag withObject:[NSNull null]];
        [woren_eq_list replaceObjectAtIndex:btn.tag withObject:eq];
            NSLog(@"eq_selected=%@", btn);
            NSLog(@"woren_eqlist[%d]=eq%@", btn.tag, eq);
        eq_selected = NULL;
        eqbtn_selected = NULL;
        }
        
    }else{
        if (_btn.imageURL != NULL)
          [_btn setBackgroundColor:[UIColor yellowColor]];
        [self performSelector:@selector(highlightButton2:) withObject:btn afterDelay:0.0];
    }
    
}


@end
