//
//  UnderMenu.m
//  YolarooGrammar
//
//  Created by MGM on 5/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "UnderMenu.h"

@interface UnderMenu ()
{
    bool retryload;
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *mybigtextfieldarray;

@property (strong, nonatomic) IBOutlet UISwitch *soundchoice;

@property (strong,nonatomic) NSMutableArray* theLastAnswerArray;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) UIAlertView *myPermanentAlert;

@end

@implementation UnderMenu

@synthesize speechTextField=_speechTextField;

#define isDeviceIPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

#define DK 2
#define LOG if(DK == 1)

//
//
////////
#pragma mark - first check
////////
//
//

- (void) firstLoadCheck {
    if (![self hasFirstLoaded]){
        [self myPermanentAlert:@"Welcome, Loading Data"];

        [self saveSoundDefaultsOnFirstLoad];

        [self performSelector:@selector(mainMigrate) withObject:nil afterDelay:5.0];
        [self performSelector:@selector(saveFirstLoadDefault) withObject:nil afterDelay:10.0];
    }
}

- (void) myPermanentAlert: (NSString*)myString
{
    self.myPermanentAlert = [[UIAlertView alloc]
                            initWithTitle:myString
                            message:@""
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:nil, nil];
    self.myPermanentAlert.cancelButtonIndex = -1;
    [self.myPermanentAlert setTag:1000];
    [self.myPermanentAlert show];
    
}
 
//
//
////////
//
////////
//
//

- (void) saveSoundDefaultsOnFirstLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:FALSE forKey:@"sound"];
    [defaults synchronize];
}

- (BOOL) hasFirstLoaded {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"firstLoad"] == TRUE) {
        return true;
    }
    else {
        return false;
    }
}

- (void) saveFirstLoadDefault {
    NSLog(@"-- Save first load state --");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:TRUE forKey:@"firstLoad"];
    [defaults synchronize];
}

- (void) mainMigrate
{
    NSLog(@"migrate action");
    GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    @try {
        [appDelegate migrateFromSeed];
    }
    @catch (NSException *exception) {
        NSLog(@"migrate exception %@",exception);
        if (!retryload){
            retryload = true;
            [self performSelector:@selector(mainMigrate) withObject:nil afterDelay:5.0];
        }
    }
    @finally {
        [self.myPermanentAlert dismissWithClickedButtonIndex:0 animated:YES];
    }
}

//
//
///////
#pragma mark - reviewButton
///////
//
//

- (IBAction)reviewButtonPress:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id882997154?at=10l6dK"]];
}

//
//
///////
#pragma mark - sound switch
///////
//
//

- (IBAction)soundset:(UISwitch *)sender {
    NSLog(@"switch");
    if (self.soundchoice.on)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:FALSE forKey:@"sound"];
        [defaults synchronize];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"soundStatusChange"
         object:self];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:TRUE forKey:@"sound"];
        [defaults synchronize];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"soundStatusChange"
         object:self];
    }
}

//
//
///////
#pragma mark - load defaults
///////
//
//

- (void) loadDefaultsView {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"sound"] == TRUE) {
        [self.soundchoice setOn:NO animated:YES];
    }
    else {
        [self.soundchoice setOn:YES animated:YES];
    }
}

//
//
///////
#pragma mark - Fun sound Action
///////
//
//

