//
//  AnimationViewController.m
//  Easy-All 2.0
//
//  Created by Posen on 2018/7/10.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
//    [self CABasicAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)CABasicAnimation
{
    UIView *demoView = [[UIView alloc]init];
    demoView.frame = CGRectMake(100, 100, 100, 100);
    demoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:demoView];
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
//    anima.byValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    anima.duration = 3.0f;
    anima.beginTime = CACurrentMediaTime() + 1;
//    anima.timeOffset = 2;
    
    [demoView.layer addAnimation:anima forKey:@"positionAnimation"];
    

    
    
    UIView *demoView2 = [[UIView alloc]init];
    demoView2.frame = CGRectMake(0, 0, 25, 25);
    demoView2.backgroundColor = [UIColor redColor];
    [demoView addSubview:demoView2];
    
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima2.toValue = [NSValue valueWithCGPoint:CGPointMake(87.5, 87.5)];
    anima2.duration = 3.0f;
    anima2.beginTime =   1;
//    anima2.timeOffset = 2;
    [demoView2.layer addAnimation:anima2 forKey:@"positionAnimation2"];
}

- (void)CAKeyframeAnimation
{
    UIView *demoView = [[UIView alloc]init];
    
    demoView.frame = CGRectMake(100, 100, 50, 50);
    demoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:demoView];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(300, 300)],[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(0, 200)]];
    animation.duration = 10;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.beginTime = CACurrentMediaTime() + 1;
    animation.keyTimes = @[@0,@0.25,@0.5,@0.75,@1];
    animation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)].CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    [demoView.layer addAnimation:animation forKey:@"keyframe"];
}

@end
