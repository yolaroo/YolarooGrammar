//
//  MainFoundation+SentenceUtility.m
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SentenceUtility.h"

@implementation MainFoundation (SentenceUtility)

#define DK 2
#define LOG if(DK == 1)

- (NSString*) stringFromDictionaryWithString: (NSDictionary*) dictionary withKey: (NSString*) myKey
{
    if ([[dictionary objectForKey:myKey] isKindOfClass:[NSString class]]) {
        return [dictionary objectForKey:myKey];
    }
    else {
        LOG NSLog(@"Dictionary Error");
        return nil;
    }
}

- (NSString*) generalReturn :(NSManagedObject*)myObject withType:(NSString*) theType{
    LOG NSLog(@"1.0");

    if ([theType isEqualToString:@"metaType"]) {
        return [self objectType:myObject];
    }
    if ([theType isEqualToString:@"name"]) {
        return [self objectName:myObject];
    }
    if ([theType isEqualToString:@"verb"]) {
        return [self objectVerb:myObject];
    }
    return @"error";
}

- (NSString*) stringForMultiObjectWithArray: (NSArray*)myArray withObjectNumber: (NSInteger) theObjectCount withType: (NSString*) theType {
    return [self generalReturn:[myArray objectAtIndex: theObjectCount] withType:theType];
//        return [self nssetDataReturn:[myArray objectAtIndex: theObjectCount] withType:theType];
}


- (NSString*) stringFromDictionaryWithArrayAtIndex: (NSDictionary*) dictionary withKey: (NSString*) myKey withType: (NSString*) theType withIndex: (NSInteger) myIndex
{
    if ([[dictionary objectForKey:myKey] isKindOfClass:[NSSet class]]) {
        NSArray*myArray = [[dictionary objectForKey:myKey] allObjects];
        if ([theType isEqualToString:@"name"]){
            return [self generalReturn:[myArray objectAtIndex:myIndex] withType:theType];
        }
        else {
            return [self generalReturn:[myArray objectAtIndex:myIndex] withType:theType];
        }
    }
    else {
        NSLog(@"error on return of array at index");
        return nil;
    }
}

- (NSString*) stringFromDictionaryWithArray: (NSDictionary*) dictionary withKey: (NSString*) myKey withType: (NSString*) theType
{
    if ([[dictionary objectForKey:myKey] isKindOfClass:[NSSet class]]) {
        LOG NSLog(@"--$ array $--");
        NSArray*myArray = [[dictionary objectForKey:myKey] allObjects];
        if ([theType isEqualToString:@"name"]){
              LOG NSLog(@"1.");
            return [self generalReturn:[myArray firstObject] withType:theType];
//            return [self nssetDataReturn:[myArray firstObject] withType:theType];
        }
        else {
              LOG NSLog(@"2.NSSET ERROR");
            return [self generalReturn:[myArray firstObject] withType:theType];
//            return [self nssetDataReturn:[myArray firstObject] withType:theType];
        }
    }
    else {
         LOG NSLog(@"3.0 Fatal Dictionary Error");
        return nil;
    }
}

//
//
////
////// search
////
//
//

- (Word*) wordObjectFromNameWithComplexTypes: (NSString*)theWord withContext: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    
    NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"english = %@", theWord];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateName, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    
    NSPredicate *predicateNounType  = [NSPredicate predicateWithFormat:@"whatSyntacticType = %@", @"noun"];
    NSPredicate *predicateTimeType  = [NSPredicate predicateWithFormat:@"whatSyntacticType = %@", @"time"];
    NSPredicate *predicateLocationType  = [NSPredicate predicateWithFormat:@"whatSyntacticType = %@", @"location"];
    NSPredicate *predicateNameType  = [NSPredicate predicateWithFormat:@"whatSyntacticType = %@", @"name"];
    NSArray *secondSubPredicates = [NSArray arrayWithObjects:predicateNounType,predicateTimeType,predicateLocationType,predicateNameType, nil];
    NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:secondSubPredicates];
    
    NSArray *finalPredicateArray = [NSArray arrayWithObjects:andPredicate,orPredicate, nil];
    NSPredicate *finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:finalPredicateArray];
    fetchRequest.predicate = finalPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return [fetchedRecords firstObject];
}

