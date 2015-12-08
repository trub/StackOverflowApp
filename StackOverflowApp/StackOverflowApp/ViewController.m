//
//  ViewController.m
//  StackOverflowApp
//
//  Created by Matthew Weintrub on 12/7/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "ViewController.h"
#import "LLSlideMenu.h"

@interface ViewController ()

@property (nonatomic, strong) LLSlideMenu *slideMenu;

@property (nonatomic, strong) UIPanGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _slideMenu = [[LLSlideMenu alloc] init];
    [self.view addSubview:_slideMenu];
    _slideMenu.ll_menuWidth = 200.f;
    _slideMenu.ll_menuBackgroundColor = [UIColor orangeColor];
    _slideMenu.ll_springDamping = 20;
    _slideMenu.ll_springVelocity = 15;
    _slideMenu.ll_springFramesNum = 60;
    
    
    //===================
    // Menu View
    //===================
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(50, 40, 80, 80)];
    [img setImage:[UIImage imageNamed:@"Head"]];
    [_slideMenu addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 150, 400)];
    label.text = @"textLink\n\ntextLink1\n\ntextLink2";
    [label setTextColor:[UIColor whiteColor]];
    [label setNumberOfLines:0];
    [_slideMenu addSubview:label];
    
    
    //===================
    // Call gestures
    //===================
    self.leftSwipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandle:)];
    self.leftSwipe.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_leftSwipe];
}



//===================
// swipe gesture
//===================
- (void)swipeLeftHandle:(UIScreenEdgePanGestureRecognizer *)recognizer {
    if (_slideMenu.ll_isOpen) {
        return;
    }
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percent = [[UIPercentDrivenInteractiveTransition alloc] init];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self.percent updateInteractiveTransition:progress];
        _slideMenu.ll_distance = [recognizer translationInView:self.view].x;
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.4) {
            [self.percent finishInteractiveTransition];
            [_slideMenu ll_openSlideMenu];
        }else{
            [self.percent cancelInteractiveTransition];
            [_slideMenu ll_closeSlideMenu];
        }
        self.percent = nil;
    }
}


//===================
// IBActions
//===================
- (IBAction)openLLSlideMenuAction:(id)sender {
    if (_slideMenu.ll_isOpen) {
        [_slideMenu ll_closeSlideMenu];
    } else {
        [_slideMenu ll_openSlideMenu];
    }
}


@end
