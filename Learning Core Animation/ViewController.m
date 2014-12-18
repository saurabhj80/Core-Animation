//
//  ViewController.m
//  Learning Core Animation
//
//  Created by Saurabh Jain on 12/18/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerview;
@property (nonatomic, strong)  UIView *coneView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.coneView = [[UIView alloc] init];
    
    self.coneView.frame = CGRectMake(100, 100, 100, 100);
    
    [self.layerview addSubview:self.coneView];
    
    UIImage* image = [UIImage imageNamed:@"logo.png"];
    
    // Setting Background Color
    [self setBackgroungColorToLayer:[UIColor blackColor] toLayer:self.coneView.layer];
    
    
    // Setting Image To layer
    [self setImageToLayer:image toLayer:self.coneView.layer];
    
    
    // Setting a strechable image
    [self addStrechableImage:image withContenCenter:CGRectMake(0.25, 0.25, 0.75, 0.75) toViewLayer:self.coneView.layer];
    
    // Implementing the CALayerDelegate
    
    CALayer* bluelayer = [CALayer layer];
    bluelayer.backgroundColor = [UIColor blueColor].CGColor;
    bluelayer.frame = CGRectMake(200, 200, 100, 100);
    
    bluelayer.delegate = self;
    
    [self.layerview.layer addSublayer:bluelayer];
    
    [bluelayer display];

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
