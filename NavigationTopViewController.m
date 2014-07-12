//
//  NavigationTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 2/13/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "NavigationTopViewController.h"

@implementation NavigationTopViewController

@synthesize edgePanGesture=_edgePanGesture, closeGesture=_closeGesture;

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[UnderMenu class]]) {
    self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderMenuID"];
  }
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    /*
    UIScreenEdgePanGestureRecognizer  *leftEdgePan =
    [[UIScreenEdgePanGestureRecognizer  alloc] initWithTarget:self action:@selector(edgeCheck:)];
    [leftEdgePan setEdges:UIRectEdgeLeft];
    [self.view addGestureRecognizer:leftEdgePan];
    */

    [self.view addGestureRecognizer:self.edgePanGesture];
    [self.view addGestureRecognizer:self.closeGesture];
    
}


- (void) edgeCheck:(UISwipeGestureRecognizer *)recognizer{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void) closeMenu:(UISwipeGestureRecognizer *)recognizer{
    [self.slidingViewController resetTopView];
}

- (UIScreenEdgePanGestureRecognizer *) edgePanGesture {
    if (!_edgePanGesture){
        _edgePanGesture =
        [[UIScreenEdgePanGestureRecognizer  alloc] initWithTarget:self action:@selector(edgeCheck:)];
        [_edgePanGesture setEdges:UIRectEdgeLeft];
    }
    return _edgePanGesture;
}


- (UISwipeGestureRecognizer *) closeGesture {
    if (!_closeGesture){
        _closeGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(closeMenu:)];
        [_closeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    return _closeGesture;
}



@end


