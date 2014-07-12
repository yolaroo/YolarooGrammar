//
//  SemanticType.h
//  YolarooGrammar
//
//  Created by MGM on 5/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface SemanticType : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * wordObject;
@property (nonatomic, retain) NSSet *theWord;
@end

@interface SemanticType (CoreDataGeneratedAccessors)

- (void)addTheWordObject:(Word *)value;
- (void)removeTheWordObject:(Word *)value;
- (void)addTheWord:(NSSet *)values;
- (void)removeTheWord:(NSSet *)values;

@end
