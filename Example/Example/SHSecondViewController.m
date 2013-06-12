//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHKeyValueObserverBlocks.h"
#import "SHControlBlocks.h"

@interface SHSecondViewController ()
@property(nonatomic,strong) IBOutlet UIButton * btnFirst;
@property(nonatomic,strong) IBOutlet UIButton * btnSecond;
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.backgroundColor = [UIColor greenColor];
  
  UIButton * button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.backgroundColor = [UIColor redColor];
  
  [button SH_addControlBlockForControlEvents:UIControlEventTouchUpInside withBlock:^(id sender) {
    NSLog(@"TAP TAP BUTTON: %@", button);
  }];
  
  [self.view addSubview:button];
}
@end
