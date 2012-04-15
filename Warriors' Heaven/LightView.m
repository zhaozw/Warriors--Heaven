//
//  LightView.m
//  Warriors' Heaven
//
//  Created by juweihua on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LightView.h"
#import "EGOImageButton.h"
#import <objc/runtime.h>

@implementation LightView
@synthesize margin_top;

- (void) init1{
    currentX = 0;
    currentY = 0;
    rows = [[NSMutableArray alloc] init];
    margin_top = 10;
//    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self init1];
    }
    return self;
}

- (void) removeAllRow{
    
    for (int i = 0; i< [rows count];i++){
        UIView * v = [rows objectAtIndex:i];
        [v removeFromSuperview];
    }
    currentX = 0;
    currentY = 0;
    margin_top = 10;
    [rows removeAllObjects];
  //  CGRect r = self .frame ;
    //r.size.height = 50;
    //self.frame = r;
}
- (void) setController:(UIViewController*) c{
    vc = c;
}
/*
 row->
    bgImage
    bgColor
    titleImage
    height
    margin
    title
    children ->[
                {nodeName:label, left, top, width, height, text},
                {nodename:progress, left, top, width, height, value},
                
                ]
    buttons->[
                {text, bgImage, bgColor, font}
                {..}
                ]
 */
- (void) addRow:(NSObject*) data
{
    if ([rows count] == 0)
        currentY = margin_top;
    NSString* bgImage = [data valueForKey:@"bgImage"];
    NSString* bgColor = [data valueForKey:@"bgColor"];
    NSString* titleImage = [data valueForKey:@"titleImage"];
    int row_height = 70;
    NSString* height = [data valueForKey:@"height"];
    if (height)
     row_height = [height intValue];
    NSString* _margin = [data valueForKey:@"margin"];
    int margin = 2;
    if (_margin)
        margin = _margin.intValue;
    NSString* title = [data valueForKey:@"title"];
    
    NSArray* buttons =[ data valueForKey:@"buttons"] ;
//  NSString* buttonText = [[[buttons objectAtIndex:0] valueForKey:@"text"];
    
    NSArray* children = [data valueForKey:@"children"];
    
    UIImageView* row = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImage]];
    row.frame = CGRectMake(0, currentY, 320, row_height);
    row.backgroundColor = [UIColor clearColor];
    [row setUserInteractionEnabled:YES];
    
    EGOImageButton* bt_logo = [[EGOImageButton alloc] initWithFrame:CGRectMake(2, 1, 60, 60)];
    [row addSubview:bt_logo];
    [bt_logo setImageURL:[NSURL URLWithString:titleImage]];
    
    UILabel* questName = [[UILabel alloc] initWithFrame:CGRectMake(65, 15, 100, 20)];
    [row addSubview:questName];
    [questName setText:title];
    [questName setBackgroundColor:[UIColor clearColor]];
    [questName setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [questName setTextColor:[UIColor whiteColor] ];
    
    
    for (int i = 0; i < [children count]; i++){
        NSDictionary *d = [children objectAtIndex:i];
        NSString* nodeName = [d valueForKey:@"nodeName"];
        if ([nodeName isEqualToString:@"progress"]){
            NSString* t = [d valueForKey:@"text"];
            NSString* _bgColor = [d valueForKey:@"bgColor"];
            UIColor *bgColor = [UIColor clearColor];
            int numberOflines = 1;
            NSString* _lines = [d valueForKey:@"numberOfLInes"];
            if (_lines)
                numberOflines = [_lines intValue];
            if (_bgColor)
                bgColor = [UIColor clearColor];
            UIColor *color = [UIColor yellowColor];
            NSString* textColor = [d valueForKey:@"color"];
            if (textColor)
                color = [UIColor blackColor];
            int left = 2;
            int top = 62;
            int width = 60;
            int height = 10;
            int value = 0;
            NSString *_value = [d valueForKey:@"value"];
            if (_value)
                value = [_value intValue];
            
            
            NSString* _left = [d valueForKey:@"left"];
            if (_left)
                left = [_left intValue];
            NSString* _top = [d valueForKey:@"top"];
            if (_top)
                top = [_top intValue];
            NSString* _width = [d valueForKey:@"width"];
            if (_width)
                width = [_width intValue];
            NSString* _height = [d valueForKey:@"height"];
            if (_height)
                height = [_height intValue];
            
            
            UIProgressView* pv = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            pv.frame = CGRectMake(left, top, width, height);
            [pv setProgress:value/100.0f];
            [row addSubview:pv];


            
        }else if ([nodeName isEqualToString:@"label"]){
            NSString* t = [d valueForKey:@"text"];
            NSString* _bgColor = [d valueForKey:@"bgColor"];
            UIColor *bgColor = [UIColor clearColor];
            int numberOflines = 1;
            NSString* _lines = [d valueForKey:@"numberOfLInes"];
            if (_lines)
                numberOflines = [_lines intValue];
            if (_bgColor)
                bgColor = [UIColor clearColor];
            UIColor *color = [UIColor yellowColor];
            NSString* textColor = [d valueForKey:@"color"];
            if (textColor)
                color = [UIColor blackColor];
            int left = 65;
            int top = 35;
            int width = 200;
            int height = 30;
            
            
            NSString* _left = [d valueForKey:@"left"];
            if (_left)
                left = [_left intValue];
            NSString* _top = [d valueForKey:@"top"];
            if (_top)
                top = [_top intValue];
            NSString* _width = [d valueForKey:@"width"];
            if (_width)
                width = [_width intValue];
            NSString* _height = [d valueForKey:@"height"];
            if (_height)
                height = [_height intValue];
            
            UILabel* lb_desc = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, height)];
            [row addSubview:lb_desc];
            [lb_desc setText:t];
            [lb_desc setBackgroundColor:bgColor];   
            [lb_desc setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
            [lb_desc setNumberOfLines:numberOflines];
            [lb_desc setTextColor: color];
        }
    }

    for (int i = 0; i< [buttons count]; i++){
         NSDictionary *d = [buttons objectAtIndex:i];
        NSString* t = [d valueForKey:@"text"];
        NSString* bgImage = [d valueForKey:@"bgImage"];
        NSString* _bgColor = [d valueForKey:@"bgColor"];
        UIColor *bgColor = [UIColor clearColor];
        NSString* _tag = [d valueForKey:@"tag"];
        int numberOflines = 1;
        NSString* _lines = [d valueForKey:@"numberOfLInes"];
        if (_lines)
            numberOflines = [_lines intValue];
        if (_bgColor)
            bgColor = [UIColor clearColor];
        UIColor *color = [UIColor yellowColor];
        NSString* textColor = [d valueForKey:@"color"];
        if (textColor)
            color = [UIColor blackColor];
        int left = 250;
        int top = 20;
        int width = 60;
        int height = 30;
        
        NSString* _left = [d valueForKey:@"left"];
        if (_left)
            left = [_left intValue];
        NSString* _top = [d valueForKey:@"top"];
        if (_top)
            top = [_top intValue];
        NSString* _width = [d valueForKey:@"width"];
        if (_width)
            width = [_width intValue];
        NSString* _height = [d valueForKey:@"height"];
        if (_height)
            height = [_height intValue];
        UIButton* btn_ask = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSString* callback = [d valueForKey:@"callback"];
        
        btn_ask.frame = CGRectMake(left, top, width, height);
        [row addSubview: btn_ask];
        [btn_ask setTitle:t forState:UIControlStateNormal];
        [btn_ask setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
        [btn_ask addTarget:vc action: NSSelectorFromString(callback) forControlEvents:UIControlEventTouchUpInside];
        [btn_ask.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        if (_tag)
            btn_ask.tag = [_tag intValue];
        else 
            btn_ask.tag = [rows count];
        [row bringSubviewToFront:btn_ask];
        
    }
    
    [self addSubview:row];
    [rows addObject:row];
    
    currentY += row_height + margin;
    CGRect rect = self.frame;
    if ( currentY > rect.size.height){
        rect.size.height = currentY;
        self.frame = rect;
    }
    
    
    
   
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
