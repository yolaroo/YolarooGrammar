//
//  Dislikes.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character;

@interface Dislikes : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSNumber * isPlural;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSSet *whoseDislike;
@end

@interface Dislikes (CoreDataGeneratedAccessors)

- (void)addWhoseDislikeObject:(Character *)value;
- (void)removeWhoseDislikeObject:(Character *)value;
- (void)addWhoseDislike:(NSSet *)values;
- (void)removeWhoseDislike:(NSSet *)values;

@end
