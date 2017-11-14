//
//  CIWRequestLoadingView.m
//  MuYing
//
//  Created by GarrettGao on 2016/11/26.
//  Copyright © 2016年 HunBoHui. All rights reserved.
//

#import "CIWRequestLoadingView.h"
#import "PureLayout.h"

#define CIWSrcName(file) [@"CIWBundle.bundle" stringByAppendingPathComponent:file]
#define CIWFrameworkSrcName(file) [@"Frameworks/CIWBundle.CIWBundle.bundle" stringByAppendingPathComponent:file]

@interface CIWRequestLoadingView(){
    
}
@property (strong, nonatomic)CALayer *spotLayer;

@end
@implementation CIWRequestLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)startAnimating{
    [self configAnimationAtLayer:self.layer withTintImage:@"loadingTipsNew.png" size:CGSizeMake(60, 60)];
    
}
- (void)configAnimationAtLayer:(CALayer *)layer withTintImage:(NSString *)image size:(CGSize)size{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, size.width, size.height);
    replicatorLayer.position = CGPointMake(size.width/2,size.height/2);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [layer addSublayer:replicatorLayer];
    [self addCyclingSpotAnimationLayerAtLayer:replicatorLayer withTintImage:image size:size];
    
    NSInteger numOfDot = 15;
    replicatorLayer.instanceCount = numOfDot;
    CGFloat angle = (M_PI * 2)/numOfDot;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replicatorLayer.instanceDelay = 1.5/numOfDot;
}


#pragma mark - Cycling indicator animation

- (void)addCyclingSpotAnimationLayerAtLayer:(CALayer *)layer withTintImage:(NSString *)image size:(CGSize)size{
    self.spotLayer = [CALayer layer];
    self.spotLayer.bounds = CGRectMake(0, 0, 4, 11);
    self.spotLayer.position = CGPointMake(size.width/2, 5.5);
    //    self.spotLayer.cornerRadius = self.spotLayer.bounds.size.width/2;
    //    self.spotLayer.backgroundColor = color.CGColor;
    self.spotLayer.transform = CATransform3DMakeScale(1, 1, 1);
    self.spotLayer.opacity = 0.1;
    
    UIImage *image1 = [UIImage imageNamed:CIWSrcName(image)] ?: [UIImage imageNamed:CIWFrameworkSrcName(image)];
    
    self.spotLayer.contents = (__bridge id)(image1.CGImage);
    
    [layer addSublayer:self.spotLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.removedOnCompletion = FALSE;
    animation.fillMode = kCAFillModeForwards;
    
    animation.fromValue = @1;
    animation.toValue = @0.1;
    animation.duration = 1.5;
    animation.repeatCount = CGFLOAT_MAX;
    
    [self.spotLayer addAnimation:animation forKey:@"animation"];
}

-(void)stopAnimating{
    [self.spotLayer removeAnimationForKey:@"animation"];
    self.spotLayer = nil;
}

@end
