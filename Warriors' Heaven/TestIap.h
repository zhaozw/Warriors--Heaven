//
//  TestIap.h
//  Warriors' Heaven
//
//  Created by juweihua on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface TestIap : NSObject <SKProductsRequestDelegate>{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
}
- (void)requestProUpgradeProductData;
@end
