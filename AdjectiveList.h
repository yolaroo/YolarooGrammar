//
//  AdjectiveList.h
//  YolarooGrammar
//
//  Created by MGM on 4/21/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdjectiveModel.h"

@interface AdjectiveList : NSObject

@property (strong, nonatomic) NSArray* list;

+ (AdjectiveList*) newList: (NSString*)myClassName myModel: (AdjectiveModel*)myModel;


@end
