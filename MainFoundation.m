//
//  ViewController.m
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation ()

@end

@implementation MainFoundation

@synthesize myTimerTest=_myTimerTest,mySpeechClass=_mySpeechClass,mySwipeClass=_mySwipeClass;

#define DK 2
#define LOG if(DK == 1)

#define isDeviceIPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

//
//
////////
//
////////
//

- (NSArray*) foundationAdjectiveListArray
{
    return @[@"elementary",
             @"weather",
             @"common copular",
             @"nations",
             @"eye color",
             @"hair color",
             @"hair style",
             @"color",
             @"positive",
             @"ability positive",
             @"looks positive",
             @"health positive",
             @"social",
             @"psychological positive",
             @"psychological negative",
             @"nominal psychological",
             @"verbal psychological",
             @"taste and smell",
             @"status",
             @"shape",
             @"basic comparison measurement",
             @"basic comparison value",
             @"comparison measurement",
             @"nature and senses",
             @"neutral",
             @"ability negative",
             @"negative",
             @"health negative",
             @"looks negative",
             @"biological",
             @"business",
             @"epistemological",
             @"abstract"];
}

-(NSArray*) foundationWordListArray
{
    return @[@"categories",
             @"common terms",
             @"common possessions",
             @"musicians",
             @"music",
             @"books",
             @"movies",
             @"pronouns",
             @"boy's names",
             @"girl's names",
             @"species",
             @"fish",
             @"shellfish",
             @"amphibians",
             @"reptiles",
             @"aquatic animals",
             @"aquatic mammals",
             @"academics",
             @"appliances",
             @"birds",
             @"bugs",
             @"worms",
             @"body parts",
             @"clothes tops",
             @"clothes bottoms",
             @"clothes accessories",
             @"clothes undergarments",
             @"clothes outer wear",
             @"clothes footwear",
             @"clothes women's footwear",
             @"clothes women's wear",
             @"clothes men's wear",
             @"clothes",
             @"countries",
             @"dinosaurs",
             @"directions",
             @"dogs",
             @"drinks",
             @"kitchenware",
             @"fruits",
             @"family",
             @"furniture",
             @"food",
             @"sauces",
             @"desserts",
             @"flowers",
             @"farm animals",
             @"toys",
             @"sports equipment",
             @"sports",
             @"luxury goods",
             @"electronics",
             @"herbs",
             @"instruments",
             @"jobs",
             @"linens",
             @"landmarks",
             @"homes",
             @"rooms",
             @"regions",
             @"locations",
             @"natural locations",
             @"natural objects",
             @"plants",
             @"beans",
             @"berries",
             @"grains",
             @"nuts",
             @"numbers",
             @"planets",
             @"astronomical objects",
             @"pets",
             @"pests",
             @"personal care objects",
             @"religions",
             @"places of worship",
             @"snakes",
             @"shapes",
             @"school supplies",
             @"months",
             @"days of the week",
             @"time",
             @"seasons",
             @"vehicles",
             @"aquatic vehicles",
             @"aerial vehicles",
             @"transportation locations",
             @"vegetables",
             @"root vegetables",
             @"gourds",
             @"temperature",
             @"cosmetics",
             @"wines",
             @"measurement",
             @"mythical creatures",
             @"weather",
             @"natural disasters",
             @"companies",
             @"universities",
             @"meat"
             ];
}

//
//
////////
//
////////
//
//

//
#pragma mark - ArrayCount
//

- (BOOL) myArrayIndexIsOk: (NSInteger) myIndex withArray: (NSArray*) myArray
{
    if (![myArray count]) return false;
    NSInteger myCount = [myArray count];
    if (myIndex > myCount-1){
        return false;
    }
    else {
        return true;
    }
}

//
#pragma mark - clear buttons
//

- (void) clearButton: (NSArray*)buttonCollection
{
    for (UIButton* btn in buttonCollection) {
        [btn setTitle:@" " forState:UIControlStateNormal];
    }
}

