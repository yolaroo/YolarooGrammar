
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface AnimationFrame : NSObject

@property (nonatomic) NSInteger lastIndex;
@property (nonatomic, strong) CALayer *rootAnimationLayer;
@property (nonatomic, strong) NSMutableArray *animationImages;
@property (nonatomic, strong) NSString *name;

- (void)addLayers: (NSString*)myName withLayer:(CALayer *)layer, ...NS_REQUIRES_NIL_TERMINATION;

@end
