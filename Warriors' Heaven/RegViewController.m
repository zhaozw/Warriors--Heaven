//
//  RegViewController.m
//  Warriors' Heaven
//
//  Created by juweihua on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegViewController.h"
#import "AppDelegate.h"
#import "WHHttpClient.h"

@implementation RegViewController

@synthesize lbError;
@synthesize tName;
@synthesize lbTeamCode;
@synthesize vBG;
@synthesize lbVersion;
//@synthesize vBgBottom;
@synthesize vReg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    AppDelegate* ad = [UIApplication sharedApplication].delegate;
   // vBG.frame = CGRectMake(0, ([ad screenSize].height-480)/2, 320,480);
  //  vBgBottom.frame = CGRectMake(0, [ad screenSize].height-480, 320, 480);
    if ([ad isRetina4]){
        vBG.image = [UIImage imageNamed:@"bg_reg_526x296.jpg"];
        vBG.frame = CGRectMake(0, 0, 320,[ad screenSize].height);
        CGRect r = vReg.frame;
        r.origin.y = 100;
        vReg.frame = r;
    }
//    [ad checkRentina:vReg changeSize:NO changeOrigin:YES];
    CGRect r = lbVersion.frame;
    r.origin.y = [ad screenSize].height - r.size.height;
    lbVersion.frame = r;

    currentSelectedSex = -1;
}

- (void)viewDidUnload
{
    [self setTName:nil];
    [self setLbError:nil];
    [self setLbTeamCode:nil];
    [self setVBG:nil];
    [self setLbVersion:nil];
    [self setVBgTop:nil];
    [self setVBgBottom:nil];
    [self setVReg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onCreate:(id)sender {
    NSString * name = tName.text;
    if (name == NULL || name.length == 0){
        lbError.text = @"Name cannot be empty";
        return;
    }
        
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ( name.length == 0){
        lbError.text = @"Name cannot be empty";
        return;
    }
    if (name.length > 10){
        lbError.text = @"Name is too long";
        return;
    }
    NSString * tc = lbTeamCode.text;
    if (tc == NULL || tc == [NSNull null])
        tc = @"";
    else
        tc = [tc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    
    if (currentSelectedSex <0){
        lbError.text = @"Please choose your character.";
        return;
    }
   
    WHHttpClient* client = [[WHHttpClient alloc] init:self];
//    [client setResponseHandler:@selector(onResponse::)];
    NSString* url = [NSString stringWithFormat:@"/wh/reg?name=%@&profile=%d&tc=%@", name, currentSelectedSex, tc];
    
    [client sendHttpRequest:url selector:@selector(onReceiveStatus:) json:YES showWaiting:YES];
    
}
/* 
- (void) onResponse:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse{
    
   AppDelegate * ad = [UIApplication sharedApplication].delegate;
    // record session id
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)aResponse;
    NSDictionary *fields = [HTTPResponse allHeaderFields];
    NSString *_cookie = [fields valueForKey:@"Set-Cookie"]; 
    NSLog(@"set-cookie:%@", _cookie);
    
    if (_cookie){
  //      self->cookie = _cookie;
        AppDelegate * ad = [UIApplication sharedApplication].delegate;
        if (ad.session_id == nil){
            NSString *regExStr = @"_wh_session=(.*?);";
            NSError *error = NULL;
            
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExStr
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:&error];
            
            [regex enumerateMatchesInString:_cookie options:0 range:NSMakeRange(0, [_cookie length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                NSLog(@"session id=%@",[_cookie substringWithRange:[result rangeAtIndex:1]]);
                
                ad.session_id = [_cookie substringWithRange:[result rangeAtIndex:1]];
                NSLog(@"session id=%@", ad.session_id);
                // persist
                NSArray *Array = [NSArray arrayWithObjects:ad.session_id, nil];
                NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
                [SaveDefaults setObject:Array forKey:@"sessionid"];
                
            }];
        }
}
 */
- (void) onReceiveStatus:(NSObject*) data{
    if ([data valueForKey:@"user"]){
        AppDelegate * ad = [UIApplication sharedApplication].delegate;
        NSObject *d = [data valueForKey:@"user"];
        ad.data_user = data;
        NSString* sid = [d valueForKey:@"sid"];
        [ad setSessionId:sid];
        [ad saveDataUser];
        self.view.hidden = YES;
   
        [ad setFirstCallReturn:YES];
//        [ad hideWelcomeView];
        [ad initUI];
//        [ad.window bringSubviewToFront:self.view];
         [ad showWelcomeView];
        [ad preload];
        [ad startRecover]; 
//        [ad query_msg];
        [ad float_msg];
    }else{
        lbError.text = [data valueForKey:@"error"];
        return;
    }

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (lbTeamCode == textField) {
		NSTimeInterval animationDuration = 0.30f;
		[UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
		[UIView setAnimationDuration:animationDuration];
		float width = self.view.frame.size.width;
		float height = self.view.frame.size.height;
		CGRect rect = CGRectMake(0.0f, -70,width,height);
		self.view.frame = rect;
		[UIView commitAnimations];
        
	}
}

// hide system keyboard when user click "return"
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
	
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
	
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void) highlightButton:(UIButton*)bt{
   // bt.backgroundColor = [UIColor redColor];
    [bt setImageEdgeInsets:UIEdgeInsetsMake(1.0f, 2.0f, 2.0f, 3.0f)];
    if (btSelectedSex){
 //       btSelectedSex.backgroundColor = [UIColor clearColor];
        [btSelectedSex setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 1)];
    }
    btSelectedSex = bt;
}
- (IBAction)onSelectSex:(id)sender {
    UIButton* bt = sender;
    if (bt.tag == currentSelectedSex)
        return;
    currentSelectedSex = bt.tag;
 
    [self performSelector:@selector(highlightButton:) withObject:bt afterDelay:0.0];
    
    // hide keyboard
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
	
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
	
    [UIView commitAnimations];
    [tName resignFirstResponder];
    [lbTeamCode resignFirstResponder];

}

@end
