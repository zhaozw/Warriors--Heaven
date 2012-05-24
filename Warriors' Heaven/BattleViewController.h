//
//  BattleViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"
#import "AppDelegate.h"
#import "BossViewController.h"

@interface BattleViewController : UIViewController{
    UIView* vPlayers;
    UIView* vHeroes;
    UIView* vHeroList;
    NSArray* playerList;
    NSArray* heroList;
}
@property (strong, nonatomic) IBOutlet StatusViewController *vcStatus;
@property (strong, nonatomic) IBOutlet BossViewController *vcPlayer;

@property (nonatomic, retain) NSObject* fight_result;
@property (strong, nonatomic) IBOutlet BossViewController *vcBoss;

@property (strong, retain) AppDelegate *ad;
@property (nonatomic, strong) NSMutableArray *players;
@end
