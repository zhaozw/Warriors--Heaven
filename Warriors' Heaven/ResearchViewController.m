//
//  ResearchViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResearchViewController.h"
#import "WHHttpClient.h"
#import "AppDelegate.h"

@implementation ResearchViewController
@synthesize vUnRead;
@synthesize vRead;
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
    
    [vRead init1];
    [vUnRead init1];
    [self view].frame = CGRectMake(0, 200, 320, 280);
    vRead.frame = CGRectMake(0, 0, 320, 100);
    vUnRead.frame = CGRectMake(0, 100, 320, 100);
//    [[self view] setBackgroundColor:[UIColor redColor]];
    [vRead setController:self];
    [vUnRead setController:self];
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/Userrsches" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
}

- (void) buildRearchList{
    
    [vRead removeAllRow];
    [vUnRead removeAllRow];
    NSObject* root =  [[ad getDataUser] valueForKey:@"research"];
    NSArray* read = [root valueForKey:@"read"];
    NSArray* unread = [root valueForKey:@"unread"];

    if (read){
        for (int i = 0; i< [read count]; i++){
            NSObject* row = [[NSMutableDictionary alloc] init];
            NSObject* r = [[read objectAtIndex:i] valueForKey:@"userrsch"];
            NSString* dname = [r valueForKey:@"dname"];
            NSString* desc = [r valueForKey:@"desc"];
            int pv = [[r valueForKey:@"progress"] intValue];
             int _id = [[r valueForKey:@"id"] intValue];
        //    UIImageView *row = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
          //  UIImageView
        /*    
            bgImage
            bgColor
            titleImage
            height
            margin
            title
         children ->[
         {name=label, left, top, width, height, text},
         {name=progress,progress, left, top, width, height, value},
         
         ]
         buttons->[
         {text, bgImage, bgColor, font}
         {..}
         ]
         */
            [row setValue:@"bg_quest1.png" forKey:@"bgImage"];
            
            NSString* imageUrl = [NSString stringWithFormat:@"http://%@:%@/game/badges/badge1.png", [ad host], [ad port]];
            [row setValue:imageUrl forKey:@"titleImage"];
//            [row setValue:@"" forKey:@"bgColor"];
//            [row setValue:@"" forKey:@"height"];
//            [row setValue:@"" forKey:@"margin"];
            [row setValue:dname forKey:@"title"];
            
            NSMutableArray* children = [[NSMutableArray alloc ] init ];
            [row setValue:children forKey:@"children"];
            
            NSObject* miaoshu = [[NSMutableDictionary alloc] init];
            [miaoshu setValue:@"label" forKey:@"nodeName"];
            [miaoshu setValue:desc forKey:@"text"];
            [children addObject: miaoshu];
            
            NSObject* progress = [[NSMutableDictionary alloc] init ];
            [miaoshu setValue:@"progress" forKey:@"nodeName"];
            [miaoshu setValue:[NSNumber numberWithInt:pv ] forKey:@"value"];
            [children addObject: progress];
            
            
            NSMutableArray* buttons = [[NSMutableArray alloc ] init ];
            [row setValue:buttons forKey:@"buttons"];
            NSObject* button = [[NSMutableDictionary alloc] init];
            [button setValue:@"onResearchRead:" forKey:@"callback"];
            [button setValue:@"Research" forKey:@"text"];
//            [button setValue:[NSNumber numberWithInt:(_id)] forKey:@"tag"];
            [button setValue:@"btn_green_light" forKey:@"bgImage"];
            [button setValue:[NSNumber numberWithInt:70] forKey:@"width"];
            [buttons addObject: button];
            
            
            
            [vRead addRow:row];
            
        }
    }
    
    if (unread){
        for (int i = 0; i< [unread count]; i++){
                NSObject* row = [[NSMutableDictionary alloc] init];
            NSObject* r = [unread objectAtIndex:i];
            NSString* dname = [r valueForKey:@"dname"];
            NSString* desc = [r valueForKey:@"desc"];
            NSString* imageUrl = [NSString stringWithFormat:@"http://%@:%@/game/badges/badge1.png", [ad host], [ad port]];
//            int pv = [[r valueForKey:@"progress"] intValue];
            [row setValue:@"bg_quest1.png" forKey:@"bgImage"];
            [row setValue:imageUrl forKey:@"titleImage"];
            //            [row setValue:@"" forKey:@"bgColor"];
            //            [row setValue:@"" forKey:@"height"];
            //            [row setValue:@"" forKey:@"margin"];
            [row setValue:dname forKey:@"title"];
            
            NSMutableArray* children = [[NSMutableArray alloc ] init];
            [row setValue:children forKey:@"children"];
            
            NSObject* miaoshu = [[NSMutableDictionary alloc] init];
            [miaoshu setValue:@"label" forKey:@"nodeName"];
            [miaoshu setValue:desc forKey:@"text"];
            [children addObject: miaoshu];
            
            NSMutableArray* buttons = [[NSMutableArray alloc ] init ];
            [row setValue:buttons forKey:@"buttons"];
            NSObject* button = [[NSMutableDictionary alloc] init];
            [button setValue:@"onResearchUnread:" forKey:@"callback"];
            [button setValue:@"Research" forKey:@"text"];
//            [button setValue:[NSNumber numberWithInt:(_id)] forKey:@"tag"];
            [button setValue:@"btn_green_light" forKey:@"bgImage"];
            [button setValue:[NSNumber numberWithInt:70] forKey:@"width"];
            [buttons addObject: button];
            

            [vUnRead addRow:row];
        }
    }
    
    // adjust position of vUnRead
    CGRect rect1 = vRead.frame;
    CGRect rect2 = vUnRead.frame;
    
    rect2.origin.y = rect1.origin.y+rect1.size.height +35;
    rect2.size.height = 30;
    vUnRead.frame = rect2;
    
    CGRect rect3 = [self view].frame;
    rect3.size.height = rect1.size.height + 15 + rect2.size.height;
    [self view].frame = rect3;
    [self view].backgroundColor = [UIColor redColor];
    
}
- (void) onResearchUnread:(UIButton*)btn{
    
    NSObject* root =  [[ad getDataUser] valueForKey:@"research"];
    NSArray* read = [root valueForKey:@"unread"];
    NSObject* r = [ read objectAtIndex:btn.tag] ;
    NSString* name = [r valueForKey:@"skname"];
    
    NSString* url = [NSString stringWithFormat:@"/Userrsches/research?skname=%@", name];
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:url selector:@selector(onResearchReturn:) json:YES showWaiting:YES];
    
}

