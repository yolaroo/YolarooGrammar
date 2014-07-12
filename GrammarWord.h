//
//  GrammarWord.h
//  YolarooGrammar
//
//  Created by MGM on 5/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GrammarWordSemanticType;

@interface GrammarWord : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * isUserGenerated;
@property (nonatomic, retain) GrammarWordSemanticType *whatSemanticType;

@end
