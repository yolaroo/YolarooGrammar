//
//  WordList.h
//  YolarooGrammar
//
//  Created by MGM on 3/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface WordList : NSObject

+ (WordList*) newList: (NSString*)myClassName myModel: (DataModel*)myModel;

@property (strong, nonatomic) NSArray* list;


@end