//
#pragma mark - object to name conversion
//

- (NSString*) objectName: (NSManagedObject*)myObject
{
    NSArray* myObjectArray = @[myObject];
    if ([[myObjectArray firstObject] respondsToSelector:@selector(name)]){
        return [[myObjectArray firstObject] name];
    }
    else {
        return (@"error");
    }
}

- (NSString*) objectType: (NSManagedObject*)myObject
{
    NSArray* myObjectArray = @[myObject];
    if ([[myObjectArray firstObject] respondsToSelector:@selector(metaType)]){
        return [[myObjectArray firstObject] metaType];
    }
    else {
        return (@"error");
    }
}

- (NSString*) objectVerb: (NSManagedObject*)myObject
{
    NSArray* myObjectArray = @[myObject];
    if ([[myObjectArray firstObject] respondsToSelector:@selector(verb)]){
        return [[myObjectArray firstObject] verb];
    }
    else {
        return (@"error");
    }
}

//
#pragma mark -  activity indicator
//

- (BOOL) isPortraitOrientation
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation == UIInterfaceOrientationPortrait ||
       orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return true;
    }
    if(orientation == UIInterfaceOrientationLandscapeRight ||
       orientation == UIInterfaceOrientationLandscapeLeft) {
        return false;
    }
    return false;
}

-(void) portraitLock
{
    GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.screenIsPortraitOnly = true;
}

-(void) portraitUnLock
{
    GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.screenIsPortraitOnly = false;
}

- (UIActivityIndicatorView *) activityIndicatorAction
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    CGPoint myCenter;
    if ([self isPortraitOrientation]) {
        myCenter = self.view.center;
    }
    else {
        myCenter = CGPointMake(self.view.frame.size.height / 2.0, self.view.frame.size.width / 2.0);
    }

    activityIndicator.center = myCenter;
    [self.view addSubview: activityIndicator];
    
    [activityIndicator startAnimating];
    return activityIndicator;
}

-(void) stopActivityIndicator
{
    [self.myActivityIndicator stopAnimating];
    self.myActivityIndicator = nil;
}

//
#pragma mark - timer test
//

- (id)myTimerTest
{
    if (!_myTimerTest){
        _myTimerTest = [[TimerTest alloc] init];
    }
    return _myTimerTest;
}

//
//
////////
#pragma mark - Coins
////////
//
//

- (bool) oneInTwo
{
    if (arc4random() % 2 == 1){
        return true;
    } else {
        return false;
    }
}

- (bool) oneInFour
{
    if (arc4random() % 4 == 1){
        return true;
    } else {
        return false;
    }
}

- (bool) oneInThree
{
    if (arc4random() % 3 == 1){
        return true;
    } else {
        return false;
    }
}

- (bool) oneInTen
{
    if (arc4random() % 10 == 1){
        return true;
    } else {
        return false;
    }
}

//
#pragma mark - Shuffle
//

