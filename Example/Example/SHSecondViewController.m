//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHActionSheetBlocks.h"
#import <PXEngine/PXEngine.h>

@interface SHSecondViewController ()
-(void)popUpActionSheet;
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  self.view.backgroundColor = [UIColor blackColor];
  self.view.styleId = @"styled";
  [self popUpActionSheet];
}

-(void)popUpActionSheet; {
  __weak typeof(self) weakSelf = self;
  NSString * title = @"Sample";
  __block NSUInteger selectedIndex = 0;
  UIActionSheet * sheet = [UIActionSheet SH_actionSheetWithTitle:title];
  SHBlockAssert(sheet, @"Instance of a sheet");
  SHBlockAssert([sheet.title isEqualToString:title], @"Title should be set");
  
  
  for (NSUInteger i = 0; i != 3; i++) {
    NSString * title = [NSString stringWithFormat:@"Button %d", i];
    [sheet SH_addButtonWithTitle:title withBlock:^(NSUInteger theButtonIndex) {
      NSString * buttonTitle = [sheet buttonTitleAtIndex:theButtonIndex];
      SHBlockAssert([title isEqualToString:buttonTitle], @"Button title is set");
      selectedIndex = theButtonIndex;
      double delayInSeconds = 0.2;
      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf popUpActionSheet];
      });

    }];
  }
  
  
  NSUInteger cancelIndex      = 3;

  
  [sheet SH_setCancelButtonWithTitle:@"Cancel" withBlock:^(NSUInteger theButtonIndex) {
    NSLog(@"Cancel");
    SHBlockAssert(theButtonIndex == cancelIndex ,
                  @"Cancel button index is 3");
    selectedIndex = theButtonIndex;
    
  }];
  
  SHBlockAssert(sheet.cancelButtonIndex == cancelIndex ,
                @"Cancel button index is 3");
  
  
  SHBlockAssert(sheet.SH_blockWillShow == nil, @"No SH_blockWillShow block");
  SHBlockAssert(sheet.SH_blockDidShow == nil, @"No SH_blockDidShow block");
  SHBlockAssert(sheet.SH_blockWillDismiss == nil, @"No SH_blockWillDismiss block");
  SHBlockAssert(sheet.SH_blockDidDismiss == nil, @"No SH_blockDidDismiss block");
  
  [sheet SH_setWillShowBlock:^(UIActionSheet *theActionSheet) {
    SHBlockAssert(theActionSheet, @"Must pass the actionSheet for willShow");
  }];

  [sheet SH_setDidShowBlock:^(UIActionSheet *theActionSheet) {
    SHBlockAssert(theActionSheet, @"Must pass the actionSheet for didShow");
  }];
  
  [sheet SH_setWillDismissBlock:^(UIActionSheet *theActionSheet, NSUInteger theButtonIndex) {
    SHBlockAssert(theActionSheet, @"Must pass the actionSheet");
    SHBlockAssert(selectedIndex == theButtonIndex, @"Must pass selected index for willDismiss");
  }];

  [sheet SH_setDidDismissBlock:^(UIActionSheet *theActionSheet, NSUInteger theButtonIndex) {
    SHBlockAssert(theActionSheet, @"Must pass the actionSheet");
    SHBlockAssert(selectedIndex == theButtonIndex, @"Must pass selected index fordidDismiss");
  }];

  

  SHBlockAssert(sheet.SH_blockWillShow, @"Must set SH_blockWillShow block");
  SHBlockAssert(sheet.SH_blockDidShow, @"Must set SH_blockDidShow block");
  SHBlockAssert(sheet.SH_blockWillDismiss, @"Must set SH_blockWillDismiss block");
  SHBlockAssert(sheet.SH_blockDidDismiss, @"Must set SH_blockDidDismiss block");


  [sheet showInView:self.view];
  
}
@end
