//
//  PrepositionSemanticType.h
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PrepositionalPhrase;

@interface PrepositionSemanticType : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) PrepositionalPhrase *whatPreposition;

@end
