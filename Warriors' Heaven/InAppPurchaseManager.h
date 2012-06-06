//
//  InAppPurchaseManager.h
//  Warriors' Heaven
//
//  Created by juweihua on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#import "AppDelegate.h"

@class AppDelegate;
#define kInAppPurchaseManagerProductsFetchedNotification@"kInAppPurchaseManagerProductsFetchedNotification"
enum{  
    IAP1000G=10,  
    IAP2000G,  
    IAP5000G,  
    IAP8000G,   
    IAP10000G,  
    IAP20000G,
    IAP50000G,
}buyCoinsTag;  

@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate,SKPaymentTransactionObserver>  
{
     int buyType;  
//    SKProduct *proUpgradeProduct;
//    SKProductsRequest *productsRequest;
    id caller;
    SEL sel;
    NSString* token_name;
    NSString* token_value;
    AppDelegate *ad;
    NSObject* response;
}
//+(CCScene *) scene;    
- (void) requestProUpgradeProductData;  
-(void)RequestProductData;  
-(bool)CanMakePay;                               
-(void)buy:(int)type;   
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;  
-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction;  
- (void) completeTransaction: (SKPaymentTransaction *)transaction;  
- (void) failedTransaction: (SKPaymentTransaction *)transaction;  
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction;  
-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error;  
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;  
-(void)provideContent:(NSString *)product;  
-(void)recordTransaction:(NSString *)product;  

- (void) purchase:(NSString*) pid  tname:(NSString*)tname tvalue:(NSString*)tvalue;
- (void) setCallback:(id)_id sel:(SEL)_sel;
- (NSString*) calcKey:(NSString* )tid;
@end
