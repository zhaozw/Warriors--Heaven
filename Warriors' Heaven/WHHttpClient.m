//
//  WHHttpClient.m
//  Warriors' Heaven
//
//  Created by juweihua on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WHHttpClient.h"
#import "AppDelegate.h"
#import "SBJson.h"

@implementation WHHttpClient

- (id) init:(id)_view {
    sync = FALSE;
    self->view = _view;
    return self;
}

- (void) setResponseHandler:(SEL )callback{
    self->response = callback;
}

//- (void) checkNetworkStatus{
//    
//}
- (void) setSync:(BOOL) _sync{
    sync = _sync;
}
- (void) postHttpRequest:(NSString*)cmd data:(NSString*)data selector:(SEL)s json:(BOOL)bJSON  showWaiting:(BOOL)bWait{
    _selector = s;
    _bJSON= bJSON;
    self->_cmd =  [cmd stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    cmd = self->_cmd;
    _bWait = bWait;
    
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    // check network status
    if (ad.networkStatus == 0){
        [ad checkNetworkStatus];
        if (ad.networkStatus == 0){
            [ad showNetworkDown];
            //        [NSTimer scheduledTimerWithTimeInterval:(1.0)target:self selector:@selector(checkNetworkStatus) userInfo:nil repeats:YES];	
            return;
        }
    }
    
    // set flag
    NSString* o = [[ad requests] valueForKey:cmd];
    if (!o || [o isEqualToString:@"0"])
        [[ad requests] setValue:@"1" forKey:cmd];
    else
        return;
    
    
    
    
    if(bWait && [ad isWaiting]){
        NSMethodSignature *signature  = [WHHttpClient instanceMethodSignatureForSelector:@selector(postHttpRequest:selector:json:showWaiting:)];
        NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];
        
        [invocation setTarget:self];                    // index 0 (hidden)
        [invocation setSelector:@selector(sendHttpRequest:selector:showWaiting:)];                  // index 1 (hidden)
        [invocation setArgument:&cmd atIndex:2];      // index 2
        [invocation setArgument:&s atIndex:3];      // index 3
        [invocation setArgument:&bWait atIndex:4];      // index 3
        // [self performSelector:@selector(sendHttpRequest:::) withObject:cmd withObject:s withObject:bWait afterDelay:1];
        [NSTimer scheduledTimerWithTimeInterval:1 invocation:invocation repeats:NO];
        return;
    }
    // send request
    self->buf = [[NSMutableData alloc] initWithLength:0];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];   
    NSLog([NSString stringWithFormat:@"http://%@:%@%@", ad.host, ad.port, cmd]);
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@%@", ad.host, ad.port, cmd]]];
    [request setHTTPMethod:@"POST"];
   // if (bJSON)
     //   [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];  
    NSData *postData = [data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]; 
    [request setValue:[[NSNumber numberWithInt:[postData length]]stringValue] forHTTPHeaderField:@"Content-Length"]; 
    [request setHTTPBody:postData];  
    
//    if (ad.session_id != nil)
//        [request addValue:ad.session_id forHTTPHeaderField:@"Cookie"];
    
    // set cookie
    NSArray                 *cookies;
    NSDictionary            *cookieHeaders;
    cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ]
               cookiesForURL:request.URL];
    