- (Word*) wordObjectFromName: (NSString*)theWord withContext: (NSManagedObjectContext*)newContext
{
    if ([theWord integerValue] >= 1) theWord=@"number";
    LOG NSLog(@"007 - wordObject %@",theWord);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    
    NSString*theWordWithTheLetterS = [NSString stringWithFormat:@"%@s",theWord];
    NSString*theWordminusLastLetter = [theWord substringToIndex:[theWord length] - 1];
    
    NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"english LIKE[cd] %@", theWord];
    NSPredicate *predicateNameWithS = [NSPredicate predicateWithFormat:@"english LIKE[cd] %@", theWordWithTheLetterS];
    NSPredicate *predicateNameWithoutLastLetter = [NSPredicate predicateWithFormat:@"english LIKE[cd] %@", theWordminusLastLetter];

    NSArray *subPredicates = [NSArray arrayWithObjects:predicateName,predicateNameWithS,predicateNameWithoutLastLetter, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
    
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return [fetchedRecords firstObject];
}

- (AdjectiveClass*) adjectiveObjectFromName: (NSString*)theWord withContext: (NSManagedObjectContext*)newContext
{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveClass" inManagedObjectContext:newContext];

        NSPredicate *predicateBasic = [NSPredicate predicateWithFormat:@"basic LIKE[cd] %@", theWord];
        NSPredicate *predicateComp = [NSPredicate predicateWithFormat:@"comparative LIKE[cd] %@", theWord];
        NSPredicate *predicateSuper = [NSPredicate predicateWithFormat:@"superlative LIKE[cd] %@", theWord];
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateBasic,predicateComp,predicateSuper, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
        
        fetchRequest.predicate = andPredicate;
        
        NSError* error;
        NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    AdjectiveClass*temp = [fetchedRecords firstObject];
        LOG NSLog(@"-- adjective fetched -- %@",temp.basic);
        return [fetchedRecords firstObject];
}

//
//
////
////// pronoun
////
//
//

- (NSString*) setPronounSubject: (Character*)theCharacter
{
    NSString*thePronoun;
    if([theCharacter.isPlural boolValue]) {
        thePronoun = @"they";
    }
    else {
        if ([theCharacter.whatGender.name isEqualToString:@"male"] || [theCharacter.whatGender.name isEqualToString:@"boy"] ) {
            thePronoun = @"he";
        }
        else if ([theCharacter.whatGender.name isEqualToString:@"female"] || [theCharacter.whatGender.name isEqualToString:@"girl"]) {
            thePronoun = @"she";
        }
        else {
            thePronoun = @"it";
        }
    }
    return thePronoun;
}

- (NSString*) setPronounObject: (Word*)word
{
    NSString*thePronoun;
    if([word.isPlural boolValue]) {
        thePronoun = @"them";
    }
    else {
        if ([word.gender isEqualToString:@"male"] || [word.gender isEqualToString:@"boy"]) {
            thePronoun = @"him";
        }
        else if ([word.gender isEqualToString:@"female"] || [word.gender isEqualToString:@"girl"]) {
            thePronoun = @"her";
        }
        else {
            thePronoun = @"it";
        }
    }
    return thePronoun;
}

//
//
////
////// determiner
////
//
//

- (NSString*) setDefaultDeterminer: (Word*) theWord
{
    NSString*theDeterminer = @"";
    
    if (([theWord.isPlural boolValue] && ![theWord.hasDefiniteDeterminer boolValue]) || [theWord.isAdjective boolValue]) {
        theDeterminer = @"";
    }
    else if ([theWord.hasDefiniteDeterminer  boolValue])  {
        theDeterminer = @"the";
    }
    else if ([theWord.isProperName boolValue])  {
        theDeterminer = @"";
    }
    else if ([theWord.isUncountable boolValue])  {
      theDeterminer = @"";
    }
    else if ([theWord.isAdjective boolValue])  {
        theDeterminer = @"";
    }
    else {
        if ([self hasInitialVowel:theWord.english]){
            theDeterminer = @"an";
        }
        else {
            theDeterminer = @"a";
        }
    }
    return theDeterminer;
}

- (NSString*) setDeterminer:(Character*) theCharacter withWord: (Word*) theWord withType: (NSString*) theType
{
    NSString*theDeterminer = @"";
    
    if ([theType isEqualToString: @"possesive"]) {
        theDeterminer = [self setPossesive:theCharacter];
    }
    else if ([theType isEqualToString: @"definite"]) {
        theDeterminer = @"the";
    }
    else if ([theType isEqualToString: @"indefinite"]) {
        [self setDefaultDeterminer:theWord];
    }
    else if ([theType isEqualToString: @"generalization"]) {
        theDeterminer = @"";
    }
    else if ([theType isEqualToString: @"null"]) {
        theDeterminer = @"";
    }
    return theDeterminer;
}

