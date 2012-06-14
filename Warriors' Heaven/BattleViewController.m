//
//  BattleViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleViewController.h"
#import "AppDelegate.h"
#import "WHHttpClient.h"
#import "LightView.h"
#import "EGOImageButton.h"

@implementation BattleViewController
@synthesize vcStatus;
@synthesize vcPlayer;

@synthesize  fight_result;
@synthesize vcBoss;
@synthesize ad;
@synthesize players;

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
    
    // add status view
//    [self addChildViewController:vcStatus];
//    [self.view addSubview:vcStatus.view];

    [vcBoss setOnClose:self sel:@selector(onCloseBossView:)];
    [vcBoss view].hidden = YES;
    [vcPlayer view].hidden = YES;
    [vcPlayer setOnFight:self sel:@selector(onFight:)];
    
    players = [[NSMutableArray alloc] init];
    
    ad = [UIApplication sharedApplication].delegate;
    
    vPlayers = [[UIView alloc] initWithFrame:CGRectMake(0, 66, 320, 480-66)];
    [[self view] addSubview:vPlayers];
//    vPlayers.backgroundColor = [UIColor redColor];
    vHeroes = [[UIView alloc] initWithFrame:CGRectMake(0, 66, 320, 480-66)];
    [[self view]  addSubview:vHeroes];
    vHeroes.backgroundColor = [UIColor clearColor];
    vHeroes.hidden = YES;

    UIImageView* vTitleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_02.jpg"]];
    vTitleView.frame = CGRectMake(0, 0, 320, 39);
    vTitleView.userInteractionEnabled = YES;
    [vPlayers addSubview: vTitleView];
    UILabel* lbTitle = [LightView createLabel:CGRectMake(5, 2, 200, 30) parent:vTitleView text:@"请选择要挑战的玩家" textColor:[UIColor yellowColor]];
    [lbTitle setFont: [UIFont fontWithName:@"Helvetica" size:15.0f]];


    NSString* bossImage = [[[ad getDataUser] valueForKey:@"hero"] valueForKey:@"legendImage"];
    NSString* url = NULL;
    if ([bossImage characterAtIndex:0]=='/')
         url = [NSString stringWithFormat:@"http://%@:%@/game%@", [ad host], [ad port], bossImage];
    else
        url = [NSString stringWithFormat:@"http://%@:%@/game/%@", [ad host], [ad port], bossImage];
 
    EGOImageButton * btBoss = [[EGOImageButton alloc]initWithFrame:CGRectMake(180, 3, 160, 36)];
//    [btBoss setTitle:@"挑战Boss" forState:UIControlStateNormal];
    [vTitleView addSubview:btBoss];
    btBoss.imageURL = [NSURL URLWithString:url];
    btBoss.imageView.contentMode = UIViewContentModeScaleToFill;
    btBoss.contentMode = UIViewContentModeScaleToFill;
    
      
