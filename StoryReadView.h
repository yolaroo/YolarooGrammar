//
//  StoryReadView.h
//  YolarooGrammar
//
//  Created by MGM on 5/13/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface StoryReadView : MainFoundation

@property  (weak, nonatomic) NSString* textForLabel01;
@property  (weak, nonatomic) NSString* textForLabel02;
@property  (weak, nonatomic) NSString* textForLabel03;
@property  (weak, nonatomic) NSString* textForLabel04;

@property NSUInteger pageIndex;

- (void) viewStringSet;

@end
