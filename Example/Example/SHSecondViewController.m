//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHControlBlocks.h"

@interface SHSecondViewController ()
@property(nonatomic,weak) IBOutlet UIButton * btnFirst;
@property(nonatomic,weak) IBOutlet UIButton * btnSecond;
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  
  __weak typeof(self) weakSelf = self;

  __block NSUInteger counter = 0;
  SHControlEventBlock block = ^(UIControl * sender){
    NSLog(@"SENDER : %@", sender);
    counter += 1;
    NSAssert(counter == 1, @"Counter should be one");
    if(counter > 1){
      NSAssert(counter == 2, @"Counter should be two");
    }
  };

  [self.btnFirst SH_addControlEvents:UIControlEventTouchDown withBlock:^(UIControl *sender) {
    [weakSelf.btnFirst removeFromSuperview];
    NSSet * controlBlocks = self.btnFirst.SH_controlBlocks[@(UIControlEventTouchDown)];
    NSAssert(weakSelf.btnFirst.SH_isTouchUpInsideEnabled == NO, @"Touch up inside should be enabled");
    NSAssert(weakSelf.btnFirst.SH_controlBlocks.count == 1, @"There should be no events");
    NSAssert(controlBlocks.count == 0, @"There should be no blocks");
    [weakSelf.btnSecond SH_addControlEvents:UIControlEventTouchUpInside withBlock:block];
    [weakSelf.btnSecond SH_addControlEvents:UIControlEventTouchDown withBlock:block];
    [weakSelf.btnSecond SH_addControlEvents:UIControlEventTouchDown withBlock:^(UIControl *sender) {
      
    }];
    NSSet * controlTouchDownBlocks = self.btnFirst.SH_controlBlocks[@(UIControlEventTouchDown)];
    NSSet * controlTouchUpInsideBlocks = self.btnFirst.SH_controlBlocks[@(UIControlEventTouchUpInside)];
    NSAssert(weakSelf.btnFirst.SH_isTouchUpInsideEnabled == YES, @"Touch up inside should be enabled");
    NSAssert(weakSelf.btnFirst.SH_controlBlocks.count == 2, @"There should be two events");
    NSAssert(controlTouchDownBlocks.count == 0, @"There should be no blocks");
    NSAssert(controlTouchUpInsideBlocks.count == 0, @"There should be no blocks");

  }];

  NSSet * controlBlocks = self.btnFirst.SH_controlBlocks[@(UIControlEventTouchDown)];
  NSAssert(self.btnFirst.SH_isTouchUpInsideEnabled == NO, @"Touch up inside should be enabled");
  NSAssert(self.btnFirst.SH_controlBlocks.count == 1, @"There should be one event");
  NSAssert(controlBlocks.count == 1, @"There should be one block");

}
@end
