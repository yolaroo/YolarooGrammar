//
//  Auxiliary.h
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SententialVerb;

@interface Auxiliary : NSManagedObject

@property (nonatomic, retain) NSString * past;
@property (nonatomic, retain) NSString * present;
@property (nonatomic, retain) NSString * future;
@property (nonatomic, retain) NSSet *whatSententialVerb;
@end

@interface Auxiliary (CoreDataGeneratedAccessors)

- (void)addWhatSententialVerbObject:(SententialVerb *)value;
- (void)removeWhatSententialVerbObject:(SententialVerb *)value;
- (void)addWhatSententialVerb:(NSSet *)values;
- (void)removeWhatSententialVerb:(NSSet *)values;

@end
