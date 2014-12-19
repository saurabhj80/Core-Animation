//
//  ViewController.m
//  Learning Core Animation
//
//  Created by Saurabh Jain on 12/18/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerview; // SuperView
@property (nonatomic, strong)  UIView *coneView;

@end

@implementation ViewController

-(UIView *)coneView
{
    if (!_coneView) {
        _coneView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    }
    return _coneView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.layerview addSubview:self.coneView];
    
    UIImage* image = [UIImage imageNamed:@"logo.png"];
    
    // Setting Background Color
    [self setBackgroungColorToLayer:[UIColor blackColor] toLayer:self.coneView.layer];
    
    // Setting Image To layer
    [self setImageToLayer:image toLayer:self.coneView.layer];
    
    // Setting a strechable image. Can also be done in the attributes inspector
    [self addStrechableImage:image withContenCenter:CGRectMake(0.25, 0.25, 0.75, 0.75) toViewLayer:self.coneView.layer];
    
    // Implementing the CALayerDelegate
    CALayer* bluelayer          = [CALayer layer];
    bluelayer.backgroundColor   = [UIColor blueColor].CGColor;
    bluelayer.frame             = CGRectMake(200, 200, 100, 100);
    
    bluelayer.delegate = self;
    
    [self.layerview.layer addSublayer:bluelayer];
    
    [bluelayer display]; // To Update the layer's content
    
    // Creating layer heirarchies. redlayer on bluelayer on superlayer.
    CALayer* redlayer           = [CALayer layer];
    redlayer.backgroundColor    = [UIColor redColor].CGColor;
    redlayer.frame              = CGRectMake(0, 0, bluelayer.bounds.size.width , bluelayer.bounds.size.height); // 0,0 due to bounds                 property of bluelayer.
    
    [bluelayer addSublayer:redlayer];
    
    // Shadows
    bluelayer.shadowOpacity = 0.5;              // Can be within 0 and 1
    bluelayer.shadowOffset = CGSizeMake(3, 3);
    bluelayer.shadowRadius = 5;                 // Makes the shadow blurry
    
    bluelayer.cornerRadius = 10;
    bluelayer.masksToBounds = YES; // Clips all sublayers to the layers bounds.
    // When we run the application then the shadow has been applied but it is important to note that the shadow is clipped due to masksToBounds property.
    
    
    /*  To add a shadow we add a layer, which i have named shadowlayer.
        Now superlayer->shadowlayer->bluelayer->redlayer.
        We apply the shadow to the shadowlayer and now the shadow appears.
     */
    
    CALayer* shadowlayer = [CALayer layer];
    shadowlayer.backgroundColor = [UIColor blackColor].CGColor;
    shadowlayer.frame = CGRectMake(100, 100, 100 , 100);
    [self.layerview.layer replaceSublayer:bluelayer with:shadowlayer];

    shadowlayer.shadowOpacity = 0.5;
    shadowlayer.shadowOffset = CGSizeMake(3, 3);
    shadowlayer.shadowRadius = 5;
    shadowlayer.cornerRadius = bluelayer.cornerRadius;
    
    bluelayer.frame = CGRectMake(0, 0, shadowlayer.bounds.size.width , shadowlayer.bounds.size.height); // 0,0 due to bounds                 property of shadowlayer.
    [shadowlayer addSublayer:bluelayer];
    
}

#pragma mark - UIView sets itself as the delegate of its back layer

/* When UIView creates its backing layer, it automatically sets itself as the layer’s delegate and provides an implementation for -displayLayer: that abstracts these issues away.
*/

// This method gets called on even in the presence of CALayerDelegate - drawLayer method below

// Can implement drawRect method also instead of displayLayer method
-(void)displayLayer:(CALayer *)layer
{
    layer.backgroundColor = [UIColor yellowColor].CGColor;

}

#pragma mark - CALayerDelegate

// Can implement drawRect method also instead of drawLayer method

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

#pragma mark - Helper Methods

- (void) addStrechableImage:(UIImage *)image withContenCenter:(CGRect)rect toViewLayer:(CALayer*)layer
{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsCenter = rect;
}

- (void) setImageToLayer:(UIImage*)image toLayer:(CALayer *)layer
{
    layer.contents = (__bridge id)image.CGImage;
}

- (void) setBackgroungColorToLayer:(UIColor*)color toLayer:(CALayer *)layer
{
    layer.backgroundColor = color.CGColor;
}

@end
