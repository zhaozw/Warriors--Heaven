//
//  InAppPurchaseManager.m
//  Warriors' Heaven
//
//  Created by juweihua on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InAppPurchaseManager.h"
#define ProductID_IAP1kGold @"com.joyqom.wh.gold"           // 1000 gold for $0.99 1/1000
#define ProductID_IAP2kGold @"com.joyqom.wh.2000gold"       // 2000 gold for $0.99 0.5/1000 (only on sale)
//#define ProductID_IAP1kGold @"com.joyqom.wh.2500gold"       // 2500 gold for $1.99 0.8/1000
#define ProductID_IAP5kGold @"com.joyqom.wh.5000gold"       // 5000 gold for $2.99 0.6/1000 ($1.99 0.4/1000 on sale)
#define ProductID_IAP8kGold @"com.joyqom.wh.8000gold"       // 8000 gold for $3.99 0.5/1000
#define ProductID_IAP10kGold @"com.joyqom.wh.10000gold"      // 10000 gold for $4.99 0.5/1000
#define ProductID_IAP20kGold @"com.joyqom.wh.20000gold"      // 20000 gold for $7.99 0.4/1000
#define ProductID_IAP50kGold @"com.joyqom.wh.50000gold"      // 50000 gold for $14.99 0.3/1000

/* ---------------------
normal:                  onsale:
 1000 for $0.99                 2000 for 0.99
 5000 for $2.99                 5000 for $1.99
 8000 for $3.99                 
 10000 for $4.99                 
 20000 for $7.99                 
 50000 for $14.99                 
 --------------------------
 */

@implementation InAppPurchaseManager

-(id)init   {
    if ((self = [super init])) {   
           [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}
// testuser1 Jujujuju1
- (void)requestProUpgradeProductData
{
    NSLog(@"---------请求对应的产品信息------------");    
    NSArray *product = nil;    
    switch (buyType) {    
        case IAP1000G:    
            product=[[NSArray alloc] initWithObjects:ProductID_IAP1kGold,nil];    
            break;    
        case IAP2000G:    
            product=[[NSArray alloc] initWithObjects:ProductID_IAP2kGold,nil];    
            break;    
        case IAP5000G:    
            product=[[NSArray alloc] initWithObjects:ProductID_IAP5kGold,nil];    
            break;    
        case IAP8000G:    
            product=[[NSArray alloc] initWithObjects:ProductID_IAP8kGold,nil];    
            break;    
        case IAP10000G:    
            product=[[NSArray alloc] initWithObjects:ProductID_IAP10kGold,nil];    
            break;    
        case IAP20000G:    
            product=[[NSArray alloc] initWithObjects:ProductID_IAP20kGold,nil];    
            break;    
        case IAP50000G:    
            product=[[NSArray alloc] initWithObjects:ProductID_IAP50kGold,nil];    
            break;    
        default:    
            break;    
    }    
    NSSet *nsset = [NSSet setWithArray:product];    
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.joycom.wh.iap.gold" ];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
    // we will release the request object in the delegate callback
}

#pragma mark -
#pragma mark SKProductsRequestDelegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    /*
    NSArray *products = response.products;
    proUpgradeProduct = [products count] == 1 ? [products objectAtIndex:0] : nil;
    if (proUpgradeProduct)
    {
        NSLog(@"Product title: %@" , proUpgradeProduct.localizedTitle);
        NSLog(@"Product description: %@" , proUpgradeProduct.localizedDescription);
        NSLog(@"Product price: %@" , proUpgradeProduct.price);
        NSLog(@"Product id: %@" , proUpgradeProduct.productIdentifier);
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData
//    [productsRequest release];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
    */
    NSLog(@"-----------收到产品反馈信息--------------");    
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);    
    NSLog(@"产品付费数量: %d", [myProduct count]);    
    // populate UI     
    for(SKProduct *product in myProduct){    
        NSLog(@"product info");    
        NSLog(@"SKProduct 描述信息%@", [product description]);       
        NSLog(@"产品标题 %@" , product.localizedTitle);    
        NSLog(@"产品描述信息: %@" , product.localizedDescription);    
        NSLog(@"价格: %@" , product.price);    
        NSLog(@"Product id: %@" , product.productIdentifier);     
    }     
    SKPayment *payment = nil;     
    switch (buyType) {    
        case IAP1000G:    
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP1kGold];    //支付$0.99    
            break;    
        case IAP2000G:    
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP2kGold];    //支付$1.99    
            break;    
        case IAP5000G:    
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP5kGold];    //支付$9.99    
            break;    
        case IAP8000G:    
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP8kGold];    //支付$19.99    
            break;    
        case IAP10000G:    
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP10kGold];    //支付$29.99    
            break;    
        case IAP20000G:    
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP20kGold];    //支付$29.99    
            break;    
        case IAP50000G:    
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP50kGold];    //支付$29.99    
            break;    
        default:    
            break;    
    }    
    NSLog(@"---------发送购买请求------------");    
    [[SKPaymentQueue defaultQueue] addPayment:payment];  
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果    
{    
    NSLog(@"-----paymentQueue--------");    
    for (SKPaymentTransaction *transaction in transactions)    
    {    
        switch (transaction.transactionState)    
        {     
            case SKPaymentTransactionStatePurchased:{//交易完成     
                [self completeTransaction:transaction];    
                NSLog(@"-----交易完成 --------");    
                NSLog(@"不允许程序内付费购买");     
                UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Alert"     
                                                                    message:@"Himi说你购买成功啦～娃哈哈"                                                          
                                                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"Close（关闭）",nil) otherButtonTitles:nil];    
                
                [alerView show];    
               
                break; 
            }
            case SKPaymentTransactionStateFailed:{//交易失败     
             [self failedTransaction:transaction];    
                NSLog(@"-----交易失败 --------");    
                UIAlertView *alerView2 =  [[UIAlertView alloc] initWithTitle:@"Alert"     
                                                                     message:@"Himi说你购买失败，请重新尝试购买～"                                                          
                                                                    delegate:nil cancelButtonTitle:NSLocalizedString(@"Close（关闭）",nil) otherButtonTitles:nil];    
                
                [alerView2 show];    
                    
                break; 
            }
            case SKPaymentTransactionStateRestored://已经购买过该商品     
                [self restoreTransaction:transaction];    
                NSLog(@"-----已经购买过该商品 --------");    
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表    
                NSLog(@"-----商品添加进列表 --------");    
                break;    
            default:    
                break;    
        }    
    }    
}    
- (void) completeTransaction: (SKPaymentTransaction *)transaction    

