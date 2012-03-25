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

- (id) init:(UIView*)_view {
    self->view = _view;
    return self;
}

//- (void) checkNetworkStatus{
//    
//}

- (void)sendHttpRequest:(NSString*)cmd selector:(SEL)s json:(BOOL)bJSON  showWaiting:(BOOL)bWait{
    
    selector = s;
    _bJSON= bJSON;
    self->_cmd = cmd;
    AppDelegate * ad = [UIApplication sharedApplication].delegate;
    NSString* o = [[ad requests] valueForKey:cmd];
    if (!o || [o isEqualToString:@"0"])
        [[ad requests] setValue:@"1" forKey:cmd];
    else
        return;

       
    
    if (ad.networkStatus == 0){
        [ad checkNetworkStatus];
        if (ad.networkStatus == 0){
            [ad showNetworkDown];
//        [NSTimer scheduledTimerWithTimeInterval:(1.0)target:self selector:@selector(checkNetworkStatus) userInfo:nil repeats:YES];	
            return;
        }
    }
    if(bWait && [ad isWaiting]){
        NSMethodSignature *signature  = [WHHttpClient instanceMethodSignatureForSelector:@selector(sendHttpRequest:selector:showWaiting:)];
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
    [request setHTTPMethod:@"GET"];
   
    //if (ad.session_id != nil)
    //[request addValue:ad.session_id forHTTPHeaderField:@"Cookie"];
    if (cookie)
        [request addValue:cookie forHTTPHeaderField:@"Cookie"];
    else{ // first request
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

/// http request event /////
// 收到响应时, 会触发
// 你可以在里面判断返回结果, 或者处理返回的http头中的信息
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse{
    NSLog(@"Recieve http respnse %@", aResponse.MIMEType);
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
    }
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
}

// 全部数据接收完毕时触发
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn{
    NSString* text =  [[NSString alloc ]initWithData:buf encoding:NSUTF8StringEncoding];
//    lbStatus.text = text;
    NSLog(@"http return content:%@", text);
    
    // parse json
    //NSString* JSONString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    if (_bJSON){
        NSObject *json = [text JSONValue] ;
        if (json)
            [view performSelectorOnMainThread:selector withObject:json waitUntilDone:NO];
        else 
            NSLog(@"data is not json string");
    }else{
        [view performSelectorOnMainThread:selector withObject:text waitUntilDone:NO];
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


@end
