//
//  GrammarWordDataModel.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrammarWordDataModel : NSObject

+ (GrammarWordDataModel*) newGrammarDataModel;

@property (strong, nonatomic) NSArray* theCompleteArray;
@property (strong, nonatomic) NSDictionary* theCompleteDictionary;
@property (strong, nonatomic) NSArray* theCategoryNameList;
@property (strong, nonatomic) NSArray* theWordTypeNameList;

@end
