//
//  TestIap.m
//  Warriors' Heaven
//
//  Created by juweihua on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestIap.h"

@implementation TestIap

- (void)requestProUpgradeProductData
{

    NSSet *productIdentifiers = [NSSet setWithObjects: @"com.joycom.xkxj.iap.1000gold", @"com.joycom.xkxj.iap.2000gold", @"com.joycom.xkxj.iap.5000gold", @"com.joycom.xkxj.iap.8000gold", @"com.joycom.xkxj.iap.10000gold", @"com.joycom.xkxj.iap.20000gold", @"com.joycom.xkxj.iap.50000gold", nil ];

    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
    // we will release the request object in the delegate callback
}

#pragma mark -
#pragma mark SKProductsRequestDelegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
//    proUpgradeProduct = [products count] == 1 ? [products objectAtIndex:0]: nil;
//    proUpgradeProduct = [products objectAtIndex:0];
    NSLog(@"---- %d products % invalid products ----", [products count], [response.invalidProductIdentifiers count]);
    for (SKProduct* p in products){
        if (p)
        {
            NSLog(@"Product title: %@" , p.localizedTitle);
            NSLog(@"Product description: %@" , p.localizedDescription);
            NSLog(@"Product price: %@" , p.price);
            NSLog(@"======Product id: %@======" , p.productIdentifier);
        }
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"=====>Invalid product id: %@" , invalidProductId);
    }
    
    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData
//    [productsRequest release];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
}


@end