- (NSArray*)shuffleArray:(NSArray*)myArray
{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:myArray];
    for(int i = (int)[myArray count]; i > 1; i--) {
        NSInteger j = (NSInteger)arc4random_uniform(i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    return [NSArray arrayWithArray:temp];
}

//
#pragma mark - Age Since Now
//

- (NSNumber*) ageComputation: (NSDate*)dateForBirth
{
    NSDate *now = [NSDate date];
    LOG NSLog(@"- (DOB) %@ -",dateForBirth);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *fromDate;
    NSDate *toDate;
    
    [calendar rangeOfUnit:NSYearCalendarUnit startDate:&fromDate
                 interval:NULL forDate:dateForBirth];
    [calendar rangeOfUnit:NSYearCalendarUnit startDate:&toDate
                 interval:NULL forDate:now];
    
    NSDateComponents *difference = [calendar components:NSYearCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [NSNumber numberWithInteger:[difference year]];
}

//
#pragma mark - Space Fixer
//

- (NSString*) sentenceSpaceFixer: (NSString*) theSentence withCaps: (BOOL)isInCaps
{
    NSMutableString* mystring = [[NSMutableString alloc]initWithString:theSentence];
    if ([mystring hasPrefix:@"  "]) {
        [mystring deleteCharactersInRange:NSMakeRange(0, 2)];
    }
    if ([theSentence hasPrefix:@" "]) {
        [mystring deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    if ([theSentence hasSuffix:@"  "]) {
        [mystring deleteCharactersInRange:NSMakeRange([mystring length]-1, 1)];
        [mystring deleteCharactersInRange:NSMakeRange([mystring length]-1, 1)];
    }
    if ([theSentence hasSuffix:@" "]) {
        [mystring deleteCharactersInRange:NSMakeRange([mystring length]-1, 1)];
    }
    mystring = [[mystring stringByReplacingOccurrencesOfString:@"  " withString:@" "] mutableCopy];
    mystring = [[mystring stringByReplacingOccurrencesOfString:@"  " withString:@" "] mutableCopy];
    mystring = [[mystring stringByReplacingOccurrencesOfString:@"   " withString:@" "] mutableCopy];
    mystring = [[mystring stringByReplacingOccurrencesOfString:@"    " withString:@" "] mutableCopy];
    
    if (isInCaps){
        mystring = [[mystring stringByReplacingCharactersInRange :NSMakeRange(0,1) withString:[[mystring substringToIndex:1] capitalizedString]]mutableCopy];
    }
    return [mystring copy];
}

- (NSString*) zeroSpaceFixer: (NSString*) theSentence
{
    if ([theSentence hasPrefix:@"  "]) {
        theSentence = [theSentence substringFromIndex:2];
    }
    if ([theSentence hasPrefix:@" "]) {
        theSentence = [theSentence substringFromIndex:1];
    }
    theSentence = [theSentence stringByReplacingOccurrencesOfString:@" " withString:@""];
    theSentence = [theSentence stringByReplacingOccurrencesOfString:@"  " withString:@""];
    theSentence = [theSentence stringByReplacingOccurrencesOfString:@"   " withString:@""];
    theSentence = [theSentence stringByReplacingOccurrencesOfString:@"    " withString:@""];
    
    return theSentence;
}

//
#pragma mark - Set to first Object
//

- (NSManagedObject*) myObject: (NSSet*) set
{
    NSArray*theArray = [set allObjects];
    return [theArray firstObject];
}

//
#pragma array duplicate remover
//

- (NSArray*) removeDuplicateObjects: (NSArray*) myArray
{
    NSSet*mySet = [NSSet setWithArray:myArray];
    return [mySet allObjects];
}

//
#pragma mark - UUID
//

- (NSString *) buildUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    NSString *uuidString =
    (__bridge_transfer NSString *)CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return uuidString;
}

//
#pragma mark - Date to String & Date Test
//

- (NSString*) dateStyle:(NSDate*)myDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MMMM-dd"];
    NSString *theDate = [dateFormat stringFromDate:myDate];
    return theDate;
}

- (NSString*) dateStyleNoYear:(NSDate*)myDate
{
    if (myDate == nil) return @" ";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM d"];
    NSString *prefixDateString = [dateFormat stringFromDate:myDate];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:myDate];
    NSInteger dayInt = [components day];
    NSString* suffix = [self addSuffixToNumber: dayInt];
    return [NSString stringWithFormat:@"%@%@",prefixDateString,suffix];
}

- (BOOL) isItDate: (NSString*) theString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MMMM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    dateFromString = [dateFormatter dateFromString:theString];
    
    if (dateFromString !=nil) {
        return true;
    }
    else {
        return false;
    }
}

- (NSString*) addSuffixToFullDate:(NSString*)myString
{
    NSInteger myInt = [myString integerValue];
    NSString* myNumberForReplacement = [[NSNumber numberWithInteger:myInt] stringValue];
    
    NSString* myNumberConverted = [self addSuffixToNumber:myInt];

    return [myString stringByReplacingOccurrencesOfString:myNumberForReplacement withString:myNumberConverted];
}


