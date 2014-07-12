//
//  Nation.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address;

@interface Nation : NSManagedObject

@property (nonatomic, retain) NSString * adjective;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * preposition;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSSet *whatAddress;
@end

@interface Nation (CoreDataGeneratedAccessors)

- (void)addWhatAddressObject:(Address *)value;
- (void)removeWhatAddressObject:(Address *)value;
- (void)addWhatAddress:(NSSet *)values;
- (void)removeWhatAddress:(NSSet *)values;

@end
