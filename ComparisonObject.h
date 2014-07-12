//
//  ComparisonObject.h
//  YolarooGrammar
//
//  Created by MGM on 5/9/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ComparisonObject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * term1;
@property (nonatomic, retain) NSString * term2;
@property (nonatomic, retain) NSString * winner;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSString * adjective;
@property (nonatomic, retain) NSString * sentence;

@end
