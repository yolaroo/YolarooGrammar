
#import "AnimationFrame.h"

@implementation AnimationFrame

@synthesize lastIndex;
@synthesize rootAnimationLayer;
@synthesize animationImages;
@synthesize name;

//
#pragma mark - init
//

- (id)init 
{    
    if ((self = [super init])) {
        self.animationImages = [NSMutableArray array];
        self.rootAnimationLayer = [CALayer layer];
    }
    return self;
}

//
#pragma mark - load layers into view object
//

- (void)addLayers:(NSString*)myName withLayer:(CALayer *)layer, ...
{
    NSInteger index = [layer.superlayer.sublayers count];
    va_list args;
    va_start(args, layer);

    for (CALayer *arg = layer; arg != nil; arg = va_arg(args, CALayer *)) {
        self.name = myName;
        [animationImages addObject:arg];
    }
    
    va_end(args);
    lastIndex = index;
}

- (void)dealloc
{
    [animationImages removeAllObjects];
}

@end
