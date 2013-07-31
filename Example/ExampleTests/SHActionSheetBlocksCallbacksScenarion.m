//
//  SHActionSheetBlocksCallbacksScenarion.m
//  Example
//
//  Created by Seivan Heidari on 7/31/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "KIF.h"
#import "SHActionSheetBlocksSuper.h"

@interface SHActionSheetBlocksCallbacksScenarion : KIFTestCase
@property(nonatomic,strong) UIViewController    * vc;
@property(nonatomic,strong) UIActionSheet       * sheet;
@property(nonatomic,copy)   SHActionSheetBlock  block;

@end

@implementation SHActionSheetBlocksCallbacksScenarion
-(void)beforeEach; {
  self.block = ^(NSInteger theButtonIndex) {};
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  self.vc = UIViewController.new;
  [UIApplication sharedApplication].keyWindow.rootViewController = self.vc;
  
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  
  [self.sheet SH_addButtonWithTitle:@"Button1" withBlock:^(NSInteger theButtonIndex) {
    
  }];
  
  [self.sheet showInView:self.vc.view];
}

-(void)afterEach; {

}

-(void)testSuccessfulLogin; {
  
  [tester tapViewWithAccessibilityLabel:@"Button1"];
  
  
}

@end
