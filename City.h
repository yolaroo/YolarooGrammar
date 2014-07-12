//
//  City.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address;

@interface City : NSManagedObject

@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatAddress;
@end

@interface City (CoreDataGeneratedAccessors)

- (void)addWhatAddressObject:(Address *)value;
- (void)removeWhatAddressObject:(Address *)value;
- (void)addWhatAddress:(NSSet *)values;
- (void)removeWhatAddress:(NSSet *)values;

@end
