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
@end
