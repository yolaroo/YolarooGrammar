//
//  SynonymModel.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SynonymModel : NSObject

@property (strong, nonatomic) NSDictionary* theCompleteDictionary;
@property (strong, nonatomic) NSArray* theCompleteArray;

@property (strong, nonatomic) NSArray* theSynonymNameList;
@property (strong, nonatomic) NSArray* theAntonymNameList;


+ (SynonymModel*) newSynonymModel;

@end