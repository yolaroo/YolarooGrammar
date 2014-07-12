//
//  AdjectiveSemanticType.h
//  YolarooGrammar
//
//  Created by MGM on 4/21/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AdjectiveClass;

@interface AdjectiveSemanticType : NSManagedObject

@property (nonatomic, retain) NSString * displayOrder;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatAdjective;
@end

@interface AdjectiveSemanticType (CoreDataGeneratedAccessors)

- (void)addWhatAdjectiveObject:(AdjectiveClass *)value;
- (void)removeWhatAdjectiveObject:(AdjectiveClass *)value;
- (void)addWhatAdjective:(NSSet *)values;
- (void)removeWhatAdjective:(NSSet *)values;

@end
