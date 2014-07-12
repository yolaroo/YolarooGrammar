//
//  SynonymList.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SynonymModel.h"
#import "SynonymWord.h"

@interface SynonymList : NSObject

@property (strong, nonatomic) NSString* synonymName;
@property (strong, nonatomic) NSString* antonymName;

@property (strong, nonatomic) NSArray* list;

+ (SynonymList*) newSynonymList: (NSString*) myClassName myModel: (SynonymModel*)myModel;

@end