- (void) onResearchRead:(UIButton*)btn{
 
    NSObject* root =  [[ad getDataUser] valueForKey:@"research"];
    NSArray* read = [root valueForKey:@"read"];
    NSObject* r = [[ read objectAtIndex:btn.tag] valueForKey:@"userrsch"];
    NSString* name = [r valueForKey:@"skname"];
    
    NSString* url = [NSString stringWithFormat:@"/Userrsches/research?skname=%@", name];
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:url selector:@selector(onResearchReturn:) json:YES showWaiting:YES];
    
}

- (void)onResearchReturn:(NSObject*) data{
    if ([data valueForKey:@"error"]){
        [ad showMsg:[data valueForKey:@"error"] type:1 hasCloseButton:YES];
        return;
    }
   // [ad showMsg:@"你对书中的内容有所领悟" type:0 hasCloseButton:NO];
    [ad showMsg:[data valueForKey:@"msg"] type:0 hasCloseButton:NO];
    [[ad getDataUser] setValue:data forKey:@"research"];
    [self buildRearchList];
    
    ad.bUserSkillNeedUpdate = TRUE;
}

- (void) onReceiveStatus:(NSObject*) data{
    if ([data valueForKey:@"error"]){
        [ad showMsg:[data valueForKey:@"error"] type:1 hasCloseButton:YES];
        return;
    }
    [[ad getDataUser] setValue:data forKey:@"research"];
    [self buildRearchList];
    
    
}
- (void)viewDidUnload
{
    [self setVUnRead:nil];
    [self setVRead:nil];
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
