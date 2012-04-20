//
//  LightRowView.h
//  Warriors' Heaven
//
//  Created by juweihua on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface LightRowView : UIImageView
@property (nonatomic, strong) EGOImageView * vLogo;
@property (nonatomic, strong) NSMutableArray * arButtons;
@property (nonatomic, strong) UILabel * lbTitle;
@property (nonatomic, strong) UILabel * lbInfo;
@property (nonatomic, strong) UIViewController * vc;
- (id) initWithController:(UIViewController*) c parent:(UIView*)parent;
- (void) create:(CGRect)frame title:(NSString*)title logo:(NSString*)logo btTitle:(NSString*)btTitle  btnTag:(int)btnTag;
- (UIButton*) button:(int) i;
@end