- (NSString *) addSuffixToNumber:(NSInteger) myNumber
{
    NSString *suffix;
    NSInteger ones = myNumber % 10;
    NSInteger temp = floor(myNumber/10.0);
    NSInteger tens = temp%10;
    
    if (tens == 1) {
        suffix = @"th";
    } else if (ones == 1){
        suffix = @"st";
    } else if (ones == 2){
        suffix = @"nd";
    } else if (ones == 3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    return suffix;
}

//
#pragma Mark - Save Data
//

- (void) saveData:(NSManagedObjectContext*)myContext
{
    LOG NSLog(@"saved!!");
    @try {
        NSError *error;
        if (![myContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    @catch (NSException *exception) {
        //[self myAlert:@"Could Not Save"];
    }
}

//
//
////
#pragma mark - Style
////
//
//

#define SHADOW_ALPHA 0.1f
#define SHADOW_COLOR [[UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:SHADOW_ALPHA] CGColor]

-(void)viewShadow: (UIView*)shadowObject
{
    [[shadowObject layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[shadowObject layer] setBorderWidth:0.8f];
    CGFloat radius = shadowObject.frame.size.width / 50;
    
    [[shadowObject layer] setCornerRadius:radius];
    shadowObject.layer.shadowOpacity = 1;
    shadowObject.layer.shadowRadius = 3;
    shadowObject.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    shadowObject.layer.shadowColor = SHADOW_COLOR;
}

-(void) buttonShadow: (UIButton*)shadowObject
{
    [[shadowObject layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[shadowObject layer] setBorderWidth:0.8f];
    CGFloat radius = shadowObject.frame.size.width / 50;
    
    [[shadowObject layer] setCornerRadius:radius];
    shadowObject.layer.shadowOpacity = 1;
    shadowObject.layer.shadowRadius = 3;
    shadowObject.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    shadowObject.layer.shadowColor = SHADOW_COLOR;
}

-(void) labelShadow: (UILabel*)shadowObject
{
    [[shadowObject layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[shadowObject layer] setBorderWidth:0.8f];
    CGFloat radius = shadowObject.frame.size.width / 50;
    
    [[shadowObject layer] setCornerRadius:radius];
    shadowObject.layer.shadowOpacity = 1;
    shadowObject.layer.shadowRadius = 3;
    shadowObject.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    shadowObject.layer.shadowColor = SHADOW_COLOR;
}

//
//
////////
#pragma mark - Test
////////
//
//

- (void) timeRunGameForTest
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:.001
                                                    target:self
                                                  selector:@selector(runTest)
                                                  userInfo:nil
                                                   repeats:YES];
    
}

- (void) simpleTestMethods
{
    //empty
}

#define LIMIT 500
- (void) runTest
{
    if (self.myTimerTest.myCounter == 0){
        [self.myTimerTest setTheStartTime];
    }
    [self simpleTestMethods];
    self.myTimerTest.myCounter ++;
    if (self.myTimerTest.myCounter > LIMIT){
        NSLog(@"finish");
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.myTimerTest.myCounter = 0;
        [self.myTimerTest setTheEndTime];
        [self.myTimerTest completionTime];
        [self.myTimerTest resetValues];
    }
}

- (void) timeTestStart
{
    [self.myTimerTest resetValues];
    [self.myTimerTest setTheStartTime];
}

- (void) timeTestUpdate
{
    [self.myTimerTest timeSinceStart];
}

//
//
////////
#pragma mark - speech
////////
//
//

- (id)mySpeechClass
{
    if (!_mySpeechClass){
        _mySpeechClass = [[SpeechClass alloc] init];
    }
    return _mySpeechClass;
}

-(void) foundationRunSpeech: (NSArray*) speechArray {
    if ([self.mySpeechClass runSpeech:speechArray]){
        LOG NSLog(@"playing");
    }
    else {
        LOG NSLog(@"stopped");
    }
}

- (void) foundationStopSpeech {
    [self.mySpeechClass stopSpeech];
}

- (void) foundationChangeSoudDefaults:(NSNotification *)notification {
    [self.mySpeechClass changeSoundDefaults];
}

- (void) loadSoundDefaultsNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(foundationChangeSoudDefaults:)
     name:@"soundStatusChange"
     object:nil];
}

//
//
////////
#pragma mark - swipe
////////
//
//

- (id) mySwipeClass
{
    if (!_mySwipeClass){
        _mySwipeClass = [[SwipeClass alloc] init];
    }
    return _mySwipeClass;
}

-(void) foundationSwipeSingleLoad: (UIView*)view
{
    [self.mySwipeClass swipeLoadSingle:view];
}

#pragma mark - Notification

- (void) loadSwipeNotification
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(swipeRightNotifier:)
     name:@"swipeRight"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(swipeLeftNotifier:)
     name:@"swipeLeft"
     object:nil];
}

- (void)swipeRightNotifier:(NSNotification *)notification {
}

- (void)swipeLeftNotifier:(NSNotification *)notification {
}

//
//
////////
#pragma mark - Alert View
////////
//
//

- (void) myAlert: (NSString*)myString
{
    UIAlertView *myAlert = [[UIAlertView alloc]
                            initWithTitle:myString
                            message:@""
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"ok", nil];
    myAlert.cancelButtonIndex = -1;
    [myAlert setTag:1000];
    [myAlert show];
}

//
#pragma mark - Text
//

- (IBAction)textFieldFinished:(id)sender {
    //empty
}

//
#pragma mark - loadG
//

- (UIImage*) loadBGImage: (NSString*) nameOfBG
{
    if ([nameOfBG length]) {
        NSString *fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",nameOfBG] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:fileName];
        return image;
    }
    return nil;
}

//
//
////
#pragma mark - Database Load
////
//
//

- (void) loadTheFoundationDataBase
{
    @try {
        GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        
        self.seedManagedObjectContext = nil;
        self.seedManagedObjectContext = appDelegate.seedManagedObjectContext;

        self.managedObjectContext = nil;
        self.managedObjectContext = appDelegate.managedObjectContext;
        
        LOG NSLog(@"Foundation String Name: %@",appDelegate.stringName);
    }
    @catch (NSException *exception) {
        LOG NSLog(@"Delegate Error");
        //[self myAlert:@"Could Not Load Delegate"];
    }
    @finally {
    }
}

//
//
////
#pragma mark - Life Cycle
////
//
//

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self loadTheFoundationDataBase];
    [self loadSoundDefaultsNotification];
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationItem.title=@"";
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    LOG NSLog(@"moved");
    [self foundationStopSpeech];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

//
//
////
#pragma mark - Cleaner
////
//
//

- (void) didMoveToParentViewController:(UIViewController *)parent
{
    if (![parent isEqual:self.parentViewController]) {
        [self myCleaner];
    }
}

- (void) myCleaner {
    UIViewController *vc = self;
    while ([vc presentingViewController] != NULL) {
        vc = [vc presentingViewController];
    }
    [self cleanTheSubview];
    [vc removeFromParentViewController];
    [vc dismissViewControllerAnimated:NO completion:nil];
}

- (void) cleanTheSubview
{
    for(UIView *subview in [self.view subviews]) {
        [subview removeFromSuperview];
    }
}

- (void) dealloc {
    LOG NSLog(@"Main Dealloc called");
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    @catch (NSException *exception) {
        LOG NSLog(@"Error: %@",exception);
    }
}

/*
 NSEntityDescription *entityDescription = [theGoalObject entity];
 NSDictionary * attributes = [entityDescription attributesByName];
 NSAttributeDescription *attributeDescription = entityDescription.attributesByName[@"age"];
 
 for (NSString * attributeName in [attributes allKeys]) {
 NSLog(@"1. %@",attributeName);
 }
*/

@end
