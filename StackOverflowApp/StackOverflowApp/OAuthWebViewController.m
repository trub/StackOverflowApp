//
//  OAuthWebViewController.m
//  StackOverflowApp
//
//  Created by Matthew Weintrub on 12/7/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "OAuthWebViewController.h"
@import WebKit;


NSString const *kClientID = @"6085";
NSString const *kBaseURL = @"https://stackexchange.com/oauth/dialog?";
NSString const *kRedirectURL =  @"https://stackexchange.com/oauth/login_success";


@interface OAuthWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation OAuthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    
    self.webView.navigationDelegate = self;
    
    NSString *stackURLString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@", kBaseURL, kClientID, kRedirectURL];
    NSURL *stackURL = [NSURL URLWithString:stackURLString];
    
    [self.webView loadRequest: [NSURLRequest requestWithURL:stackURL ]];
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURLRequest *request = navigationAction.request;
    NSURL *requestURL = request.URL;
    
    if ([requestURL.description containsString:@"access_token"]) {
        NSArray *urlComponenets = [[requestURL description] componentsSeparatedByString:@"="];
        NSString *accessToken = urlComponenets.lastObject;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:accessToken forKey:@"accessToken"];
        [userDefaults synchronize];
        
        if (self.completion) {
            self.completion();
        }
    }
    
    decisionHandler (WKNavigationActionPolicyAllow);
    
}





@end
