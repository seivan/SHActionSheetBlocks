//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHActionSheetBlocks.h"


@interface SHSecondViewController ()
-(void)popUpActionSheet;
-(void)popUpActionSheetAgain;
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  self.view.backgroundColor = [UIColor blackColor];
  [self popUpActionSheet];
}

-(void)popUpActionSheetAgain; {
  UIActionSheet * sheet = [UIActionSheet SH_actionSheetWithTitle:@"New sheet" buttonTitles:@[@"First", @"Second"] cancelTitle:@"Cancel" destructiveTitle:nil withBlock:^(NSInteger theButtonIndex) {
    SHBlockAssert(theButtonIndex >= 0, @"Button Index is more or equal to 0");
  }];
  
  SHBlockAssert(sheet.numberOfButtons == 3 , @"Musth have 4 buttons");
  SHBlockAssert(sheet.SH_blockForCancelButton != nil , @"Cancel has a block");
  SHBlockAssert(sheet.SH_blockForDestructiveButton == nil , @"Destructive  does not have a block");
  [sheet showInView:self.view];
}

-(void)popUpActionSheet; {
  NSString * title = @"Sample";
  
  __weak typeof(self) weakSelf = self;
  
  UIActionSheet * sheet = [UIActionSheet SH_actionSheetWithTitle:title];
  SHBlockAssert(sheet, @"Instance of a sheet");
  SHBlockAssert([sheet.title isEqualToString:title], @"Title should be set");

  SHActionSheetBlock block = ^(NSInteger theButtonIndex) {
    SHBlockAssert(theButtonIndex >= 0, @"Must have a buttonIndex");
    [weakSelf popUpActionSheetAgain];
  };
  
  [sheet addButtonWithTitle:@"Button 0"];
  [sheet addButtonWithTitle:@"Button 1"];
  [sheet addButtonWithTitle:@"Button 2"];
  SHBlockAssert([sheet SH_blockForButtonIndex:0] == nil, @"Button Index 0 has no block");
  SHBlockAssert([sheet SH_blockForButtonIndex:1] == nil, @"Button Index 1 has no block");
  SHBlockAssert([sheet SH_blockForButtonIndex:2] == nil, @"Button Index 1 has no block");

  [sheet SH_setButtonBlockForIndex:0 withBlock:block];
  [sheet SH_setButtonBlockForIndex:1 withBlock:block];
  [sheet SH_setButtonBlockForIndex:2 withBlock:block];
  
  [sheet SH_addButtonWithTitle:@"Block button" withBlock:block];
  
  SHBlockAssert([sheet SH_blockForButtonIndex:2] == block, @"Button Index 4 has a block");
  
  [sheet addButtonWithTitle:@"Cancel"];
  [sheet addButtonWithTitle:@"Destructive"];
  
  sheet.cancelButtonIndex = 4;
  sheet.destructiveButtonIndex = 5;
  [sheet SH_setButtonCancelBlock:block];
  [sheet SH_setButtonDestructiveBlock:block];
  SHBlockAssert([sheet SH_blockForButtonIndex:4] == [sheet SH_blockForCancelButton],
                @"Button Index 5 should be equal to SH_blockForCancel");
  SHBlockAssert([sheet SH_blockForButtonIndex:5] == [sheet SH_blockForDestructiveButton],
                @"Button Index 6 should be equal to SH_blockForDestructive");
  
  SHBlockAssert(block == [sheet SH_blockForCancelButton],
                @"Button Index 5 should be equal to SH_blockForCancel");
  SHBlockAssert(block == [sheet SH_blockForDestructiveButton],
                @"Button Index 6 should be equal to SH_blockForDestructive");

  [sheet addButtonWithTitle:@"Weird button"];
  
  
  [sheet showInView:self.view];
  
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
