//
//  LightView.h
//  Warriors' Heaven
//
//  Created by juweihua on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LightView : UIView{
    int currentX;
    int currentY;
    int default_row_height;
    NSMutableArray*  rows;
    UIViewController* vc;

}
@property (nonatomic, assign) int margin_top;
@property (nonatomic, assign) int currentY;
- (void) addRow:(NSObject*) data;
- (void) setController:(UIViewController*) c;
- (void) init1;
+ (UILabel*) createLabel:(CGRect)frame parent:(UIView*)parent text:(NSString*) text textColor:(UIColor*) textColor;
+(UIImageView*) createImageView:(NSString*) img frame:(CGRect)frame parent:(UIView*)parent;
-(UIImageView*) createImageViewAsRow:(NSString*) img frame:(CGRect)frame;
- (void) removeAllRow;
- (id) addRowView:(NSString*)title logo:(NSString*)logo btTitle:(NSString*)btTitle  btnTag:(int)btnTag;

+(id) createButton:(CGRect)frame parent:(UIView*)parent text:(NSString*) text tag:(int)tag;
- (void) deleteRow:(UIView*) r;
+ (void) removeAllSubview:(UIView*)v;
@end
