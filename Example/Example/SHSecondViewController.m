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
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  [self popUpActionSheet];
}

-(void)popUpActionSheet; {
  NSString * title = @"Sample";
  
  UIActionSheet * sheet = [UIActionSheet SH_actionSheetWithTitle:title];
  SHBlockAssert(sheet, @"Instance of a sheet");
  SHBlockAssert([sheet.title isEqualToString:title], @"Title should be set");
  
  
  for (NSUInteger i = 0; i != 3; i++) {
    NSString * title = [NSString stringWithFormat:@"Button %d", i];
    [sheet SH_addButtonWithTitle:title withBlock:^(NSUInteger theButtonIndex) {
      NSString * buttonTitle = [sheet buttonTitleAtIndex:theButtonIndex];
      SHBlockAssert([title isEqualToString:buttonTitle], @"Button title is set");
    }];
  }
  
  NSUInteger cancelIndex      = 3;
  NSUInteger destructiveIndex = 4;
  
  [sheet SH_setCancelButtonWithTitle:@"Cancel" withBlock:^(NSUInteger theButtonIndex) {
    NSLog(@"Cancel");
    SHBlockAssert(theButtonIndex == cancelIndex ,
                  @"Cancel button index is 3");
  }];
  
  SHBlockAssert(sheet.cancelButtonIndex == cancelIndex ,
                @"Cancel button index is 3");
  
  [sheet SH_setDestructiveButtonWithTitle:@"Destroy" withBlock:^(NSUInteger theButtonIndex) {
    NSLog(@"Destroy");
    SHBlockAssert(theButtonIndex == destructiveIndex ,
                  @"Destructive button index is 4");
  }];
  
  SHBlockAssert(sheet.destructiveButtonIndex == destructiveIndex ,
                @"Destructive button index 4");
  
  

  [sheet showInView:self.view];
  
}
@end
