//
//  MLViewController.m
//  DisplayLinker
//
//  Created by Matt Long on 12/16/13.
//  Copyright (c) 2013 Matt Long. All rights reserved.
//

#import "MLViewController.h"

@interface MLViewController ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, weak) IBOutlet UILabel *currentValueLabel;

@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createShapeLayer];
    [self startAnimation];

    _displayLink = [CADisplayLink
                    displayLinkWithTarget:self
                    selector:
                    @selector(
                              displayLinkDidUpdate:)];
    
    [_displayLink
     addToRunLoop:[NSRunLoop mainRunLoop]
     forMode:NSDefaultRunLoopMode];
}

- (void)createShapeLayer
{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.position = CGPointMake(150.0f, 150.0f);
    _shapeLayer.bounds = CGRectMake(0.0f, 0.0f, 200.0f, 200.0f);
    _shapeLayer.lineWidth = 10.0f;
    _shapeLayer.strokeColor = [[UIColor redColor] CGColor];
    _shapeLayer.fillColor = [[UIColor orangeColor] CGColor];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:_shapeLayer.bounds];
    
    _shapeLayer.path = [circlePath CGPath];
    
    [self.view.layer addSublayer:_shapeLayer];
    
}

- (void)startAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0f);
    animation.toValue = @(1.0f);
    animation.duration = 20.0f;
    
    [_shapeLayer addAnimation:animation forKey:@"strokeEnd"];
}

- (void)displayLinkDidUpdate:(CADisplayLink *)sender
{
    CAShapeLayer *presentationLayer = (CAShapeLayer*)[_shapeLayer presentationLayer];
    if ([[presentationLayer valueForKey:@"strokeEnd"] floatValue] < 1) {
        _currentValueLabel.text = [NSString stringWithFormat:@"Stroke End is now: %@", [presentationLayer valueForKey:@"strokeEnd"]];
    } else {
        // Kill the display link
        [_displayLink invalidate];
    }
    
}

@end
