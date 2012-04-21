//
//  Lunar.h
//  Warriors' Heaven
//
//  Created by juweihua on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lunar : NSObject
//@property (nonatomic, strong) NSString* sNongliDay;
@property (nonatomic, strong) NSString* sMonthName;
@property (nonatomic, strong) NSString* sDayname;
@property (nonatomic, strong) NSString* sShuXiang;
@property (nonatomic, strong) NSString* sYear;
@property (nonatomic, strong) NSString* sJieqi;
+(id)LunarForSolar:(NSDate *)solarDate;
+(NSString*)jieqiFromDate:(NSDate*) date;
@end
