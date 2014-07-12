//
//  Story.h
//  YolarooGrammar
//
//  Created by MGM on 3/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animal.h"
#import "DataModel.h"
#import "WordList.h"

@interface SimpleStory : NSObject

- (instancetype) initStory: (DataModel*)myModel;

@property (strong, nonatomic) NSArray* theStory;


@end
