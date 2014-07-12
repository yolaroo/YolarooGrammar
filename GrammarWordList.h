//
//  GrammarWordList.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrammarWordDataModel.h"

@interface GrammarWordList : NSObject

+ (GrammarWordList*) newGrammarList: (NSString*)myClassName myModel: (GrammarWordDataModel*)myModel;

@property (strong, nonatomic) NSArray* list;

@end
