//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHSegueBlocks.h"
#import "SHViewController.h"
#import "SHControlBlocks.h"
@interface SHViewController ()


@end

@implementation SHViewController

-(void)viewDidLoad;{
  [super viewDidLoad];
  __block UIButton * button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  [self.view addSubview:button];

  [button SH_addControlEventTouchUpInsideWithBlock:^(UIControl *sender) {
    [self performSegueWithIdentifier:@"second" sender:nil];
    NSLog(@"first");
  }];
  [button SH_addControlEventTouchUpInsideWithBlock:^(UIControl *sender) {
    NSLog(@"second");
  }];
  
  SHControlEventBlock block = ^(UIControl * sender){
    NSLog(@"SENDER : %@", sender);
  };
  
  [button SH_addControlEventTouchUpInsideWithBlock:block];
  [button SH_addControlEventTouchUpInsideWithBlock:block];
  [button SH_addControlEventTouchUpInsideWithBlock:block];
  [button SH_removeControlEventsForBlock:block];
  [button SH_removeBlocksForControlEvents:UIControlEventTouchUpInside];
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  
}
-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
