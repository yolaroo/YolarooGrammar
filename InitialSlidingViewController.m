
#import "InitialSlidingViewController.h"

@interface InitialSlidingViewController ()

@end
@implementation InitialSlidingViewController

- (void) viewDidLoad {
  [super viewDidLoad];

  UIStoryboard *storyboard;
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
  } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
  }
    self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"RootNavigation"];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
