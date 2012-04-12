//
//  WHHttpClient.h
//  Warriors' Heaven
//
//  Created by juweihua on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHHttpClient : NSObject{
    UIView   *view;
    // handle http request
    NSMutableData* buf;
    NSString * cookie;
    SEL selector; // callback after finishing receive data
    SEL response; // callback to handle response 
    BOOL _bJSON;
    NSString* _cmd;

    
}
- (id) init:(UIView*)_view;
- (void) postHttpRequest:(NSString*)cmd data:(NSString*)data selector:(SEL)s json:(BOOL)bJSON  showWaiting:(BOOL)bWait;
- (void)sendHttpRequest:(NSString*)cmd selector:(SEL)s json:(BOOL)bJSON showWaiting:(BOOL)bWait;
// handle network
// 收到响应时, 会触发
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse;
// 你可以在里面判断返回结果, 或者处理返回的http头中的信息

// 每收到一次数据, 会调用一次
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data;


// 当然buffer就是前面initWithRequest时同时声明的.

// 网络错误时触发
- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error;

// 全部数据接收完毕时触发
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn;

- (void) setResponseHandler:(SEL )callback;
@end
