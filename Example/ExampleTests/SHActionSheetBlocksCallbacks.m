//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHActionSheetBlocksSuper.h"
@interface SHActionSheetBlocksCallbacks : SHActionSheetBlocksSuper
@end




@implementation SHActionSheetBlocksCallbacks

-(void)setUp; {
  [super setUp];
  
  
  self.block = ^(NSUInteger theButtonIndex) {
    
  };
  
  self.vc        = UIViewController.new;
  self.sheet     = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  
  
}

-(void)tearDown; {
  [super tearDown];
}

-(void)testSeparateBlocksPerButton; {
  [self.sheet SH_addButtonWithTitle:@"Button1" withBlock:^(NSUInteger theButtonIndex) {

  }];
}


@end