- (IBAction)funSoundPress:(UIButton *)sender {
    NSString* myString = self.speechTextField.text;
    if ([myString length]) {
        [self foundationRunSpeech:@[myString]];
    }
    else {
        NSArray* speechArray = @[@"Hello",
                                 @"What's your name? ... speak up... i can't hear you.",
                                 @"How are you?",
                                 @"How's it going?",
                                 @"Hey. Hello. How're you doing?",
                                 @"This app is streets ahead.",
                                 @"Who wants ice cream?",
                                 @"What is your favorite cheese?",
                                 @"This app is fetch.",
                                 @"Where can I buy a laser cat?",
                                 @"All your bases are belong to us",
                                 @"anyone can play guitar",
                                 @"i should buy a boat",
                                 @"yes, of course",
                                 @"maybe",
                                 @"no",
                                 @"have you been working out",
                                 @"ask again later",
                                 @"why do they call it oval teen?  ... why don't they call it roundteen?",
                                 @"what is more amazing than a talking dog? ... A spelling be... ha ha.",
                                 @"perhaps. perhaps. perhaps.",
                                 @"if you buy two pieces of cake. You can have your cake and eat it to.",
                                 @"how i stopped worrying and learned to love vegetables",
                                 @"not likely",
                                 @"yes. no. maybe",
                                 @"nope nope nope",
                                 @"count down for sky net in... Five. Four. Three. Two...",
                                 @"eat healthy",
                                 @"go go team!",
                                 @"here have an upvote",
                                 @"down votes incoming",
                                 @"I'm so happy. I just got my letter to hogwarts.",
                                 @"make me an almond flower lemon cake for my birthday",
                                 @"Bacon is my second favorite thing in life, right after bacon... Maybe. Or maybe I need to change my priorities. ... or maybe ... bacon bacon bacon",
                                 @"i've been thinking about making the switch to green tea",
                                 @"Life always needs more cup cakes",
                                 @"I was told there would be punch and pie.",
                                 @"I smell cookies?",
                                 @"There are two types of people in the world. ... Those who can extrapolate from incomplete data. ...",
                                 @"I need to exercise.",
                                 @"I am like a lady bug with a top hat... I'm fancy.",
                                 @"don't tell anyone, but my favorite dance is the hampster dance",
                                 @"Candy corn looks like tiny traffic cones",
                                 @"I had a dream where I woke up as a donut...",
                                 @"rock paper scissors. ready? one, two, three. rock.",
                                 @"rock paper scissors. ready? one, two, three. paper.",
                                 @"rock paper scissors. ready? one, two, three. scissors.",
                                 @"knock knock",
                                 @"who is there?",
                                 @"bring back firefly",
                                 @"pizza is a vegetable",
                                 @"i invented the internet",
                                 @"have you ever counted to one Billion? ... Ok... ready? ... 1.... 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15. 16. ... ... just kidding! ... ha ha",
                                 @"been spending most my life, living in a grammar paradise",
                                 @"why did it have to be snakes?",
                                 @"what ever you do. do not brush your teeth with maple syrup.",
                                 @"I'm sorry but the princess is in another castle",
                                 @"why are dalmations bad at hide and seek? ... Because they are always spotted... ha ha."
                                 ];
        
        NSInteger myNumber = arc4random() % [speechArray count];

        while ([self.theLastAnswerArray containsObject:[NSNumber numberWithInteger:myNumber]]){
            myNumber = arc4random() % [speechArray count];
        }
        
        if ([self.theLastAnswerArray count] >= 20) {
            [self.theLastAnswerArray removeObjectAtIndex:0];
        }
        [self.theLastAnswerArray addObject:[NSNumber numberWithInteger:myNumber]];
        
        [self foundationRunSpeech:@[[speechArray objectAtIndex:myNumber]]];
    }
}

//
//
////////
//
////////
//
//

- (NSInteger) startTime {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:[NSDate date]];
    return [components hour];
}

- (NSString*) greetingReturn: (NSInteger) hour{
    if (hour > 5 && hour < 11){
        return @"good morning";
    }
    else if (hour >= 11 && hour < 17){
        return @"good afternoon";
    }
    else if (hour >= 17){
        return @"good evening";
    }
    else if (hour < 5) {
        return @"good evening";
    }
    else {
        return @"good day";
    }
}

- (void) audioGreeting {
    [self foundationRunSpeech:@[[NSString stringWithFormat:@"Hello. ... %@. ... Welcome. ... Let's read and learn.",[self greetingReturn:[self startTime]]]]];
}

//
//
///////
#pragma mark - Life cycle
///////
//
//

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = true;
    [self scrollViewSet];
    [self loadDefaultsView];
}

- (void) scrollViewSet {
    double myScrollOffset = 1.25;
    self.myScrollView.contentSize = CGSizeMake((self.myScrollView.frame.size.width) , self.myScrollView.frame.size.height*myScrollOffset );
    [self.myScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // migrate on firt load
    [self firstLoadCheck];

    self.navigationController.navigationBarHidden = true;
    if (isDeviceIPad){
        [self.slidingViewController setAnchorRightRevealAmount:420.0f];
        self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    }
    else {
        [self.slidingViewController setAnchorRightRevealAmount:220.0f];
        self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    }
    [self viewStyleForLoad];
    
    // Greeting
    [self performSelector:@selector(audioGreeting) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
    for(UIButton* BTN in self.myButtonCollection){
        [self buttonShadow:BTN];
    }
}

//
////
//

- (NSMutableArray*) theLastAnswerArray {
    if (!_theLastAnswerArray) {
        _theLastAnswerArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _theLastAnswerArray;
}



@end
