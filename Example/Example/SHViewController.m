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

@end

@implementation SHViewController

-(void)viewDidLoad; {
  [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  __block NSUInteger counter = 0;
  __block BOOL isFirstCounterCall = YES;
  __weak typeof(self) weakSelf = self;
  SHBarButtonItemBlock counterBlock = ^(UIBarButtonItem * sender){
    counter += 1;
    if(isFirstCounterCall){ SHBlockAssert(counter == 1, @"Counter should be 1"); }
    else { SHBlockAssert(counter == 2, @"Counter should be 2");}
    isFirstCounterCall = NO;
    SHBlockAssert(counter != 3, @"Counter should not be 3")
  };

  UIBarButtonItem * button = [UIBarButtonItem SH_barButtonItemWithTitle:@"Push" style:UIBarButtonItemStyleBordered withBlock:^(UIBarButtonItem *sender) {
    counterBlock(sender);
    
  }];
  

  SHBarButtonItemBlock nextBlock = ^(UIBarButtonItem * sender){
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      
  
      SHBlockAssert(button.SH_blocks.count == 3, @"Should have three blocks");
      [button SH_removeBlock:counterBlock];
      SHBlockAssert(button.SH_blocks.count == 2, @"Should have two blocks");
      [button SH_removeAllBlocks];;
      SHBlockAssert(button.SH_blocks.count == 0, @"Should have no blocks");
      
      [weakSelf performSegueWithIdentifier:@"second" sender:nil];
    });
    
  };

  // Unique blocks
  [button SH_addBlock:counterBlock];
  [button SH_addBlock:counterBlock];
  //Will push segues
  [button SH_addBlock:nextBlock];
  
  SHBlockAssert(button.SH_blocks.count == 3, @"Should have three blocks");
  self.navigationItem.rightBarButtonItem = button;


}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
