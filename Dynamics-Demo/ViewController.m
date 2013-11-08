//
//  ViewController.m
//  Dynamics-Demo
//
//  Created by Thomas Keuleers on 18/09/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.containerView];
    self.movingView.userInteractionEnabled = NO;

    
}

- (IBAction)toggleGravity:(UIButton *)sender {
    [self toggleBehavior:self.gravityBehavior forSender:sender];
}

- (IBAction)toggleAttachment:(UIButton *)sender {
    [self toggleBehavior:self.attachmentBehavior forSender:sender];

}

- (IBAction)togglePush:(UIButton *)sender {
    if (!sender.selected) {
        self.pushBehavior = nil;
    }

    
    [self toggleBehavior:self.pushBehavior forSender:sender];

}

- (IBAction)toggleCollision:(UIButton *)sender {
    
    CGColorRef borderColor;
    
    if (sender.selected) {
        borderColor = [[UIColor clearColor] CGColor];
    } else {
        borderColor = [[UIColor blackColor] CGColor];
    }
    
    self.containerView.layer.borderWidth = 2.0f;
    self.containerView.layer.borderColor = borderColor;
    
    [self toggleBehavior:self.collisionBehavior forSender:sender];

}

- (IBAction)reset {
    
    self.gravityButton.selected = NO;
    self.attachmentButton.selected = NO;
    self.pushButton.selected = NO;
    self.collisionButton.selected = NO;
    
    self.gravityBehavior = nil;
    self.attachmentBehavior = nil;
    self.pushBehavior = nil;
    self.collisionBehavior = nil;
    
    [self.animator removeAllBehaviors];
    self.movingView.center = CGPointMake(CGRectGetMidX(self.containerView.bounds), CGRectGetMidY(self.containerView.bounds));
    [self.animator updateItemUsingCurrentState:self.movingView];
    
    
}

- (IBAction)toggleSnap:(UIButton *)sender {
    [self toggleBehavior:self.snapBehavior forSender:sender];
}

- (void)toggleBehavior:(UIDynamicBehavior *)behavior forSender:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if ([self.animator.behaviors containsObject:behavior]) {
        [self.animator removeBehavior:behavior];
    } else {
        [self.animator addBehavior:behavior];
    }
    
    [self.animator updateItemUsingCurrentState:self.movingView];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouch:[touches anyObject]];

}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouch:[touches anyObject]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouch:[touches anyObject]];
}

- (void)handleTouch:(UITouch *)touch {
    
    if (touch.view == self.containerView || touch.view == self.movingView) {
        
        CGPoint touchedPoint = [touch locationInView:self.containerView];
        
        self.attachmentBehavior.anchorPoint = touchedPoint;
        
        [self.animator updateItemUsingCurrentState:self.movingView];
        
    }
}

- (UIGravityBehavior *)gravityBehavior {
    if (!_gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.movingView]];
        _gravityBehavior.magnitude = 3.0f;
    }

    return _gravityBehavior;
}

- (UIAttachmentBehavior *)attachmentBehavior {
    if (!_attachmentBehavior) {
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.movingView offsetFromCenter:UIOffsetMake(CGRectGetWidth(self.movingView.bounds) / 2, CGRectGetHeight(self.movingView.bounds)/2) attachedToAnchor:self.containerView.center];
        _attachmentBehavior.length = 0.0f;
        _attachmentBehavior.frequency= 0.5f;
        _attachmentBehavior.damping = 0.8f;
    }
    return _attachmentBehavior;
}

- (UIPushBehavior *)pushBehavior {
    if (!_pushBehavior) {
        _pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.movingView] mode:UIPushBehaviorModeInstantaneous];
        _pushBehavior.pushDirection = CGVectorMake(arc4random() % 50, arc4random() % 50);
    }
    return _pushBehavior;
}

- (UICollisionBehavior *)collisionBehavior {
    
    if (!_collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.movingView]];
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    
    return _collisionBehavior;
}

- (UISnapBehavior *)snapBehavior {
    if (!_snapBehavior) {
        
        _snapBehavior = [[UISnapBehavior alloc] initWithItem:self.movingView snapToPoint:
                         CGPointMake(CGRectGetWidth(self.movingView.bounds) / 2, CGRectGetHeight(self.movingView.bounds) / 2)];
        _snapBehavior.damping = 1.0f;
        
    }
    
    return _snapBehavior;
}


@end
