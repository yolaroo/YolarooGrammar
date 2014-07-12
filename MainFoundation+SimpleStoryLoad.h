//
//  MainFoundation+SimpleStoryLoad.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"
#import "SimpleStory.h"
#import "DataModel.h"

@interface MainFoundation (SimpleStoryLoad)

- (SimpleStory*) setMyStoryForStoryLoad: (DataModel*)myModel;
- (DataModel*) setMyDataModelForSimpleStory;

@end
