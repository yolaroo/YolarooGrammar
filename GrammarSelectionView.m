//
//  GrammarSelectionView.m
//  YolarooGrammar
//
//  Created by MGM on 5/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "GrammarSelectionView.h"

@interface GrammarSelectionView ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@end

@implementation GrammarSelectionView

//
////
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewStyleForLoad];

}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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