//    btBoss.contentStretch = btBoss.frame;
//    btBoss.backgroundColor = [UIColor redColor];
    [btBoss addTarget:self action:@selector(onTouchBoss:) forControlEvents:UIControlEventTouchUpInside];
    btBoss.userInteractionEnabled = YES;

    UIButton* btChallenge = [LightView createButton:CGRectMake(240, 10, 80, 25) parent:vTitleView text:@""  tag:0];
    [btChallenge setBackgroundImage:NULL forState:UIControlStateNormal];
    [btChallenge setImage:[UIImage imageNamed:@"challenge.png"] forState:UIControlStateNormal];
    btChallenge.opaque = FALSE;
    btChallenge.alpha = 0.7f;
    [btChallenge.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:15.0f]];
    [btChallenge addTarget:self action:@selector(onTouchBoss:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView* vTitleView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_02.jpg"]];
    vTitleView2.frame = CGRectMake(0, 0, 320, 39);
    vTitleView2.userInteractionEnabled = YES;
  
    [vHeroes addSubview: vTitleView2];
//    vHeroes.backgroundColor = [UIColor greenColor];
//    UILabel* lbTitle = [LightView createLabel:CGRectMake(5, 2, 200, 30) parent:vTitleView text:@"请选择要挑战的玩家" textColor:[UIColor yellowColor]];
//    [lbTitle setFont: [UIFont fontWithName:@"Helvetica" size:15.0f]];
    UIButton* btBack = [LightView createButton:CGRectMake(0, 3, 90, 35) parent:vTitleView2 text:@"" tag:0];
    [btBack setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btBack addTarget:self action:@selector(showPlayers:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* lbTitleHeroView = [LightView createLabel:CGRectMake(150, 0, 100, 33) parent:vTitleView2 text:@"挑战英雄" textColor:[UIColor colorWithRed:1.0 green:0.9 blue:0.2 alpha:1]];
    [lbTitleHeroView setFont:[UIFont fontWithName:@"Helvetica" size:15.0f]];
    
 /*   UIButton* btPlayer = [LightView createButton:CGRectMake(0, 0, 160, 39) parent:vTitleView text:@"玩家" tag:0];
    btPlayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [btPlayer setBackgroundImage:NULL forState:UIControlStateNormal];
    UIButton* btBoss = [LightView createButton:CGRectMake(160, 0, 160, 39) parent:vTitleView text:@"Boss" tag:0];
    [btBoss setBackgroundImage:NULL forState:UIControlStateNormal];
    btBoss.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  */
   
    vHeroList = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 320, 480-66-39)];
    [vHeroes addSubview:vHeroList];
    
    [[self view] bringSubviewToFront:vTitleView];
    
 
}

- (void)  showPlayers:(UIButton*) btn{
    vPlayers.hidden = NO;
    vHeroes.hidden = YES;
}
- (void) onShowBoss:(UIButton*) btn{
    NSObject* o= [heroList objectAtIndex:btn.tag];
    NSString* name = [o valueForKey:@"name"];
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    NSString* url = [NSString stringWithFormat:@"/wh/hero?heroname=%@", name];
    [client sendHttpRequest:url selector:@selector(onHeroReturn:) json:YES showWaiting:YES];
}
- (void) onTouchBoss:(UIButton*) btn{
    vHeroes.hidden = NO;
    vPlayers.hidden = YES;
    
}
- (void) onHeroReturn:(NSObject*) data{
    [vcBoss loadHero:data];
    if (bFirstShow)
        bFirstShow = FALSE;
}

- (void) loadPlayers{
    int count = [playerList count]; 
    int row_height = 70;
    int row_margin = 1;
    int margin_top = 39;
    //    int y = 300;
    int y = 0;
    // clear 
    for (int j = 0; j < [players count]; j++){
        [[players objectAtIndex:j] removeFromSuperview];
    }
    [players removeAllObjects];
    
    for (int i = 0; i< count; i++){
        NSObject* d = [playerList objectAtIndex:i];
        NSObject* json = [d valueForKey:@"userext"];
        NSNumber *uid = [json valueForKey:@"uid"];
        NSString* name = [json valueForKey:@"name"];
        NSString* title = [json valueForKey:@"title"];
        NSString* level = [[json valueForKey:@"level"] stringValue];
        int profile = [[json valueForKey:@"profile"] intValue];
        //        y = 100+ i*(row_height+row_margin);
        y = i*(row_height+row_margin)+ margin_top;
        
        UIView * row = [[UIView alloc] initWithFrame:CGRectMake(0,y, 320, row_height)];
        //        if (i/2*2 == i)
        //            [row setBackgroundColor:[UIColor redColor]];
        //        else
        //            [row setBackgroundColor:[UIColor greenColor]];
        [row setOpaque:NO];
        [row setBackgroundColor:[UIColor clearColor]];
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
        UIButton* logo = [LightView createButton:CGRectMake(1, 5, 50, 50) parent:row text:@"" tag:[uid intValue]];
        [logo setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"p_%d.png", profile]] forState:UIControlStateNormal];
        [logo addTarget:self action:@selector(onSelectPlayer:) forControlEvents:UIControlEventTouchUpInside];
        //        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"p_%d.png", i%6+1] ] ];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        
        
        //        [logo setFrame:CGRectMake(1, 5, 50, 50)];
        //        [row addSubview:logo];
        
        UILabel* lbInfo = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 50, 30)];
        [lbInfo setOpaque:NO];
        //        lbInfo setContentMode:<#(UIViewContentMode)#>
        [lbInfo setAdjustsFontSizeToFitWidth:YES];
        [lbInfo setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [lbInfo setTextColor:[UIColor whiteColor]];
        [lbInfo setBackgroundColor:[UIColor clearColor]];
        [lbInfo setText:[[NSString alloc] initWithFormat:@"%@", name]];
        [row addSubview:lbInfo];
        
        
        UILabel* lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(60, 22, 100, 30)];
        [lbTitle setOpaque:NO];
       
        [lbTitle setAdjustsFontSizeToFitWidth:YES];
        [lbTitle setFont:[UIFont fontWithName:@"Heiti TC" size:12.0f]];
        [lbTitle setTextColor:[UIColor greenColor]];
        [lbTitle setBackgroundColor:[UIColor clearColor]];
        [lbTitle setText:[[NSString alloc] initWithFormat:@"%@", title]];
        [row addSubview:lbTitle];

        
        UILabel* lbLevel = [[UILabel alloc]initWithFrame:CGRectMake(60, 35, 100, 30)];
        [lbLevel setOpaque:NO];
        [lbLevel setAdjustsFontSizeToFitWidth:NO];
        //[lbLevel setMinimumFontSize:8.0f];
        [lbLevel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [lbLevel setTextColor:[UIColor yellowColor]];
        [lbLevel setBackgroundColor:[UIColor clearColor]];
        [lbLevel setText:[[NSString alloc] initWithFormat:@"Level %@", level]];
        [row addSubview:lbLevel];
        
        UILabel* lbStatus = [[UILabel alloc]initWithFrame:CGRectMake(120, 20, 100, 30)];
        [lbStatus setOpaque:NO];
        [lbStatus setAdjustsFontSizeToFitWidth:NO];
        //[lbLevel setMinimumFontSize:8.0f];
        [lbStatus setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [lbStatus setTextColor:[UIColor yellowColor]];
        [lbStatus setBackgroundColor:[UIColor clearColor]];
        NSString* status = [json valueForKey:@"status"];
        if ([status length] != 0)
            status = [NSString stringWithFormat:@"(%@)", status]; 
        [lbStatus setText:status];
        [row addSubview:lbStatus];
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setFrame:CGRectMake(240, 10, 70, 35)];
        [btn setTitle:@"Fight" forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(onFight:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
        [btn setTag:[uid intValue]];
        [row addSubview:btn];   
        
        [vPlayers addSubview:row];
        [players addObject:row];
    }
    int h = margin_top+count*(row_height+row_margin);
    CGRect rect = vPlayers.frame;
    rect.size.height = h;
    vPlayers.frame = rect;
    vPlayers.hidden = NO;
//    vPlayers.backgroundColor = [UIColor redColor];
    if (rect.size.height+60 > 480)
        ((UIScrollView* )[self view]).contentSize = CGSizeMake(0, rect.size.height+60-480);
}

- (void) loadHeroes{
    int count = [heroList count];
    int row_height = 50;
    int row_margin = 1;
    int margin_top = 0;
    int margin = 1;
    //    int y = 300;˙
    int y = margin_top;
    
    [LightView removeAllSubview:vHeroList];
    
    for (int i= 0; i < [heroList count]; i++) {
        NSObject * o = [heroList objectAtIndex:i];
        NSString * image = [o valueForKey:@"legendImage"];
        int level  = [[o valueForKey:@"level"] intValue];
        NSObject* defeated = [o valueForKey:@"defeated"];
        NSObject* locked = [o valueForKey:@"locked"];
        NSString *filepath = [NSString stringWithFormat:@"http://%@:%@/game/%@", ad.host, ad.port, image];
        
        EGOImageView* v = [[EGOImageView alloc] initWithFrame:CGRectMake(0, y, 320, row_height)];
        UIButton* b = [LightView createButton:CGRectMake(0, y, 320, row_height) parent:vHeroList text:@"" tag:i];
        b.alpha = 0.1f;
        b.opaque = YES;
        [b addTarget:self action:@selector(onShowBoss:) forControlEvents:UIControlEventTouchUpInside];
       
//        EGOImageButton *btn = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, margin_top+i*row_height, 320, row_height)];
//        btn.imageView.contentMode = UIViewContentModeScaleToFill;
//        btn.contentMode = UIViewContentModeScaleToFill;
     
//        btn.backgroundColor = [UIColor redColor];
//        [vHeroList addSubview:btn];
        [vHeroList addSubview:v];
        [vHeroList addSubview:b];


        if (locked){
//            [btn setImage:[UIImage imageNamed:@"lock.png"] forState:UIControlStateNormal];
            [v setImage:[UIImage imageNamed:@"unknown.jpg"]];
            b.userInteractionEnabled = NO;
        }
        else {
              [v setImageURL:[NSURL URLWithString:filepath]];
        if (defeated){
            [LightView createImageView:@"defeated.png" frame:CGRectMake(250, y, 50, 50) parent:vHeroList];
            b.userInteractionEnabled = NO;
        }        
          
        }
        y += margin+row_height;
        
    }
    vHeroes.hidden = NO;
    CGRect rect = vHeroes.frame;
    rect.size.height = margin_top+ (row_height+margin)*[heroList count];
    vHeroes.frame = rect;
     rect = vHeroList.frame;
    rect.size.height = 0+ (row_height+margin)*[heroList count];
    vHeroList.frame = rect;
}
- (void) onReceiveStatus:(NSObject*) data{
    
    playerList = [data valueForKey:@"player"];
    heroList = [data valueForKey:@"hero"];
    [self loadPlayers];
    [self loadHeroes];

    if (bFirstShow)
        vPlayers .hidden = YES;
    else
        vHeroes .hidden = YES;
}

- (id) findPlayerById:(int) uid{
    for (int i = 0; i< [playerList count]; i++){
        NSObject* d = [playerList objectAtIndex:i];
        NSObject* json = [d valueForKey:@"userext"];
        int _uid = [[json valueForKey:@"uid"] intValue];
        if (uid == _uid)
            return d;
    }
    return NULL;

}
- (void) onSelectPlayer:(UIButton*) btn{
    id player = [self findPlayerById:btn.tag];
    if (player){
        [vcPlayer loadPlayer:player];
    }
}

- (void) showFight:(UIButton*) btn{
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    
    NSString* msg = [self.fight_result valueForKey:@"msg"];
    [ad showFightMsg:msg];
}
- (void) onFightResult:(NSObject*) data{
    
    NSLog(@"onFightResult");
    
    if ([data valueForKey:@"error"]){
        [ad showMsg:[data valueForKey:@"error"] type:1 hasCloseButton:YES];
        return;
    }

    ad.bUserSkillNeedUpdate = YES;
    
    [ad setDataUser:[data valueForKey:@"user"] save:YES];
    
    self.fight_result = data;
    
    BOOL win = [[data valueForKey:@"win"] boolValue];
    
    // show result    
    UIImageView * resultView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [resultView setOpaque:TRUE];
  
    [resultView setImage:[UIImage imageNamed:@"fight_result.png"]];
    
    
    UIImageView * resView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 30, 230, 110)];
    
    // display fight result
    if (win)
        [resView setImage:[UIImage imageNamed:@"fight_result_win.png"]];
    else
        [resView setImage:[UIImage imageNamed:@"fight_result_fail.png"]];
    [resultView addSubview:resView];
    int x,y;
    int top_margine = 130;
