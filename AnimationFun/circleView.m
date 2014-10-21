//
//  circleView.m
//  AnimationFun
//
//  Created by Marian O'Shea on 10/10/2014.
//  Copyright (c) 2014 Marian O'Shea. All rights reserved.
//
/* Animates the drawing of a circle. The circle changes colour halfway through.
 *
 * The animation can be paused and resumed.
 * References:
 * http://www.objc.io/issue-12/animations-explained.html
 * http://ronnqvi.st/controlling-animation-timing/
 */

#import "CircleView.h"

#define seconds 30

@interface CircleView ()
@property (strong, nonatomic) CAShapeLayer *myCircleLayer;

@end

@implementation CircleView {
    
}

-(void) drawCircleAnimated {
    
    if (_myCircleLayer) {
        [_myCircleLayer removeFromSuperlayer] ;
    }
    
    CGPoint start, end, center, startLeft;
    startLeft = CGPointMake(0, self.bounds.size.height/2);
    start = CGPointMake(self.bounds.size.width/2, 0 );
    end = CGPointMake(self.bounds.size.width/2, 0);
    CGRect rect = self.bounds;
    CFTimeInterval duration = (double) seconds;
    UIColor *startColor = [UIColor blueColor];
    UIColor *endColor = [UIColor yellowColor];
    center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    UIBezierPath *myCircle = [UIBezierPath bezierPath];
    [myCircle addArcWithCenter:center radius:CGRectGetWidth(rect)/2 startAngle:3*M_PI_2 endAngle:7*M_PI_2 clockwise:YES];
    self.myCircleLayer = [CAShapeLayer layer];
    _myCircleLayer.frame = self.bounds;
    _myCircleLayer.path = myCircle.CGPath;
    _myCircleLayer.strokeColor = startColor.CGColor;
    _myCircleLayer.fillColor = nil;
    _myCircleLayer.lineWidth = 3.0f;
    
    CABasicAnimation *drawCircleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawCircleAnimation.duration = duration;
    drawCircleAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawCircleAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    drawCircleAnimation.fillMode = kCAFillModeBackwards;
    [self.myCircleLayer addAnimation:drawCircleAnimation forKey:@"strokeEnd"];
    
    CFTimeInterval localLayerTime = [_myCircleLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    CABasicAnimation *changeColorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    changeColorAnimation.beginTime = localLayerTime + duration/2;
    changeColorAnimation.fromValue = (id) startColor.CGColor;
    changeColorAnimation.toValue = (id) endColor.CGColor;
    changeColorAnimation.duration = 2;
    changeColorAnimation.fillMode =  kCAFillModeForwards;
    changeColorAnimation.removedOnCompletion = NO;
    [_myCircleLayer addAnimation:changeColorAnimation forKey:@"strokeColor"];
    
    [self.layer addSublayer:_myCircleLayer];
}

-(void) pauseAnimation {
    [self pauseLayer:_myCircleLayer];
}

-(void) resumeAnimation {
    [self resumeLayer:_myCircleLayer];
}

-(void)pauseLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
