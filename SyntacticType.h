//
//  SyntacticType.h
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface SyntacticType : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *theWord;
@end

@interface SyntacticType (CoreDataGeneratedAccessors)

- (void)addTheWordObject:(Word *)value;
- (void)removeTheWordObject:(Word *)value;
- (void)addTheWord:(NSSet *)values;
- (void)removeTheWord:(NSSet *)values;

@end
