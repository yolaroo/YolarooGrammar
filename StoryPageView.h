//
//  StoryPageView.h
//  YolarooGrammar
//
//  Created by MGM on 5/13/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"
#import "StoryReadView.h"
#import "StoryQuestionMatchView.h"


@interface StoryPageView : MainFoundation <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@end
