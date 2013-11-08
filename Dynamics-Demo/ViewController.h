//
//  ViewController.h
//  Dynamics-Demo
//
//  Created by Thomas Keuleers on 18/09/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *movingView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *gravityButton;
@property (weak, nonatomic) IBOutlet UIButton *attachmentButton;
@property (weak, nonatomic) IBOutlet UIButton *pushButton;
@property (weak, nonatomic) IBOutlet UIButton *collisionButton;

- (IBAction)toggleGravity:(UIButton *)sender;
- (IBAction)toggleAttachment:(UIButton *)sender;
- (IBAction)togglePush:(UIButton *)sender;
- (IBAction)toggleCollision:(UIButton *)sender;
- (IBAction)toggleSnap:(UIButton *)sender;

- (IBAction)reset;
@end
