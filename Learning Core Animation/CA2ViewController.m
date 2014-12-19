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
    
    // Applying a mask to an image
    [self imageToBeAppliedAsMask:[UIImage imageNamed:@"Oval1.png"] toImageView:self.imageview];

}

#pragma mark - Apply Mask

- (void) imageToBeAppliedAsMask:(UIImage*)image toImageView:(UIImageView* )imgview
{

    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = imgview.bounds;
    maskLayer.contents = (__bridge id)image.CGImage;
    maskLayer.contentsGravity = kCAGravityCenter;
    imgview.layer.mask = maskLayer;
    
}

@end
