

#import "GenericAnimationView.h"

@interface FlipView : GenericAnimationView

@property (nonatomic) float sublayerCornerRadius;
@property (nonatomic, strong) NSMutableString* currentString;

- (BOOL) printText:(NSString *)tickerString
        usingImage:(UIImage *)aImage
   backgroundColor:(UIColor *)aBackgroundColor
         textColor:(UIColor *)aTextColor;

- (void)rearrangeLayers:(DirectionType)aDirectionType :(int)step;

@end