{    
    NSLog(@"-----completeTransaction--------");    
    // Your application should implement these two methods.    
    NSString *product = transaction.payment.productIdentifier;    
    if ([product length] > 0) {    
        
        NSArray *tt = [product componentsSeparatedByString:@"."];    
        NSString *bookid = [tt lastObject];    
        if ([bookid length] > 0) {    
            [self recordTransaction:bookid];    
            [self provideContent:bookid];    
        }    
    }    
    
    // Remove the transaction from the payment queue.    
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];    
    
}    

//记录交易    
-(void)recordTransaction:(NSString *)product{    
    NSLog(@"-----记录交易--------");    
}    

//处理下载内容    
-(void)provideContent:(NSString *)product{    
    NSLog(@"-----下载--------");     
}    

- (void) failedTransaction: (SKPaymentTransaction *)transaction{    
    NSLog(@"失败");    
    if (transaction.error.code != SKErrorPaymentCancelled)    
    {    
    }    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];    
    
    
}    
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{    
    
}    

- (void) restoreTransaction: (SKPaymentTransaction *)transaction    

{    
    NSLog(@" 交易恢复处理");    
    
}    

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{    
    NSLog(@"-------paymentQueue----");    
}    


#pragma mark connection delegate    
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data    
{    
    NSLog(@"%@",  [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] self]);     
}    
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{    
    
}    

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{    
    switch([(NSHTTPURLResponse *)response statusCode]) {    
        case 200:    
        case 206:    
            break;    
        case 304:     
            break;    
        case 400:     
            break;      
        case 404:    
            break;    
        case 416:    
            break;    
        case 403:    
            break;    
        case 401:    
        case 500:    
            break;    
        default:    
            break;    
    }            
}    

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {    
    NSLog(@"test");    
}    

//弹出错误信息    
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{    
    NSLog(@"-------弹出错误信息----------");    
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",NULL) message:[error localizedDescription]    
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];    
    [alerView show];    
//    [alerView release];    
}    

-(void) requestDidFinish:(SKRequest *)request     
{    
    NSLog(@"----------反馈信息结束--------------");    
    
}    

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{    
    NSLog(@"-----PurchasedTransaction----");    
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];    
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];    
//    [transactions release];    
}
@end
