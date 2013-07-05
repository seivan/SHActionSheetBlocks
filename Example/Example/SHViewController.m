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

}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
