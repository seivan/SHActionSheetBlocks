//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHSegueBlocks.h"
#import "SHViewController.h"
#import "SHActionSheetBlocks.h"
#import "SHBarButtonItemBlocks.h"


@interface SHViewController ()


-(void)popUpActionSheet;
@end

@implementation SHViewController

-(void)viewDidLoad; {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [UIBarButtonItem SH_barButtonItemWithBarButtonSystemItem:UIBarButtonSystemItemPlay withBlock:^(UIBarButtonItem *sender) {
    [self performSegueWithIdentifier:@"second" sender:nil];
  }];

}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  [self popUpActionSheet];
  

}

-(void)popUpActionSheet; {
  NSString * title = @"Sample";
//  UIActionSheet * sheet = [UIActionSheet actionSheetWithTitle:@"LOl"];
//  [sheet addButtonWithTitle:@"TITLE" handler:^{
//    NSLog(@"TITLE");
//    SHBlockAssert(YES, @"SHOULD BE YES");
//  }];
//  [sheet showInView:self.view];
  UIActionSheet * sheet = [UIActionSheet SH_actionSheetWithTitle:title];
  SHBlockAssert(sheet, @"Instance of a sheet");
  SHBlockAssert([sheet.title isEqualToString:title], @"Title should be set");
  
//  __weak typeof(self) weakSelf = self;
  for (NSUInteger i = 0; i != 3; i++) {
    NSString * title = [NSString stringWithFormat:@"Button %d", i];
      [sheet SH_addButtonWithTitle:title withBlock:^(NSUInteger theButtonIndex) {
        NSLog(@"%d, %@", theButtonIndex, [sheet buttonTitleAtIndex:theButtonIndex]);
      }];
    }
  
  [sheet SH_setCancelButtonWithTitle:@"Cancel" withBlock:^(NSUInteger theButtonIndex) {
    NSLog(@"Cancel");
  }];
  [sheet SH_setDestructiveButtonWithTitle:@"Destroy" withBlock:^(NSUInteger theButtonIndex) {
    NSLog(@"Destroy");
  }];
  
  [sheet showInView:self.view];

}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
