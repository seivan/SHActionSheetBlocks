//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHKeyValueObserverBlocks.h"
#import "SHGestureRecognizerBlocks.h"

@interface SHSecondViewController ()
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  SHGestureRecognizerBlock block = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"CALLBACK block1");
  };
  UITapGestureRecognizer * tapRecognizer = [UITapGestureRecognizer SH_gestureRecognizerWithBlock:block];

  SHGestureRecognizerBlock block2 = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"CALLBACK block2");
  };

  [tapRecognizer SH_addBlock:block];
  [tapRecognizer SH_addBlock:block2];

  [self.view addGestureRecognizer:tapRecognizer];
  
  UITapGestureRecognizer * tapRecognizer2 = [UITapGestureRecognizer SH_gestureRecognizerWithBlock:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"GESTURE 2 CALLBACK 3");
  }];
  [self.view addGestureRecognizer:tapRecognizer2];
//
  NSLog(@"2 gestures, 3 blocks, Gesture 2 block 3 is active");
  NSLog(@"BLOCK COUNTS on first gesture: %d", tapRecognizer.SH_blocks.count);
  double delayInSeconds = 5.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"Removing block1 from gesture1");
    [tapRecognizer SH_removeBlock:block];
    NSLog(@"BLOCK COUNTS on first gesture: %d", tapRecognizer.SH_blocks.count);
    NSLog(@"2 gestures, 2 blocks, Gesture 2 block 3 is active");
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"Removing all blocks from gesture 2");
      [tapRecognizer2 SH_removeAllBlocks];
    NSLog(@"1 gesture, 1 block, Gesture 1 block 2 is active");
    });

  });

}
@end
