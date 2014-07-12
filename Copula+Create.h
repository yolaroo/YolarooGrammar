//
//  Copula+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/7/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Copula.h"

@interface Copula (Create)


+ (Copula *) getCopula:(NSManagedObjectContext *) context;


@end
