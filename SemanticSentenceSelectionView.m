//
//  SemanticSentenceSelectionView.m
//  YolarooGrammar
//
//  Created by MGM on 5/5/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SemanticSentenceSelectionView.h"

@interface SemanticSentenceSelectionView ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;


@end

@implementation SemanticSentenceSelectionView

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewStyleForLoad];
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
