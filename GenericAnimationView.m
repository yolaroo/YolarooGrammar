#import "GenericAnimationView.h"

@implementation GenericAnimationView

@synthesize imageStackArray;
@synthesize textInset;
@synthesize textOffset;
@synthesize fontSize;
@synthesize font;
@synthesize fontAlignment;
@synthesize textTruncationMode;
@synthesize animationType;

#define TEXT_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.2f]
#define NUMBER_OFLINES 6

#pragma mark - Init

- (id)initWithAnimationType:(AnimationType)aType
                     frame:(CGRect)aFrame
{
    self = [super init];
    if (self) {
        animationType = aType;
        textOffset = CGPointZero;
        textInset = CGPointZero;
        self.imageStackArray = [NSMutableArray array];
        templateWidth = aFrame.size.width;
        templateHeight = aFrame.size.height;
        self.frame = aFrame;
    }
    return self;
}

#pragma mark - Write Text To UILabel and then to CALayer

- (BOOL)printText:(NSString *) myTextString
       usingImage:(UIImage *) aImage
  backgroundColor:(UIColor *) aBackgroundColor
        textColor:(UIColor *) aTextColor {
    
    if (myTextString) {
        
        CALayer *backingLayer = [CALayer layer];
        backingLayer.contentsGravity = kCAGravityResizeAspect;
        backingLayer.opaque = YES;

        backingLayer.frame = CGRectMake(0, 0, templateWidth, templateHeight);

        if (aImage) {
            aImage = [self imageWithImage:aImage scaledToSize:backingLayer.frame.size];
            [backingLayer setContents:(id)aImage.CGImage];
        }
        
        if (aBackgroundColor) {
            backingLayer.backgroundColor = aBackgroundColor.CGColor;
        }
        
        CGRect boundsAfterInset = CGRectInset(backingLayer.bounds, textInset.x, textInset.y);
        CATextLayer *label = [CATextLayer layer];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        UIFont * labelFont = [UIFont fontWithName:font size:fontSize];
        paragraphStyle.lineSpacing = fontSize/4;
        UIColor * labelColor =  aTextColor;
        NSShadow *shadow = [[NSShadow alloc] init];

        [shadow setShadowColor: TEXT_SHADOW];
        [shadow setShadowOffset:CGSizeMake (1.0, 1.0)];
        [shadow setShadowBlurRadius:1];

        NSAttributedString *attributedStringForLabelText = [[NSAttributedString alloc] initWithString: myTextString
                                                                        attributes: @{
                                                              NSFontAttributeName : labelFont,
                                                     NSParagraphStyleAttributeName:paragraphStyle,
                                                               NSKernAttributeName: @2.0,
                                                   NSForegroundColorAttributeName : labelColor,
                                                            NSShadowAttributeName : shadow }];
        
        CGRect rect = [attributedStringForLabelText boundingRectWithSize:CGSizeMake(templateWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];

        rect.size.width = templateWidth;
        UILabel*myLabel = [[UILabel alloc]init];
        myLabel.attributedText = attributedStringForLabelText;
        myLabel.backgroundColor = [UIColor clearColor];
        
        myLabel.numberOfLines = NUMBER_OFLINES;
        myLabel.lineBreakMode = NSTextAlignmentCenter;
        [myLabel sizeToFit];
        myLabel.frame =rect;
        
        [label addSublayer:myLabel.layer];

        /*
        label.font = (__bridge CFTypeRef)(font);
        label.fontSize = fontSize;
        label.contentsScale = [[UIScreen mainScreen] scale];
        label.truncationMode = textTruncationMode;
        label.alignmentMode = fontAlignment;
        if (aTextColor) {
            label.foregroundColor = aTextColor.CGColor;
        }
        */

        label.wrapped = true;
        label.contentsGravity = kCAGravityResizeAspect;
        label.bounds = boundsAfterInset;
        label.position = CGPointMake(backingLayer.position.x + textOffset.x, backingLayer.position.y + textOffset.y);
        
        [backingLayer addSublayer:label];
        
        CGFloat scale = [[UIScreen mainScreen] scale];
        CGSize size = CGSizeMake(backingLayer.frame.size.width*scale*2, backingLayer.frame.size.height*scale);
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [backingLayer renderInContext:context];
        
        templateImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        [label removeFromSuperlayer];

        attributedStringForLabelText = nil;
        paragraphStyle = nil;
        backingLayer = nil;
        
    } else {
        templateImage = aImage;
    }

    if (templateImage) {
        return YES;
    }
    
    return NO;
}

//
////
//

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//
////
//

#pragma mark - Make CALayer

- (CALayer *)layerWithFrame:(CGRect)aFrame
             contentGravity:(NSString *)aContentGravity
               cornerRadius:(float)aRadius
                doubleSided:(BOOL)aValue
{
    CALayer *layer = [CALayer layer];
    layer.frame = aFrame;
    if (aContentGravity) {
        layer.contentsGravity = aContentGravity;
    }
    layer.cornerRadius = aRadius;
    layer.doubleSided = NO;
    layer.masksToBounds = YES;
    layer.doubleSided = NO;
    layer.contentsGravity = kCAGravityResizeAspect;
    
    return layer;
}

- (void)rearrangeLayers:(DirectionType)aDirectionType :(int)step {
    // for subclass to implement
}

- (void)dealloc
{
    [imageStackArray removeAllObjects];
}

@end