- (NSString*) setPossesive: (Character*)theCharacter
{
    NSString*thePossesive;
    if([theCharacter.isPlural boolValue]) {
        thePossesive = @"their";
    }
    else {
        if ([theCharacter.whatGender.name isEqualToString:@"male"] || [theCharacter.whatGender.name isEqualToString:@"boy"] ) {
            thePossesive = @"his";
        }
        else if ([theCharacter.whatGender.name isEqualToString:@"female"] || [theCharacter.whatGender.name isEqualToString:@"girl"] ) {
            thePossesive = @"her";
        }
        else {
            thePossesive = @"its";
        }
    }
    return thePossesive;
}

//
////
//

- (BOOL) hasInitialVowel: (NSString*)objectString
{
    if ([objectString hasPrefix:@"a"] || [objectString hasPrefix:@"A"] || [objectString hasPrefix:@"e"] || [objectString hasPrefix:@"E"] || [objectString hasPrefix:@"i"] || [objectString hasPrefix:@"I"] || [objectString hasPrefix:@"o"] || [objectString hasPrefix:@"O"]|| [objectString hasPrefix:@"Herb"] || [objectString hasPrefix:@"herb"] || [objectString hasPrefix:@"hour"] || [objectString hasPrefix:@"Hour"] || [objectString hasPrefix:@"under"] || [objectString hasPrefix:@"uncle"]) {
        return true;
    }
    else {
        return false;
    }
}

//
////
//

- (NSString*) sentenceSuffixCheck: (NSString*)aString
{
    NSMutableString*myString = [NSMutableString stringWithString:aString];
    if ([myString isEqualToString:@"mouse"]){
        [myString stringByReplacingOccurrencesOfString:@"mouse" withString:@"mice"];
    }
    else if ([myString hasSuffix:@"y"] && ![myString hasSuffix:@"ey"] && ![myString hasSuffix:@"ay"]) {
        [myString deleteCharactersInRange:NSMakeRange([myString length]-1, 1)];
        [myString appendString:@"ies"];
    }
    else if ([myString hasSuffix:@"s"]) {
        [myString appendString: @"es"];
    }
    else if ([myString hasSuffix:@"x"]) {
        [myString appendString: @"es"];
    }
    else {
        [myString appendString: @"s"];
    }
    return [myString copy];
}

//
////
//

- (BOOL) canConvertToNumber: (NSString*)objectString
{
    NSInteger intTest =  [objectString integerValue];
    LOG NSLog(@"-- (inttesst) %ld -- ",(long)intTest);
    if (intTest > 0) {
        return true;
    }
    else {
        return false;
    }
}

//
////
//

- (BOOL) isAdjectiveTest: (NSDictionary*)dictionary withType: (NSString*)type
{
    if ([[dictionary objectForKey:type] respondsToSelector:@selector(objectIsAdjective)]){
        return true;
    }
    else if ([[dictionary objectForKey:type] isKindOfClass:[NSSet class]]) {
        if ([[[[dictionary objectForKey:type] allObjects]firstObject] respondsToSelector:@selector(objectIsAdjective)]){
            return true;
        }
        else {
            return false;
        }
    } else {
        return false;
    }
    return false;
}

- (BOOL) isDateTest: (NSDictionary*)dictionary withType: (NSString*)type
{
    if ([[dictionary objectForKey:type] respondsToSelector:@selector(isDate)]){
        return true;
    }
    else if ([[dictionary objectForKey:type] isKindOfClass:[NSSet class]]) {
        if ([[[[dictionary objectForKey:type] allObjects]firstObject] respondsToSelector:@selector(isDate)]){
            return true;
        }
        else {
            return false;
        }
    } else {
        return false;
    }
}

- (BOOL) isNumberTest: (NSDictionary*)dictionary withType: (NSString*)type
{
    if ([[dictionary objectForKey:type] respondsToSelector:@selector(objectIsNumber)]){
        return true;
    }
    else if ([[dictionary objectForKey:type] isKindOfClass:[NSSet class]]) {
        if ([[[[dictionary objectForKey:type] allObjects]firstObject] respondsToSelector:@selector(objectIsNumber)]){
            return true;
        }
        else {
            return false;
        }
    } else {
        return false;
    }
}

@end
