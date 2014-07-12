
#import "AnimationDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "GenericAnimationView.h"
#import "AnimationFrame.h"

@implementation AnimationDelegate

@synthesize transformView;
@synthesize controller;
@synthesize nextDuration;
@synthesize sequenceType;
@synthesize animationState;
@synthesize animationLock;
@synthesize shadow;
@synthesize repeatDelay;
@synthesize repeat;
@synthesize sensitivity;
@synthesize gravity;
@synthesize perspectiveDepth;

//
#pragma mark - init
//

- (id)initWithSequenceType:(SequenceType)aType
             directionType:(DirectionType)aDirection 
{
    if ((self = [super init])) {
        
        transformView = nil;
        controller = nil;
        
        sequenceType = aType;
        currentDirection = aDirection;
        repeat = NO;
        
        nextDuration = 0.6;
        repeatDelay = 0.2;
        sensitivity = 40;
        gravity = 2;
        perspectiveDepth = 500;
        shadow = YES;
        
        if (sequenceType == kSequenceAuto) {
            repeat = YES;
        } else {
            repeat = NO;
        }
        
    }
    return self;
}

//
#pragma mark - Animation automation
//


- (BOOL)startAnimation:(DirectionType)aDirection 
{
    return NO;
}

- (void)animationDidStop:(CABasicAnimation *)theAnimation finished:(BOOL)flag
{
    if (flag) {
        switch (animationState) {
            case 0:
                break;
            case 1: {
                switch (transformView.animationType) {
                    case kAnimationFlipVertical:
                    case kAnimationFlipHorizontal: {
                        [self animationCallback];
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    }
}
 
- (void)animationCallback 
{
    [self resetTransformValues];
}

//
#pragma mark - transform values
//

- (void)endStateWithSpeed:(double)aVelocity
{
    if (value == 0.0f) {
        [self resetTransformValues];
    } else if (value == 10.0f) {
        [self resetTransformValues];
    } else {
        AnimationFrame* currentFrame = [transformView.imageStackArray lastObject];
        CALayer *targetLayer;
        
        NSInteger aX, aY, aZ;
        NSInteger rotationModifier;
        
        switch (transformView.animationType) {
            case kAnimationFlipVertical:
                aX = 1;
                aY = 0;
                aZ = 0;
                rotationModifier = -1;
                break;
            case kAnimationFlipHorizontal:
                aX = 0;
                aY = 1;
                aZ = 0;
                rotationModifier = 1;
                break;
            default:break;
        }
        
        double rotationAfterDirection = 0;
        
        if (currentDirection == kDirectionForward) {
            rotationAfterDirection = M_PI * rotationModifier;
            targetLayer = [currentFrame.animationImages lastObject];
        } else if (currentDirection == kDirectionBackward) {
            rotationAfterDirection = -M_PI * rotationModifier;
            targetLayer = [currentFrame.animationImages objectAtIndex:0];
        }
        else {
        }
        CALayer *targetShadowLayer;
        
        CATransform3D aTransform = CATransform3DIdentity;
        aTransform.m34 = 1.0 / -perspectiveDepth;
        [targetLayer setValue:[NSValue valueWithCATransform3D:CATransform3DRotate(aTransform,rotationAfterDirection/10.0 * value, aX, aY, aZ)] forKeyPath:@"transform"];
        for (CALayer *layer in targetLayer.sublayers) {
            [layer removeAllAnimations];
        }
        [targetLayer removeAllAnimations];
        
        if (gravity > 0) {
            
            animationState = 1;
            
            if (value+aVelocity <= 5.0f) {
                targetShadowLayer = [targetLayer.sublayers objectAtIndex:1];
                
                [self setTransformProgress:rotationAfterDirection / 10.0 * value
                                          :0.0f
                                          :1.0f/(gravity+aVelocity)
                                          :aX :aY :aZ
                                          :YES
                                          :NO
                                          :kCAFillModeForwards 
                                          :targetLayer];
                if (shadow) {
                    [self setOpacityProgress:oldOpacityValue 
                                            :0.0f
                                            :0.0f
                                            :currentDuration 
                                            :kCAFillModeForwards 
                                            :targetShadowLayer];
                }
                value = 0.0f;
            } else {
                targetShadowLayer = [targetLayer.sublayers objectAtIndex:3];
                
                [self setTransformProgress:rotationAfterDirection / 10.0 * value
                                          :rotationAfterDirection
                                          :1.0f/(gravity+aVelocity)
                                          :aX :aY :aZ
                                          :YES
                                          :NO
                                          :kCAFillModeForwards 
                                          :targetLayer];
                if (shadow) {
                    [self setOpacityProgress:oldOpacityValue 
                                            :0.0f
                                            :0.0f
                                            :currentDuration 
                                            :kCAFillModeForwards 
                                            :targetShadowLayer];
                }
                value = 10.0f;
            }
        }
    }
}

//
#pragma mark - Change layer order for animation
//

- (void)resetTransformValues
{
    AnimationFrame* currentFrame = [transformView.imageStackArray lastObject];
    
    CALayer *targetLayer;
    CALayer *targetShadowLayer, *targetShadowLayer2;
    
    if (currentDirection == kDirectionForward) {
        targetLayer = [currentFrame.animationImages lastObject];
    } else if (currentDirection == kDirectionBackward) {
        targetLayer = [currentFrame.animationImages objectAtIndex:0];
    }
    
    targetShadowLayer = [targetLayer.sublayers objectAtIndex:1];
    targetShadowLayer2 = [targetLayer.sublayers objectAtIndex:3];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [targetLayer setValue:[NSValue valueWithCATransform3D:CATransform3DIdentity] forKeyPath:@"transform"];
    targetShadowLayer.opacity = 0.0f;
    targetShadowLayer2.opacity = 0.0f;
    
    for (CALayer *layer in targetLayer.sublayers) {
        [layer removeAllAnimations];
    }
    [targetLayer removeAllAnimations];
    
    targetLayer.zPosition = 0;
    
    CATransform3D aTransform = CATransform3DIdentity;
    targetLayer.sublayerTransform = aTransform;
    
    if (value == 10.0f) {
        [transformView rearrangeLayers:currentDirection :3];
    } else {
        [transformView rearrangeLayers:currentDirection :2];
    }
    
    [CATransaction commit];
    
    //
    //// finish notification
    //
    /*
    if (currentDirection == kDirectionForward && value == 10.0f) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"layerChange"
         object:self];
    } else if (currentDirection == kDirectionBackward && value == 10.0f) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"layerChange"
         object:self];
    }
     */
    animationState = 0;
    animationLock = NO;
    transitionImageBackup = nil;
    value = 0.0f;
    oldOpacityValue = 0.0f;
     
}

//
#pragma mark - transform values
//

- (void)setTransformValue:(double)aValue delegating:(BOOL)bValue
{
    currentDuration = nextDuration;
    
    NSInteger frameCount = [transformView.imageStackArray count];
    AnimationFrame* currentFrame = [transformView.imageStackArray lastObject];
    CALayer *targetLayer;
    AnimationFrame* nextFrame = [transformView.imageStackArray objectAtIndex:frameCount-2];
    AnimationFrame* previousFrame = [transformView.imageStackArray objectAtIndex:0];

    NSInteger aX, aY, aZ;
    NSInteger rotationModifier;
    
    switch (transformView.animationType) {
        case kAnimationFlipVertical:
            aX = 1;
            aY = 0;
            aZ = 0;
            rotationModifier = -1;
            break;
        case kAnimationFlipHorizontal:
            aX = 0;
            aY = 1;
            aZ = 0;
            rotationModifier = 1;
            break;
        default:break;
    }
    
    double rotationAfterDirection = 0.0f;
    
    if (transitionImageBackup == nil) {
        if (aValue - value >= 0.0f) {
            currentDirection = kDirectionForward;
            switch (transformView.animationType) {
                case kAnimationFlipVertical:
                case kAnimationFlipHorizontal: {
                    targetLayer = [currentFrame.animationImages lastObject];
                    targetLayer.zPosition = 100;
                }
                    break;
                default:
                    break;
            }
            animationState++;
        } else if (aValue - value < 0.0f) {
            currentDirection = kDirectionBackward;
            [transformView rearrangeLayers:currentDirection :1];
            switch (transformView.animationType) {
                case kAnimationFlipVertical:
                case kAnimationFlipHorizontal: {
                    targetLayer = [currentFrame.animationImages objectAtIndex:0];
                    targetLayer.zPosition = 100;
                }
                    break;
                default:
                    break;
            }
            animationState++;
        }
    }
    
    if (currentDirection == kDirectionForward) {
        rotationAfterDirection = M_PI * rotationModifier;
        targetLayer = [currentFrame.animationImages lastObject];
    } else if (currentDirection == kDirectionBackward) {
        rotationAfterDirection = -M_PI * rotationModifier;
        targetLayer = [currentFrame.animationImages objectAtIndex:0];
    }
    
    double adjustedValue;
    double opacityValue = 0.0f;
    if (sequenceType == kSequenceControlled) {
        adjustedValue = fabs(aValue * (sensitivity/1000.0));
    } else {
        adjustedValue = fabs(aValue);
    }
    adjustedValue = MAX(0.0, adjustedValue);
    adjustedValue = MIN(10.0, adjustedValue);
    
    if (adjustedValue <= 5.0f) {
        opacityValue = adjustedValue/10.0f;
    } else if (adjustedValue > 5.0f) {
        opacityValue = (10.0f - adjustedValue)/10.0f;
    }
    
    CALayer *targetFrontLayer, *targetBackLayer = nil;
    CALayer *targetShadowLayer, *targetShadowLayer2 = nil;

    //
    //// reverse image on flip
    //
    
    switch (transformView.animationType) {
        case kAnimationFlipVertical: {
            switch (currentDirection) {
                case kDirectionForward: {
                    targetFrontLayer = [targetLayer.sublayers objectAtIndex:2];
                    CALayer *nextLayer = [nextFrame.animationImages objectAtIndex:0];
                    targetBackLayer = [nextLayer.sublayers objectAtIndex:0];
                }
                    break;
                case kDirectionBackward: {
                    targetFrontLayer = [targetLayer.sublayers objectAtIndex:2];
                    CALayer *previousLayer = [previousFrame.animationImages objectAtIndex:1];
                    targetBackLayer = [previousLayer.sublayers objectAtIndex:0];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case kAnimationFlipHorizontal: {
            
            switch (currentDirection) {
                case kDirectionForward: {
                    targetFrontLayer = [targetLayer.sublayers objectAtIndex:2];
                    CALayer *nextLayer = [nextFrame.animationImages objectAtIndex:0];
                    targetBackLayer = [nextLayer.sublayers objectAtIndex:0];
                }
                    break;
                case kDirectionBackward: {
                    targetFrontLayer = [targetLayer.sublayers objectAtIndex:2];
                    CALayer *previousLayer = [previousFrame.animationImages objectAtIndex:1];
                    targetBackLayer = [previousLayer.sublayers objectAtIndex:0];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:break;
    }
    
    //
    //// shadow
    //
    
   if (adjustedValue == 10.0f && value == 0.0f) {
        targetShadowLayer = [targetLayer.sublayers objectAtIndex:1];
        targetShadowLayer2 = [targetLayer.sublayers objectAtIndex:3];
    }
    else if (adjustedValue <= 5.0f) {
        targetShadowLayer = [targetLayer.sublayers objectAtIndex:1];
    } 
    else {
        targetShadowLayer = [targetLayer.sublayers objectAtIndex:3];
    }
    
    //
    //// ???
    ///////////
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CATransform3D aTransform = CATransform3DIdentity;
    aTransform.m34 = 1.0 / -perspectiveDepth;
    [targetLayer setValue:[NSValue valueWithCATransform3D:CATransform3DRotate(aTransform, rotationAfterDirection/10.0 * value, aX, aY, aZ)] forKeyPath:@"transform"];
    targetShadowLayer.opacity = oldOpacityValue;
    if (targetShadowLayer2) targetShadowLayer2.opacity = oldOpacityValue;
    for (CALayer *layer in targetLayer.sublayers) {
        [layer removeAllAnimations];
    }
    [targetLayer removeAllAnimations];
    
    [CATransaction commit];
    ///////////
    //// ???
    //
    
    //
    //// the transformation
    //
    
    if (adjustedValue != value) {
        
        CATransform3D aTransform = CATransform3DIdentity;
        aTransform.m34 = 1.0 / -perspectiveDepth;
        targetLayer.sublayerTransform = aTransform;
        
        if (transitionImageBackup == nil) {
            
            CGImageRef tempImageRef = (__bridge CGImageRef)targetBackLayer.contents;
            
            transitionImageBackup = (__bridge CGImageRef)targetFrontLayer.contents;
            targetFrontLayer.contents = (__bridge id)tempImageRef;
            
        }
        
        [self setTransformProgress:(rotationAfterDirection/10.0 * value)
                                  :(rotationAfterDirection/10.0 * adjustedValue)
                                  :currentDuration
                                  :aX :aY :aZ
                                  :bValue
                                  :NO
                                  :kCAFillModeForwards 
                                  :targetLayer];
        
        if (shadow) {
            if (oldOpacityValue == 0.0f && oldOpacityValue == opacityValue) {
                
                [self setOpacityProgress:0.0f 
                                        :0.5f
                                        :0.0f
                                        :currentDuration/2 
                                        :kCAFillModeForwards 
                                        :targetShadowLayer];
                [self setOpacityProgress:0.5f 
                                        :0.0f
                                        :currentDuration/2
                                        :currentDuration/2 
                                        :kCAFillModeBackwards 
                                        :targetShadowLayer2];
            } else {
                [self setOpacityProgress:oldOpacityValue 
                                        :opacityValue
                                        :0.0f
                                        :currentDuration 
                                        :kCAFillModeForwards 
                                        :targetShadowLayer];
            }
        }
        value = adjustedValue;
        oldOpacityValue = opacityValue;
        
    }
     
}

//
#pragma mark - transform
//

- (void)setTransformProgress:(double)startTransformValue
                            :(double)endTransformValue
                            :(double)duration
                            :(NSInteger)aX
                            :(NSInteger)aY
                            :(NSInteger)aZ
                            :(BOOL)setDelegate
                            :(BOOL)removedOnCompletion
                            :(NSString *)fillMode
                            :(CALayer *)targetLayer
{
    CATransform3D aTransform = CATransform3DIdentity;
    aTransform.m34 = 1.0 / -perspectiveDepth;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.duration = duration;
    anim.fromValue= [NSValue valueWithCATransform3D:CATransform3DRotate(aTransform, startTransformValue, aX, aY, aZ)];
    anim.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(aTransform, endTransformValue, aX, aY, aZ)];
    if (setDelegate) {
        anim.delegate = self;
    }
    anim.removedOnCompletion = removedOnCompletion;
    [anim setFillMode:fillMode];
    
    [targetLayer addAnimation:anim forKey:@"transformAnimation"];
}

//
#pragma mark - transform
//

- (void)setOpacityProgress:(double)startOpacityValue
                          :(double)endOpacityValue
                          :(double)begNSIntegerime
                          :(double)duration
                          :(NSString *)fillMode
                          :(CALayer *)targetLayer
{
    CFTimeInterval localMediaTime = [targetLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.duration = duration;
    anim.fromValue= [NSNumber numberWithDouble:startOpacityValue];
    anim.toValue= [NSNumber numberWithDouble:endOpacityValue];
    anim.beginTime = localMediaTime+begNSIntegerime;
    anim.removedOnCompletion = NO;
    [anim setFillMode:fillMode];
    
    [targetLayer addAnimation:anim forKey:@"opacityAnimation"];
}

@end