//    [[LightView createLabel:CGRectMake(130, 130, 100, 30) parent:resultView text:@"10回合" textColor:[UIColor blackColor]] setFont:[UIFont fontWithName:@"Helvetica" size:18.0f]];
//    [LightView createImageView:@"line1.png" frame:CGRectMake(0, 158, 320, 2) parent:resultView];

    // display gain in fight
    NSDictionary* gain = [data valueForKey:@"gain"];
    NSArray* keys = [gain allKeys];
    int j = 0;
 
    for (int i = 0; i < [keys count]; i++){
        NSString *o = [keys objectAtIndex:i];
        if ([o isEqualToString:@"skills"] || [o isEqualToString:@"drop"] || [o isEqualToString:@"object"])
            continue;
        y = j/3*30 + top_margine;
        x = j%3*80 + 50;
        UILabel* lbKey = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 40, 30)];
        [lbKey setOpaque:NO];
        [lbKey setAdjustsFontSizeToFitWidth:YES];
        [lbKey setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
        [lbKey setTextColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.0f alpha:1.0f]];
        [lbKey setBackgroundColor:[UIColor clearColor]];
        NSString *strName = o;
        if ([o isEqualToString:@"pot"])
            strName = @"潜能";
        else if ([o isEqualToString:@"level"])
            strName = @"等级";
        else if ([o isEqualToString:@"exp"])
            strName = @"经验";
            
        [lbKey setText:strName];
        [lbKey setContentMode:UIViewContentModeLeft];
        [lbKey setTextAlignment:UITextAlignmentLeft];
        [resultView addSubview:lbKey];
        
        UILabel* lbValue = [[UILabel alloc]initWithFrame:CGRectMake(x+40, y, 30, 30)];
        [lbValue setOpaque:NO];
        [lbValue setAdjustsFontSizeToFitWidth:YES];
        [lbValue setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
        [lbValue setTextColor:[UIColor redColor]];
        [lbValue setBackgroundColor:[UIColor clearColor]];
        [lbValue setContentMode:UIViewContentModeLeft];
        [lbValue setTextAlignment:UITextAlignmentLeft];
        NSNumber* v = [gain valueForKey:o];
        if ([v intValue] >= 0)
            [lbValue setText:[[NSString alloc] initWithFormat:@"+%d", [v intValue] ]];
        else if ([v intValue] < 0)
            [lbValue setText:[[NSString alloc] initWithFormat:@"-%d", [v intValue] ]];
//        else
//            [lbValue setText:[[NSString alloc] initWithFormat:@"%d", [v intValue] ]];
        [resultView addSubview:lbValue];
        j++;
    }
    
   
    // display skills gain
    NSDictionary* skills_gain = [gain valueForKey:@"skills"];
   if (skills_gain && [skills_gain count]> 0){
       
        y += 40;
//        [resView drawRect:CGRectMake(10, y -10  , 200, 1)];
       
       NSArray *keys_skill = [skills_gain allKeys];
       int j = 0;
       for (int i = 0; i < [keys_skill count]; i++){
           NSObject* key = [keys_skill objectAtIndex:i];
           NSObject * o = [skills_gain valueForKey:key];
           NSString* name = [o valueForKey:@"dname"];
           NSNumber* point = [o valueForKey:@"point"];   
           NSNumber* level = [o valueForKey:@"level"];   
           
           if ([level intValue]== 0 && [point intValue]== 0)
               continue;
           
           UILabel* lbKey = [[UILabel alloc]initWithFrame:CGRectMake(30, y, 80, 30)];
           [lbKey setOpaque:NO];
           [lbKey setAdjustsFontSizeToFitWidth:NO];
           [lbKey setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
           [lbKey setTextColor:[UIColor colorWithRed:0.0f green:0.5f blue:0.5f alpha:1.0f]];
           [lbKey setBackgroundColor:[UIColor clearColor]];
           [lbKey setText:name];
           [lbKey setContentMode:UIViewContentModeLeft];
           [lbKey setTextAlignment:UITextAlignmentLeft];
           [resultView addSubview:lbKey];
           
           UILabel* lbValue = [[UILabel alloc]initWithFrame:CGRectMake(110, y, 80, 30)];
           [lbValue setOpaque:NO];
           [lbValue setAdjustsFontSizeToFitWidth:YES];
           [lbValue setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
           [lbValue setTextColor:[UIColor redColor]];
           [lbValue setBackgroundColor:[UIColor clearColor]];
           [lbValue setContentMode:UIViewContentModeLeft];
           [lbValue setTextAlignment:UITextAlignmentLeft];
           NSLog(@"%d", [point integerValue]);
 
           if ([level integerValue]  == 0)
               [lbValue setText:[[NSString alloc] initWithFormat:@"+%d", [point integerValue] ]];
           else
               [lbValue setText:[[NSString alloc] initWithFormat:@"Level +%d !", [level integerValue] ]];
           [resultView addSubview:lbValue];
           j ++;
           y+= 30;
       }
        
    }
 
    NSArray* drop = NULL;
    if (win)
        drop = [gain valueForKey:@"object"];
    else
        drop = [gain valueForKey:@"drop"];
    if (drop  && drop!= [NSNull null]){
        for (int i = 0; i<[drop count]; i++) {
            NSObject* o = [drop objectAtIndex:i];
            NSString* dname = [o valueForKey:@"dname"];
            NSString* unit = [o valueForKey:@"unit"];
            if (!unit)
                unit = @"";
            id _amount = [o valueForKey:@"amount"];
            int amount = 1;
            if (_amount)
                amount = [_amount intValue];
            if (amount <= 0)
                continue;
            NSString* s = NULL;
            if (win)
                s = [NSString stringWithFormat:@"你获得了%d%@‘%@’", amount, unit, dname];
            else
                s = [NSString stringWithFormat:@"你失去了%d%@'%@‘", amount, unit, dname];
            [LightView createLabel:CGRectMake(30, y, 200, 30) parent:resultView text:s textColor:[UIColor redColor]];
             y += 30;
        }
    }
    
    
    [LightView createImageView:@"line1.png" frame:CGRectMake(0, y+5, 320, 2) parent:resultView];
    int round = [[data valueForKey:@"round"] intValue];
    [[LightView createLabel:CGRectMake(30, y+10, 100, 30) parent:resultView text:[NSString stringWithFormat:@"%d回合", round] textColor:[UIColor blackColor]] setFont:[UIFont fontWithName:@"Helvetica" size:18.0f]];
    // show fight procedure button
    UIButton * btn_play = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_play setFrame:CGRectMake(80, 360, 70, 35)];
    [btn_play setTitle:@"观看" forState: UIControlStateNormal];
    [btn_play addTarget:self action:@selector(showFight:) forControlEvents:UIControlEventTouchUpInside];
    [btn_play.titleLabel setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
    [btn_play setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [btn_play setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
    //[btn setShowsTouchWhenHighlighted:TRUE];
    [resultView addSubview:btn_play];
    
    // close button
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(160, 360, 70, 35)];
    [btn setTitle:@"Close" forState: UIControlStateNormal];
    [btn addTarget:self action:@selector(closeresult:) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setFont:[UIFont fontWithName:@"System Bold" size:12.0f]];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
    //[btn setShowsTouchWhenHighlighted:TRUE];
    [resultView addSubview:btn];
    
    
    
    [resultView setUserInteractionEnabled: TRUE];
    
    [[ad window] addSubview: resultView];
    
    [[ad window] bringSubviewToFront:resultView];
    
    [ad reloadStatus];
    
//    [ad startRecover];
}

- (void) onFight:(UIButton* )button{
    NSLog(@"fight");
    
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
    
    // send request
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    NSString* url = [[NSString alloc] initWithFormat:@"/wh/fight2?enemy=%d", [button tag]];
    [client sendHttpRequest:url selector:@selector(onFightResult:) json:YES showWaiting:YES];
    

}

- (void) closeresult:(UIButton* )button{
    NSLog(@"closeResult");
    
    UIView* pv = [button superview];
    [pv setHidden: TRUE];
    NSArray * subviewsArr = [pv subviews];
    for(UIView *v in subviewsArr )
    {
        [v removeFromSuperview];
    }
    // [button removeFromSuperview];
    [pv removeFromSuperview];
    
}


- (void)viewDidUnload
{
    [self setVcStatus:nil];
    [self setVcBoss:nil];
    [self setVcPlayer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
    [ad showStatusView:YES];
    [ad setBgImg:[UIImage imageNamed:@"bg9-2.jpg"] ];
    
    if ([ad readLocalProp:@"showBoss"] == NULL){
        bFirstShow = TRUE;
        WHHttpClient* client = [[WHHttpClient alloc] init:self];
        NSString* url = [[NSString alloc] initWithFormat:@"/wh/hero"];
        [client sendHttpRequest:url selector:@selector(onHeroReturn:) json:YES showWaiting:YES];
        [ad saveLocalProp:@"showBoss" v:@"1"];
        vHeroes.hidden = NO;
    }
    else{
        [vcBoss view ].hidden = YES;
    }


    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/wh/listPlayerToFight" selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
}

- (void) onListHeroesReturn:(NSObject*) data{
    heroList = data;
    [self loadPlayers];
}
- (void) onCloseBossView:(UIButton*) bnt{
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
    [client sendHttpRequest:@"/wh/listHeroes" selector:@selector(onListHeroesReturn:) json:YES showWaiting:YES];
}
@end
