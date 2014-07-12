
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

extern NSString *const ECSlidingViewUnderRightWillAppear;
extern NSString *const ECSlidingViewUnderLeftWillAppear;
extern NSString *const ECSlidingViewUnderLeftWillDisappear;
extern NSString *const ECSlidingViewUnderRightWillDisappear;
extern NSString *const ECSlidingViewTopDidAnchorLeft;
extern NSString *const ECSlidingViewTopDidAnchorRight;
extern NSString *const ECSlidingViewTopWillReset;
extern NSString *const ECSlidingViewTopDidReset;

typedef enum {
  ECFullWidth,
  ECFixedRevealWidth,
  ECVariableRevealWidth
} ECViewWidthLayout;

typedef enum {
  ECLeft,
  ECRight
} ECSide;

typedef enum {
  ECNone = 0,
  ECTapping = 1 << 0,
  ECPanning = 1 << 1
} ECResetStrategy;

@interface ECSlidingViewController : UIViewController {
  CGPoint startTouchPosition;
  BOOL topViewHasFocus;
}

@property (nonatomic, strong) UIViewController *underLeftViewController;
@property (nonatomic, strong) UIViewController *underRightViewController;
@property (nonatomic, strong) UIViewController *topViewController;

@property (nonatomic, assign) CGFloat anchorLeftPeekAmount;
@property (nonatomic, assign) CGFloat anchorRightPeekAmount;
@property (nonatomic, assign) CGFloat anchorLeftRevealAmount;
@property (nonatomic, assign) CGFloat anchorRightRevealAmount;
@property (nonatomic, assign) BOOL shouldAllowPanningPastAnchor;
@property (nonatomic, assign) BOOL shouldAllowUserInteractionsWhenAnchored;
@property (nonatomic, assign) BOOL shouldAddPanGestureRecognizerToTopViewSnapshot;

@property (nonatomic, assign) ECViewWidthLayout underLeftWidthLayout;
@property (nonatomic, assign) ECViewWidthLayout underRightWidthLayout;
@property (nonatomic, assign) ECResetStrategy resetStrategy;
@property (nonatomic, assign) NSUInteger panningVelocityXThreshold;
@property (nonatomic,copy) void (^topViewCenterMoved)(float xPos);

- (UIPanGestureRecognizer *)panGesture;
- (void)anchorTopViewTo:(ECSide)side;
- (void)anchorTopViewTo:(ECSide)side animations:(void(^)())animations onComplete:(void(^)())complete;
- (void)anchorTopViewOffScreenTo:(ECSide)side;
- (void)anchorTopViewOffScreenTo:(ECSide)side animations:(void(^)())animations onComplete:(void(^)())complete;

- (void)resetTopView;
- (void)resetTopViewWithAnimations:(void(^)())animations onComplete:(void(^)())complete;
- (BOOL)underLeftShowing;
- (BOOL)underRightShowing;
- (BOOL)topViewIsOffScreen;

@end

@interface UIViewController(SlidingViewExtension)
- (ECSlidingViewController *)slidingViewController;
@end