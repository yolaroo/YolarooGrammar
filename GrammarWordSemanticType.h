//
//  GrammarWordSemanticType.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GrammarWordSemanticType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSSet *whatWord;
@end

@interface GrammarWordSemanticType (CoreDataGeneratedAccessors)

- (void)addWhatWordObject:(NSManagedObject *)value;
- (void)removeWhatWordObject:(NSManagedObject *)value;
- (void)addWhatWord:(NSSet *)values;
- (void)removeWhatWord:(NSSet *)values;

@end
