//
//  LightRowView.m
//  Warriors' Heaven
//
//  Created by juweihua on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LightRowView.h"

@implementation LightRowView
@synthesize vLogo;
@synthesize lbTitle;
@synthesize arButtons;
@synthesize vc;
@synthesize lbInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        arButtons = [[NSMutableArray alloc] init];
        
    }
    return self;
}
- (id) initWithController:(UIViewController*) c parent:(UIView*)parent{
    self  = [super init];
    vc = c;
    [parent addSubview:self];
    [self setUserInteractionEnabled:YES];
    return self;
}
- (void) create:(CGRect)frame title:(NSString*)title logo:(NSString*)logo btTitle:(NSString*)btTitle  btnTag:(int)btnTag{
    self.frame = frame;
    vLogo = [[EGOImageButton alloc] initWithFrame:CGRectMake(1, 5, 50, 50)];
    vLogo.tag = btnTag;
    if (logo !=NULL){
        if ([logo hasPrefix:@"http"])
            [vLogo setImageURL:[NSURL URLWithString:logo]];
        else
            [vLogo setImage:[UIImage imageNamed:logo] forState:UIControlStateNormal];
    }
    [self addSubview:vLogo];
    
    lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 80, 25)];
    lbTitle.text = title;
    [lbTitle setBackgroundColor:[UIColor clearColor]];
    [lbTitle setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
    [lbTitle setTextColor:[UIColor whiteColor] ];
    [self addSubview:lbTitle];
    
    lbInfo = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 100, 30)];
    [lbInfo setOpaque:NO];
    [lbInfo setAdjustsFontSizeToFitWidth:NO];
    //[lbLevel setMinimumFontSize:8.0f];
    [lbInfo setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [lbInfo setTextColor:[UIColor yellowColor]];
    [lbInfo setBackgroundColor:[UIColor clearColor]];
   // [lbInfo setText:[[NSString alloc] initWithFormat:@"Level %@", level]];
    [self addSubview:lbInfo];
    
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(250, 20, 60, 30)];
    [btn setTitle:btTitle forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
    btn.tag = btnTag;
    [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [self addSubview:btn];
    [arButtons addObject:btn];
    
    
    
    
}

- (UIButton*) button:(int) i{
    return  [arButtons objectAtIndex:i];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
