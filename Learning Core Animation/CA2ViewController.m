//
//  CA2ViewController.m
//  Learning Core Animation
//
//  Created by Saurabh Jain on 12/18/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "CA2ViewController.h"

@interface CA2ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation CA2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageview.hidden = YES;
    
    // Adding Perspective to the conatinerview adds it to all the subviews
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0; // Change m34 to add perspective
    
    self.view.layer.sublayerTransform = perspective;
    
    UIImageView* view1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    UIImageView* view2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];

    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    view1.image = [UIImage imageNamed:@"Oval1.png"];
    view2.image = [UIImage imageNamed:@"Oval1.png"];
    
    view1.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    view2.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);

}

#pragma mark - Apply Mask

- (void) imageToBeAppliedAsMask:(UIImage*)image toImageView:(UIImageView* )imgview
{
    imgview.hidden = NO;
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = imgview.bounds;
    maskLayer.contents = (__bridge id)image.CGImage;
    maskLayer.contentsGravity = kCAGravityCenter;
    imgview.layer.mask = maskLayer;
    
}


#pragma mark - Slant image

CGAffineTransform CGAffineTransformMakeShear( CGFloat x, CGFloat y)
{

    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}


#pragma mark - CGAffineTransformation

- (void) learningTransformation
{
    self.imageview.hidden = NO;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform = CGAffineTransformScale(transform, 0.5,0.5);
    
    transform = CGAffineTransformRotate(transform, -M_PI_2);
    
    // After rotating by -90 degress, moving the layer in the x-direction causes it to move upward.
    // If we rotate it by +90 degress, then moving the layer in the x-direction causes it to move downward.
    transform = CGAffineTransformTranslate(transform, 200, 0);
    
    self.imageview.layer.affineTransform = transform;
}

#pragma mark - IBActions

- (IBAction)transform:(UIButton *)sender
{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self learningTransformation];
        
    } completion:^(BOOL finished) {
        // Do something after the animation completes
        //NSLog(@"Animation Completed");
    }];
    
}

- (IBAction)applyMask:(id)sender
{
    [self imageToBeAppliedAsMask:[UIImage imageNamed:@"Oval1.png"] toImageView:self.imageview];
    
}

- (IBAction)slantImage:(id)sender
{
        self.imageview.hidden = NO;
    self.imageview.layer.affineTransform = CGAffineTransformMakeShear(1, 0);
}

@end
