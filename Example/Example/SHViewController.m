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
  UIButton * button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  [self.view addSubview:button];
  [button SH_addControlEventTouchUpInsideWithBlock:^(UIControl *sender) {
    [self performSegueWithIdentifier:@"second" sender:nil];
  }];
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
