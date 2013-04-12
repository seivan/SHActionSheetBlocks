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
@property(nonatomic,strong) IBOutlet UIButton * btnFirst;
@property(nonatomic,strong) IBOutlet UIButton * btnSecond;
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  
  __weak typeof(self) weakSelf = self;
  [self.btnFirst SH_addControlEventTouchUpInsideWithBlock:^(UIControl *sender) {
    NSLog(@"controlblocks : %@", self.btnFirst.SH_controlBlocks);
    NSLog(@"is enabled %d", self.btnFirst.SH_isTouchUpInsideEnabled);
    NSLog(@"blocks %@", [self.btnFirst SH_blocksForControlEvents:UIControlEventTouchUpInside]);
    [weakSelf.btnFirst removeFromSuperview];
  }];
}
@end
