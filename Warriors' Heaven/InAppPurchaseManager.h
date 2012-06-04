//
//  InAppPurchaseManager.h
//  Warriors' Heaven
//
//  Created by juweihua on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#define kInAppPurchaseManagerProductsFetchedNotification@"kInAppPurchaseManagerProductsFetchedNotification"

@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate,SKPaymentTransactionObserver>  
{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
}
- (void)requestProUpgradeProductData;
@end
