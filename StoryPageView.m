//
//  StoryPageView.m
//  YolarooGrammar
//
//  Created by MGM on 5/13/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "StoryPageView.h"
#import "MainFoundation+StoryQuestionsDataloader.h"

@interface StoryPageView ()

@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSInteger pageMax;
@property (nonatomic) BOOL isPhaseOne;
@property (strong,nonatomic) NSMutableArray* dataArray;

@end

@implementation StoryPageView

@synthesize pageIndex= _pageIndex,dataArray=_dataArray,pageControl=_pageControl;

#define DK 2
#define LOG if(DK == 1)

#define SENTENCE_MAX 17

//
#pragma mark - Page limit index
//

- (NSInteger)pageIndex {
    if(_pageIndex < 0){
        LOG NSLog(@"under index %ld",(long)_pageIndex);
        return 0;
    }
    else if (_pageIndex > self.pageMax){
        LOG NSLog(@"over index %ld",(long)_pageIndex);
        return self.pageMax;
    }
    else {
        return _pageIndex;
    }
}

//
#pragma mark - Page control press
//

- (IBAction)changePage:(id)sender {
    UIPageControl *pager=sender;
    NSInteger page = pager.currentPage;
    LOG NSLog(@"-- %ld-- ",(long)page);
    self.pageIndex = page;
    self.isPhaseOne = true;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"reloadStory"
     object:self];

}

//
//
////////
#pragma mark - Data Loader
////////
//
//

- (void) setMydataArray {
    if (self.pageIndex <=self.pageMax) {
        @try {
            NSMutableArray*storyArray = [[self myMainStoryLoader:self.pageIndex withContext: self.managedObjectContext]mutableCopy];
            if ([storyArray count] < 3){
                NSLog(@"-- (Error Dataload - count:) %lu --",(unsigned long)[storyArray count]);
            }
            self.dataArray = storyArray;
        }
        @catch (NSException *exception) {
            LOG NSLog(@"SPV %@",exception);
        }
        @finally {
            LOG NSLog(@"Data array Loaded");
        }
    }
}

//
//
////////
#pragma mark - View Label Loader
////////
//
//

- (StoryReadView *)viewReadControllerAtIndex:(NSUInteger)index
{
    LOG NSLog(@"-- Should Load Reading Text --");
    StoryReadView *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryReadViewID"];
    
    [self setMydataArray];
    NSArray* myReadingArray = [[self.dataArray firstObject] copy];
    LOG NSLog(@"-- (data for text) %@ --",[myReadingArray objectAtIndex:0]);
    pageContentViewController.textForLabel01 = [myReadingArray objectAtIndex:0];
    pageContentViewController.textForLabel02 = [myReadingArray objectAtIndex:1];
    pageContentViewController.textForLabel03 = [myReadingArray objectAtIndex:2];
    pageContentViewController.textForLabel04 = [myReadingArray objectAtIndex:3];
    
    pageContentViewController.pageIndex = self.pageIndex;
    return pageContentViewController;
    
    // readingArray
    // questionArray
    // answerArray
}

- (StoryQuestionMatchView *)viewAnswerControllerAtIndex:(NSUInteger)index
{
    LOG NSLog(@"-- Should Load Answer --");
    StoryQuestionMatchView *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryQuestionViewID"];
    pageContentViewController.theDataArray = self.dataArray;
    pageContentViewController.pageIndex = self.pageIndex;
    return pageContentViewController;
}

- (StoryQuestionMatchView *)viewReverseAnswerControllerAtIndex:(NSUInteger)index
{
    LOG NSLog(@"-- Should Load Answer --");
    StoryQuestionMatchView *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryQuestionViewID"];

    [self setMydataArray];

    pageContentViewController.theDataArray = self.dataArray;
    pageContentViewController.pageIndex = self.pageIndex;
    return pageContentViewController;
}

//
//
////////
#pragma mark - Page View Controller Data Source
////////
//
//

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    LOG NSLog(@"-- previous page --");

    if (((self.pageIndex <= 0) && self.isPhaseOne) || (self.pageIndex == NSNotFound)) {
        return nil;
    }
    if (self.isPhaseOne){
        LOG NSLog(@"reading");

        self.pageIndex--;
        LOG NSLog(@"-- (PI) %ld --",(long)self.pageIndex);
        [self.pageControl setCurrentPage:self.pageIndex];

        self.isPhaseOne = false;
        return [self viewReverseAnswerControllerAtIndex:self.pageIndex];
    }
    else {
        LOG NSLog(@"questions");
        
        self.isPhaseOne = true;
        return [self viewReadControllerAtIndex:self.pageIndex];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    LOG NSLog(@"++ next page ++");
    LOG NSLog(@"-- pageIndex -- %ld",(long)self.pageIndex);
    LOG NSLog(@"-- count -- %ld",(long)self.pageMax);

    if (self.pageIndex == NSNotFound || (self.pageIndex >= self.pageMax && !self.isPhaseOne)) {
        LOG NSLog(@"-- TRYING TO GET NIL --");
        return nil;
    }
    if (self.isPhaseOne){
        self.isPhaseOne = false;
        return [self viewAnswerControllerAtIndex:self.pageIndex];
    }
    else {
        self.pageIndex++;
        [self pageIndexCheck];
        LOG NSLog(@"-- (PI) %ld --",(long)self.pageIndex);
        [self.pageControl setCurrentPage:self.pageIndex];

        self.isPhaseOne = true;
        return [self viewReadControllerAtIndex:self.pageIndex];
    }
}

//
//
////////
#pragma mark - Page Load
////////
//
//

- (void) loadPageViewData {
    LOG NSLog(@"loadPageViewData");
    self.isPhaseOne = true;
    [self pageIndexCheck];

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    // load view
    StoryReadView *startingViewController = [self viewReadControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    //show dots
    [self.view bringSubviewToFront:self.pageControl];

    [self.pageViewController didMoveToParentViewController:self];
}

- (void) pageIndexCheck {
    self.pageMax = [self theStoryMax:self.managedObjectContext]-1;
    LOG NSLog(@"-- pageMax %ld --",(long)self.pageMax);
    if (self.pageIndex > self.pageMax){
        self.pageIndex = self.pageMax;
    }
}

//
//
////////
#pragma mark - Notifications
////////
//
//

- (void) loadReloadViewNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(dataReload:)
     name:@"reloadStory"
     object:nil];
}

- (void) dataReload:(NSNotification *)notification {
    [self performSelector:@selector(dataReload) withObject:nil afterDelay:0.1];
}

- (void) dataReload {
    StoryReadView *startingViewController = [self viewReadControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self setMydataArray];
    [startingViewController viewStringSet];
    self.pageControl.numberOfPages = self.pageMax+1;

}

//
//
////////
#pragma mark - Life cycle
////////
//
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadReloadViewNotification];
    [self loadPageViewBottomBarOptions];
    [self loadPageViewData];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    [self.view bringSubviewToFront:self.pageControl];
}

- (void) loadPageViewBottomBarOptions {
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
}

@end
