//
//  VBViewController.m
//  SuperPan
//
//  Created by Vitaliy Berg on 6/1/13.
//  Copyright (c) 2013 Vitaliy Berg. All rights reserved.
//

#import "VBViewController.h"

@interface VBViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation VBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didPanWith:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:self.greenView];
        
        // Move
        CGPoint center = self.greenView.center;
        center.x += translation.x;
        center.y += translation.y;
        self.greenView.center = center;
        
        // Restrict
        translation = CGPointZero;
        
        CGRect frame = self.greenView.frame;
        if (frame.origin.x < 0) {
            translation.x = frame.origin.x;
            frame.origin.x = 0;
        }
        if (frame.origin.y < 0) {
            translation.y = frame.origin.y;
            frame.origin.y = 0;
        }
        if (frame.origin.x + frame.size.width > self.redView.frame.size.width) {
            translation.x = (frame.origin.x + frame.size.width) - self.redView.frame.size.width;
            frame.origin.x = self.redView.frame.size.width - frame.size.width;
        }
        if (frame.origin.y + frame.size.height > self.redView.frame.size.height) {
            translation.y = (frame.origin.y + frame.size.height) - self.redView.frame.size.height;
            frame.origin.y = self.redView.frame.size.height - frame.size.height;
        }
        self.greenView.frame = frame;
        
        [sender setTranslation:translation inView:self.greenView];
    }
}

@end
