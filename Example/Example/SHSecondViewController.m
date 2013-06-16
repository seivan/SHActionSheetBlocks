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
  
  __weak typeof(self) weakSelf = self;
  [button SH_addControlEventTouchUpInsideWithBlock:^(UIControl *sender) {
    [weakSelf.view addSubview:button2];
    [button removeFromSuperview];
    [button2 SH_addControlEvents:UIControlEventTouchUpInside withBlock:^(UIControl *sender) {
      [button2 removeFromSuperview];
    }];
  }];
  
  [self.view addSubview:button];
}
@end
