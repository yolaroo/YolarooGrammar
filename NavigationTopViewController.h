//
//  NavigationTopViewController.h
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 2/13/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ECSlidingViewController.h"
#import "UnderMenu.h"

@interface NavigationTopViewController : UINavigationController


@property (strong,nonatomic) UIScreenEdgePanGestureRecognizer * edgePanGesture;
@property (strong,nonatomic) UISwipeGestureRecognizer * closeGesture;


@end
