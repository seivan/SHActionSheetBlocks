//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHBarButtonItemBlocks.h"


@interface SHSecondViewController ()
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  
  UIBarButtonItem * button = [UIBarButtonItem SH_barButtonItemWithTitle:@"Clear blocks" style:UIBarButtonItemStyleBordered withBlock:^(UIBarButtonItem *sender) {
    [sender SH_removeAllBlocks];
    [sender SH_addBlock:^(UIBarButtonItem *sender) {
      SHBlockAssert(sender.SH_blocks.count == 1, @"Should have one block");
    }];
  }];
  

  SHBlockAssert(button.SH_blocks.count == 1, @"Should have one block");
  self.navigationItem.rightBarButtonItem = button;

}
@end
