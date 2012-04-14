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
    NSMutableArray*  rows;
    UIViewController* vc;

}
@property (nonatomic, assign) int margin_top;
- (void) addRow:(NSObject*) data;
- (void) setController:(UIViewController*) c;
- (void) init1;

- (void) removeAllRow;
@end
