

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "AnimationDelegate.h"
#import "AnimationFrame.h"

@interface GenericAnimationView : UIView {
    UIImage *templateImage;
    float templateWidth;
    float templateHeight;
    int imageUnitQuantity;
}

@property (nonatomic, strong) NSMutableArray *imageStackArray;

@property (nonatomic) CGPoint textInset;

@property (nonatomic) CGPoint textOffset;
@property (nonatomic) float fontSize;
@property (nonatomic, unsafe_unretained) NSString *font;
@property (nonatomic, unsafe_unretained) NSString *fontAlignment;
@property (nonatomic, unsafe_unretained) NSString *textTruncationMode;
@property (nonatomic) AnimationType animationType;

- (id)initWithAnimationType:(AnimationType)aType
                      frame:(CGRect)aFrame;

- (BOOL)printText:(NSString *)tickerString
       usingImage:(UIImage *)aImage
  backgroundColor:(UIColor *)aBackgroundColor
        textColor:(UIColor *)aTextColor;

- (CALayer *)layerWithFrame:(CGRect)aFrame
             contentGravity:(NSString *)aContentGravity
               cornerRadius:(float)aRadius
                doubleSided:(BOOL)aValue;

- (void)rearrangeLayers:(DirectionType)aDirectionType :(int)step;

@end
