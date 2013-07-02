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
  SHControlEventBlock counterBlock = ^(UIControl * sender){
    NSLog(@"SENDER : %@", sender);
    counter += 1;
    //This block should only be called two times, even though it's added three times. 
    NSAssert(counter == 1, @"Counter should be one");
    if(counter > 1){
      NSAssert(counter == 2, @"Counter should be two");
    }
  };

  [self.btnFirst SH_addControlEvents:UIControlEventTouchDown withBlock:^(UIControl *sender) {
    [weakSelf.btnFirst removeFromSuperview];

    //When first button is removed - all the controls should be gone.
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      NSSet * controlBlocks = weakSelf.btnFirst.SH_controlBlocks[@(UIControlEventTouchDown)];
      NSAssert(weakSelf.btnFirst.SH_isTouchUpInsideEnabled == NO, @"Touch up inside should not be enabled");
      NSAssert(weakSelf.btnFirst.SH_controlBlocks.count == 0, @"There should be no events");
      NSAssert(controlBlocks.count == 0, @"There should be no blocks");
      
      //Creating new controls for the second button, since the block would be a duplicate, it will only add it once.
      [weakSelf.btnSecond SH_addControlEvents:UIControlEventTouchUpInside withBlock:counterBlock];
      [weakSelf.btnSecond SH_addControlEvents:UIControlEventTouchUpInside withBlock:counterBlock];
      
      //Add the same block here to touchDown
      [weakSelf.btnSecond SH_addControlEvents:UIControlEventTouchDown withBlock:counterBlock];
      
      //Second block
      [weakSelf.btnSecond SH_addControlEvents:UIControlEventTouchDown withBlock:^(UIControl *sender) {
        
      }];
      
      //Ensure second button has the proper controls, two events, one block per event
      NSSet * controlTouchDownBlocks = self.btnFirst.SH_controlBlocks[@(UIControlEventTouchDown)];
      NSSet * controlTouchUpInsideBlocks = self.btnFirst.SH_controlBlocks[@(UIControlEventTouchUpInside)];
      
      NSAssert(weakSelf.btnSecond.SH_isTouchUpInsideEnabled == YES, @"Touch up inside should be enabled");
      NSAssert(weakSelf.btnSecond.SH_controlBlocks.count == 2, @"There should be two events");
      NSAssert(controlTouchDownBlocks.count == 2, @"There should be one block");
      NSAssert(controlTouchUpInsideBlocks.count == 1, @"There should be one block");

    });

  }];
  
  //Ensure first button has the proper controls
  NSSet * controlBlocks = self.btnFirst.SH_controlBlocks[@(UIControlEventTouchDown)];
  NSAssert(self.btnFirst.SH_isTouchUpInsideEnabled == NO, @"Touch up inside should not be enabled");
  NSAssert(self.btnFirst.SH_controlBlocks.count == 1, @"There should be one event");
  NSAssert(controlBlocks.count == 1, @"There should be one block");

}
@end
