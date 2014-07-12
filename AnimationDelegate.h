
#import <Foundation/Foundation.h>

@class GenericAnimationView;

typedef enum {
    kSequenceAuto,
    kSequenceTriggered,
    kSequenceControlled,
} SequenceType;

typedef enum {
    kAnimationFlipVertical,
    kAnimationFlipHorizontal,
} AnimationType;

typedef enum {
    kDirectionNone,
    kDirectionForward,
    kDirectionBackward,
} DirectionType;

@interface AnimationDelegate : NSObject {
    
    CGImageRef transitionImageBackup;
    double currentDuration;
    DirectionType currentDirection;
    double value;
    double newValue;
    double oldOpacityValue;
}

@property (nonatomic, strong) GenericAnimationView *transformView;
@property (nonatomic, strong) id controller;

@property (nonatomic) double nextDuration;

@property (nonatomic) SequenceType sequenceType;
@property (nonatomic) NSInteger animationState;
@property (nonatomic) BOOL animationLock;

@property (nonatomic) BOOL shadow;

@property (nonatomic) NSInteger perspectiveDepth;

@property (nonatomic) double repeatDelay;
@property (nonatomic) BOOL repeat; 

@property (nonatomic) NSInteger sensitivity;

@property (nonatomic) NSInteger gravity;


- (id)initWithSequenceType:(SequenceType)aType
             directionType:(DirectionType)aDirection;

- (BOOL)startAnimation:(DirectionType)aDirection;

- (void)endStateWithSpeed:(double)aVelocity;
- (void)resetTransformValues;
- (void)setTransformValue:(double)aValue delegating:(BOOL)bValue;

- (void)setTransformProgress:(double)startTransformValue
                            :(double)endTransformValue
                            :(double)duration
                            :(NSInteger)aX
                            :(NSInteger)aY
                            :(NSInteger)aZ
                            :(BOOL)setDelegate
                            :(BOOL)removedOnCompletion
                            :(NSString *)fillMode
                            :(CALayer *)targetLayer;

- (void)setOpacityProgress:(double)startOpacityValue
                          :(double)endOpacityValue
                          :(double)beginTime
                          :(double)duration
                          :(NSString *)fillMode
                          :(CALayer *)targetLayer;

- (void)animationCallback;

@end
