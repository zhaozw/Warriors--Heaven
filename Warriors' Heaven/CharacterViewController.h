//
//  CharacterViewController.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"
#import "EGOImageButton.h"
#import "AppDelegate.h"
#import "ObjDetailViewController.h"

@class ObjDetailViewController;
@interface CharacterViewController : UIViewController{
    NSMutableArray* eq_slots;
    NSMutableArray* eq_buttons; 
    EGOImageButton * sloteq_selected; // selected equipment in equipments list
    EGOImageButton * worneq_selected;       // selected equipments on character's body
    EGOImageButton * item_selected;
    UIImageView *vEq_cap;
    UIImageView *vEq_neck;
    UIImageView *vEq_handright;
    UIImageView *vEq_arm;
    UIImageView *vEq_fingersRight;
    UIImageView *vEq_handleft;
    UIImageView *vEq_fingersleft;
    UIImageView *vEq_boots;
    UIImageView *vEq_trousers;
    UIImageView *vEq_armo;
    EGOImageButton *vEqbtn_cap;
    EGOImageButton *vEqbtn_neck;
    EGOImageButton *vEqbtn_handright;
    EGOImageButton *vEqbtn_arm;
    EGOImageButton *vEqbtn_fingersRight;
    EGOImageButton *vEqbtn_handleft;
    EGOImageButton *vEqbtn_fingersleft;
    EGOImageButton *vEqbtn_boots;
    EGOImageButton *vEqbtn_trousers;
    EGOImageButton *vEqbtn_armo;
    UIScrollView* vEqContainer;
    int itemOnDetail;
    NSMutableArray* item_slots;
}
@property (nonatomic, retain) NSMutableArray* positions;
@property (nonatomic, retain) NSDictionary* pos_map;
@property (strong, nonatomic) IBOutlet UIImageView *vItemBg;
@property (nonatomic, retain) NSMutableArray* eq_slots;
@property (nonatomic, retain) NSMutableArray* eq_buttons; 
@property (nonatomic, retain) EGOImageButton * worneq_selected; // current selected worn position
@property (nonatomic, retain) EGOImageButton * sloteq_selected; // current select unworen slot
@property (nonatomic, retain) NSMutableArray* pos_list; // map from uiimageview to string representing pos
@property (nonatomic, retain) NSMutableArray* eq_list;  // map from uibutton to usereq(type=1) object
@property (nonatomic, retain) NSMutableArray* item_list;  // map from uibutton to usereq (type=2) object
@property (nonatomic, retain) NSMutableArray* woren_eq_list;
@property (strong, nonatomic) IBOutlet StatusViewController *vcStatus;
@property (strong, nonatomic) IBOutlet UIImageView *vEquipment;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_cap;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_neck;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_handright;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_arm;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_fingersRight;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_handleft;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_fingersleft;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_boots;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_trousers;
@property (strong, nonatomic) IBOutlet UIImageView *vEq_armo;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_cap;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_neck;
@property (strong, nonatomic) IBOutlet UIImageView *vProfile;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_handright;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_arm;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_fingersRight;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_handleft;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_fingersleft;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_boots;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_trousers;
@property (strong, nonatomic) IBOutlet EGOImageButton *vEqbtn_armo;
@property (strong, nonatomic) IBOutlet UIView *vEqInfoView;
@property (nonatomic, retain) UIScrollView* vLongDescContainer;
@property (nonatomic, retain) UILabel* lbLongDesc; 
@property (nonatomic, retain) UILabel* lbName;
@property (nonatomic, retain) UILabel* lbEffect;
@property (nonatomic, retain) UIButton* btEqDetail;
@property (strong, nonatomic) UIView *vItemInfoView;
@property (strong, nonatomic) UIScrollView* vItemContainer;
@property (nonatomic, retain) UILabel* lbItemLongDesc; 
@property (nonatomic, retain) UILabel* lbItemName;
@property (nonatomic, retain) UILabel* lbItemEffect;
@property (nonatomic, retain) UIScrollView* vItemLongDescContainer;
@property (nonatomic, retain)   UIButton* btItemDetail;
@property (nonatomic, retain) NSMutableArray* item_buttons; // the array hold all egoimagebutton for item
@property (strong, retain) AppDelegate * ad;
@property (strong, nonatomic) IBOutlet UILabel *lbStatus;

@property (strong, nonatomic) IBOutlet ObjDetailViewController *vcObjDetail;

@property (nonatomic, retain)   UIImageView* vProp;
@property (nonatomic, retain)   UILabel* lbStrength;
@property (nonatomic, retain)   UILabel* lbDext;
@property (nonatomic, retain)   UILabel* lbIntellegence;
@property (nonatomic, retain)   UILabel* lbWeight;
@property (nonatomic, retain)   UILabel* lbDamage;
@property (nonatomic, retain)   UILabel* lbDeffencce;
- (IBAction)onSave:(id)sender;
- (int) findEpById:(int)epid;
- (id) findObjById:(int)eqid;
-(void)viewWillAppear:(BOOL)animated ;
- (void) reloadEq;
- (void) reloadEqUI;
- (void) setStatus:(NSString*) s;
@end