//    NSLog(@"%@ cookies = %@", request.URL, cookies);
    cookieHeaders = [ NSHTTPCookie requestHeaderFieldsWithCookies: cookies ];
    NSString* cookie = [ cookieHeaders objectForKey: @"Cookie" ];   
    
    if (cookie)
        [request addValue:cookie forHTTPHeaderField:@"Cookie"];
    else{ // first request, set session id in cookie
        if (ad.session_id != nil){
            NSString * c = [[NSString alloc] initWithFormat:@"_wh_session=%@;", ad.session_id];
            NSLog(@"First request cookie:%@", c);
            [request addValue:c forHTTPHeaderField:@"Cookie"];
        }
    }
    //  NSMutableData* buf = [[NSMutableData alloc] initWithLength:0];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"send cmd to http server: %@", cmd);
    //    NSString * s = [[NSString alloc] initWithString:statusView.text];
    //  lbStatus.text = [NSString stringWithFormat:@"%@ send cmd to http server: %@", lbStatus.text, cmd];
    //  [connection release];
    
    //[request release];
    
    // display waiting dialog
    if (bWait)
        [ad showWaiting:YES];


}
- (void)sendHttpRequest:(NSString*)cmd selector:(SEL)s json:(BOOL)bJSON  showWaiting:(BOOL)bWait{
    
    _selector = s;
    _bJSON= bJSON;
    self->_cmd = [cmd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    cmd = self->_cmd;
    _bWait = bWait;
    
    AppDelegate * ad = [UIApplication sharedApplication].delegate;

    // check network status
    if (ad.networkStatus == 0){
        [ad checkNetworkStatus];
        if (ad.networkStatus == 0){
            [ad showNetworkDown];
            //        [NSTimer scheduledTimerWithTimeInterval:(1.0)target:self selector:@selector(checkNetworkStatus) userInfo:nil repeats:YES];	
            NSLog(@"Network down");
            if (retry){
                [self performSelector:@selector(retryRequest) withObject:NULL afterDelay:3];
            }
            return;
        }
    }

       
    

    if(bWait && [ad isWaiting]){
        NSMethodSignature *signature  = [WHHttpClient instanceMethodSignatureForSelector:@selector(sendHttpRequest:selector:json:showWaiting:)];
        NSInvocation      *invocation = [NSInvocation invocationWithMethodSignature:signature];
        
        [invocation setTarget:self];                    // index 0 (hidden)
        [invocation setSelector:@selector(sendHttpRequest:selector:json:showWaiting:)];                  // index 1 (hidden)
        [invocation setArgument:&cmd atIndex:2];      // index 2
        [invocation setArgument:&s atIndex:3];      // index 3
        [invocation setArgument:&bJSON atIndex:4];
        [invocation setArgument:&bWait atIndex:5];      // index 3
       // [self performSelector:@selector(sendHttpRequest:::) withObject:cmd withObject:s withObject:bWait afterDelay:1];
        [NSTimer scheduledTimerWithTimeInterval:1 invocation:invocation repeats:NO];
        NSLog(@"busy, will retry in 1 second, quest=%@", cmd);
        return;
    }
    
   
    // set flag
    NSString* o = [[ad requests] valueForKey:cmd];
    if (!o || [o isEqualToString:@"0"])
        [[ad requests] setValue:@"1" forKey:cmd];
    else{
        NSLog(@"Duplicate quest not responding");
        return;
    }
    

    // send request
    self->buf = [[NSMutableData alloc] initWithLength:0];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];   
    NSLog([NSString stringWithFormat:@"http://%@:%@%@", ad.host, ad.port, cmd]);
    
    if ([cmd hasPrefix:@"http://"])
        [request setURL:[NSURL URLWithString:cmd]];
    else
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@%@", ad.host, ad.port, cmd]]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
   
    //if (ad.session_id != nil)
    //[request addValue:ad.session_id forHTTPHeaderField:@"Cookie"];
    NSArray                 *cookies;
    NSDictionary            *cookieHeaders;
    cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ]
               cookiesForURL:request.URL];
    

//        NSLog(@"%@ cookies = %@", request.URL, cookies);
    cookieHeaders = [ NSHTTPCookie requestHeaderFieldsWithCookies: cookies ];
    NSString* cookie = [ cookieHeaders objectForKey: @"Cookie" ];   
    if (cookie)
        [request addValue:cookie forHTTPHeaderField:@"Cookie"];
    else{ // first request
        if (ad.session_id != nil){
            NSString * c = [[NSString alloc] initWithFormat:@"_wh_session=%@;", ad.session_id];
            NSLog(@"First request cookie:%@", c);
            [request addValue:c forHTTPHeaderField:@"Cookie"];
        }
    }

    
    // display waiting dialog
    if (bWait)
        [ad showWaiting:YES];
 
    
    //  NSMutableData* buf = [[NSMutableData alloc] initWithLength:0];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"send cmd to http server: %@", cmd);
    //    NSString * s = [[NSString alloc] initWithString:statusView.text];
  //  lbStatus.text = [NSString stringWithFormat:@"%@ send cmd to http server: %@", lbStatus.text, cmd];
    //  [connection release];
    
    //[request release];
    

}

/// http request event /////
// 收到响应时, 会触发
// 你可以在里面判断返回结果, 或者处理返回的http头中的信息
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse{

    NSLog(@"Recieve http respnse %@, %@", aResponse.MIMEType, aResponse);
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)aResponse;
    NSDictionary *fields = [HTTPResponse allHeaderFields];
//    NSLog(@"HTTP HEADER %@", fields);
    
//    NSLog(@"POLiCY %d", [[ NSHTTPCookieStorage sharedHTTPCookieStorage ] cookieAcceptPolicy]);
    if ([[ NSHTTPCookieStorage sharedHTTPCookieStorage ] cookieAcceptPolicy] != NSHTTPCookieAcceptPolicyAlways)
    [NSHTTPCookieStorage sharedHTTPCookieStorage].cookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
    NSArray* _cookies =  [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[HTTPResponse URL] ];
    
    NSArray *cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ]
               cookiesForURL:[HTTPResponse URL] ];
    NSString* homeUrl = [NSString stringWithFormat:@"http://%@:%@/", HTTPResponse.URL.host, HTTPResponse.URL.port];
