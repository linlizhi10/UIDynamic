//
//  ViewController.m
//  UIDynamic
//
//  Created by skunk  on 15/5/26.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, retain) UIDynamicAnimator *animator;

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *collisionSeg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
/**
 *  get method for animator
 *
 *  @return an animator object
 */
- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:touch.view];
    /**
     重力
     */
//    UIGravityBehavior *gBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
//    [gBehavior setGravityDirection:CGVectorMake(0, 1)];
//    gBehavior.magnitude = 10;
    /**
     碰撞
     */
    UICollisionBehavior *cBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.redView,self.collisionSeg]];
    /**
     *  转换为检测碰撞的边界
     */
    cBehavior.translatesReferenceBoundsIntoBoundary = YES;
    /**
     *  添加边界
     */
    [cBehavior addBoundaryWithIdentifier:@"circle" forPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 300, 300)]];
    /**
     捕捉
     */
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.redView snapToPoint:p];
    /**
     *  阻尼
     *
     *  @param arc4random 随机数
     *
     */
    snap.damping = (arc4random()%5 + 1)/5.0;
    NSLog(@"damping is %f",snap.damping);
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:snap];
    [self.animator addBehavior:cBehavior];
    //[self.animator addBehavior:gBehavior];

}
@end
