//
//  VerbList.h
//  YolarooGrammar
//
//  Created by MGM on 4/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VerbModel.h"
#import "VerbWordData.h"

@interface VerbList : NSObject

@property (strong, nonatomic) NSArray* list;

+ (VerbList*) newVerbList:(NSString*)myClassName myModel: (VerbModel*)myModel;

@end