//    if (cookies)
//    for (int i = 0; i < [cookies count]; i++)
//        [[ NSHTTPCookieStorage sharedHTTPCookieStorage ] deleteCookie:[cookies objectAtIndex:i]];
//    
    [[ NSHTTPCookieStorage sharedHTTPCookieStorage ]
     setCookies: _cookies forURL: [HTTPResponse URL] mainDocumentURL: [NSURL URLWithString:homeUrl ] ];
    NSLog(@"%@ cookie2:%@", [HTTPResponse URL] ,_cookies);
//    {
//    NSArray                 *cookies;
//    NSDictionary            *cookieHeaders;
//    cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ]
//               cookiesForURL:[HTTPResponse URL] ];
//    
//    //        if (!cookies){
//    //            
//    //        }
//    NSLog(@"%@ cookies = %@", [HTTPResponse URL], cookies);
//        
//    }
//    
    
//    cookie = _cookies;
/* 
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)aResponse;
    NSDictionary *fields = [HTTPResponse allHeaderFields];
    NSString *_cookie = [fields valueForKey:@"Set-Cookie"]; 
    NSLog(@"set-cookie:%@", _cookie);
    
  if (_cookie){
        self->cookie = _cookie;
        AppDelegate * ad = [UIApplication sharedApplication].delegate;
        if (ad.session_id == nil){
            NSString *regExStr = @"_wh_session=(.*?);";
            NSError *error = NULL;
            
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExStr
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:&error];
            
            [regex enumerateMatchesInString:cookie options:0 range:NSMakeRange(0, [cookie length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                NSLog(@"session id=%@",[cookie substringWithRange:[result rangeAtIndex:1]]);
                
                ad.session_id = [cookie substringWithRange:[result rangeAtIndex:1]];
                NSLog(@"session id=%@", ad.session_id);
                // persist
                NSArray *Array = [NSArray arrayWithObjects:ad.session_id, nil];
                NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
                [SaveDefaults setObject:Array forKey:@"sessionid"];
                
            }];
        }
    }*/
    if (self->response)
        [self->view performSelector:response withObject:aConnection withObject:aResponse ];

}
// 每收到一次数据, 会调用一次
// 因此一般来说,是
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data
{
    [buf appendData:data];
    
  //  [[[UIApplication sharedApplication].delegate window] bringSubviewToFront:self->waiting];
}
// 当然buffer就是前面initWithRequest时同时声明的.

// 网络错误时触发
- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error{
    NSLog(@"http receive error:%d", error.code);
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    if([ad isWaiting])
        [ad showWaiting:FALSE];
    [ad showNetworkDown];
    [[ad requests] setValue:@"0" forKey:self->_cmd];

    if (retry){
        [self performSelector:@selector(retryRequest) withObject:NULL afterDelay:3];
    }
    
}

- (void) retryRequest{
    [self sendHttpRequest:self->_cmd selector:_selector json:_bJSON showWaiting:_bWait];

}

// 全部数据接收完毕时触发
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn{
    NSString* text =  [[NSString alloc ]initWithData:buf encoding:NSUTF8StringEncoding];
//    lbStatus.text = text;
    NSLog(@"%@ return content:%@", self->_cmd, text);
    
    // parse json
    //NSString* JSONString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    if (_bJSON){
        NSObject *json = [text JSONValue] ;
        if (json && ([json isKindOfClass:[NSDictionary class]] ||
                     [json isKindOfClass:[NSArray class]]))
            [view performSelectorOnMainThread:_selector withObject:json waitUntilDone:NO];
        else {
            NSLog(@"data is not json string");
            if (retry){
                [self performSelector:@selector(retryRequest) withObject:NULL afterDelay:3];
            }
        }
    }else{
        [view performSelectorOnMainThread:_selector withObject:text waitUntilDone:NO];
    }
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    if([ad isWaiting])
        [ad showWaiting:FALSE];

    [[ad requests] setValue:@"0" forKey:self->_cmd];
    /*
    NSString * v;
    if (v = [json valueForKey:@"user"])
    {
        NSLog(@"user=%@", v);
        //     NSObject *json_user = [v JSONValue];
        
        if (v = [v valueForKey:@"user"])
            lbUserName.text = v;
        NSLog(@"username=%@", v);
    }
    if (self->waiting){
        [self->waiting setHidden:true];
        [self->waiting removeFromSuperview];
        self->waiting = Nil;
    }
    //[self.view setNeedsDisplay];
    [self->view performSelectorOnMainThread:selector withObject:nil waitUntilDone:false];*/
}
- (void) setRetry:(BOOL) b{
    retry = b;
}

@end
