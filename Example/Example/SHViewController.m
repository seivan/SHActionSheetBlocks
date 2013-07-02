//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHSegueBlocks.h"
#import "SHViewController.h"
#import "SHBarButtonItemBlocks.h"

@interface SHViewController ()
@property(nonatomic,strong) UIButton * button;

@end

@implementation SHViewController

-(void)viewDidLoad; {
  [super viewDidLoad];
  self.button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  [self.view addSubview:self.button];

}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  __block UIButton * button = self.button;
  __weak typeof(self) weakSelf = self;
  [button SH_addControlEventTouchUpInsideWithBlock:^(UIControl *sender) {
    [weakSelf performSegueWithIdentifier:@"second" sender:nil];
    NSLog(@"first");
  }];
  [button SH_addControlEventTouchUpInsideWithBlock:^(UIControl *sender) {
    NSLog(@"second");
    [button SH_removeControlEventTouchUpInside];
    SHBlockAssert(button.SH_controlBlocks.count == 0, @"There should be no controlblocks");
    SHBlockAssert(button.SH_isTouchUpInsideEnabled == NO, @"Touch up inside should be enabled");
  }];
  
  __block NSUInteger counter = 0;
  SHControlEventBlock block = ^(UIControl * sender){
    NSLog(@"SENDER : %@", sender);
    counter += 1;
    SHBlockAssert(counter == 1, @"Counter should be 1");
  };
  
  [button SH_addControlEventTouchUpInsideWithBlock:block];
  [button SH_addControlEventTouchUpInsideWithBlock:block];

  NSSet * controlBlocks = button.SH_controlBlocks[@(UIControlEventTouchUpInside)];
  
  SHBlockAssert(button.SH_isTouchUpInsideEnabled, @"Touch up inside should be enabled");
  SHBlockAssert(button.SH_controlBlocks.count == 1, @"There should be one event");
  SHBlockAssert(controlBlocks.count == 3, @"There should be three blocks");
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
