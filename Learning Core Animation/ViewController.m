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
