//
//  OAuthWebViewController.h
//  StackOverflowApp
//
//  Created by Matthew Weintrub on 12/7/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OAuthWebViewControllerCompletion) ();

@interface OAuthWebViewController : UIViewController

@property (copy,nonatomic) OAuthWebViewControllerCompletion completion;

@end

