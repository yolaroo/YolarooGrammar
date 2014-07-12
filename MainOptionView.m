//
//  MainOptionView.m
//  YolarooGrammar
//
//  Created by MGM on 5/18/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainOptionView.h"

#import "MainFoundation+MainOptionControl.h"
#import "MainFoundation+WordSearch.h"

@interface MainOptionView ()
{
    NSInteger pressCount;
    NSInteger deletePressCount;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@end

@implementation MainOptionView

#define DK 2
#define LOG if(DK == 1)

//
//
///////
#pragma mark - Data Stuff
///////
//
//

#pragma mark - RELOAD Button

- (IBAction)reloadDataPress:(UIButton *)sender {
    pressCount++;

    if (pressCount == 10){
        [self myAlert:@"last warning"];
    }
    else if (pressCount < 10){
        [self myAlert:@"only press for emergency reload"];
        return;
    }
    else if (pressCount > 10){
        [self myAlert:@"loading"];
        [self performSelector:@selector(reloadStart) withObject:nil afterDelay:1];
    }
}

- (void)reloadStart {
    pressCount = 0;
    @try {
        [self deleteDataAndReload:self.managedObjectContext];
    }
    @catch (NSException *exception) {
        NSLog(@"DDR %@",exception);
    }
}

//
////
//

#pragma mark - TRANSFER Button

- (IBAction)transferDataPress:(UIButton *)sender {
    @try {
        [self mainMigrate];
    }
    @catch (NSException *exception) {
        NSLog(@"MM %@",exception);
    }
}

#pragma mark - DELETE Button

- (IBAction)deleteDataPress:(UIButton *)sender {
    deletePressCount++;
    if (deletePressCount > 2){
        [self deleteNormalRecords:self.managedObjectContext];
        deletePressCount = 0;
    }
    else {
        [self myAlert:@"Will Delete All Stories"];
    }
}

//
//
//////
#pragma mark - Hidden
//////
//
//
#pragma mark - SAVE Button
- (IBAction)saveDataPress:(UIButton *)sender {
    //[self saveAction];
}

#pragma mark - LOAD Button
- (IBAction)loadDataPress:(UIButton *)sender {
//    [self loadDataFromJSONAction: self.managedObjectContext];
}
//
//
//////
#pragma mark - Hidden
//////
//
//


//
//
//////
#pragma mark - Life Cycle
//////
//
//

#pragma mark - Life Cycle

- (void) viewDidLoad {
    [super viewDidLoad];
    [self viewStyleForLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    pressCount = 0;
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
    for(UIButton* BTN in self.myButtonCollection){
        [self buttonShadow:BTN];
    }
}


@end
