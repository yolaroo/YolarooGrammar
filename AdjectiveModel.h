//
//  AdjectiveModel.h
//  YolarooGrammar
//
//  Created by MGM on 4/21/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdjectiveModel : NSObject

@property (strong, nonatomic) NSArray* theCompleteArray;
@property (strong, nonatomic) NSDictionary* theCompleteDictionary;
@property (strong, nonatomic) NSArray* theCategoryNameList;

+ (AdjectiveModel*) newAdjectiveModel;

@end
