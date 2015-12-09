//
//  Error.h
//  StackOverflowApp
//
//  Created by Matthew Weintrub on 12/9/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kCustomErrorDomain = @"customErrorDomain";

typedef NS_ENUM(NSInteger, CustomError) {
    error0,
    error1,
    error2,
    error3
}