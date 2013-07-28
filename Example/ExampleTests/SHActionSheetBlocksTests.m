//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHActionSheetBlocks.h"

#import <SenTestingKit/SenTestingKit.h>

@interface SHActionSheetBlocksTests : SenTestCase

@property(nonatomic,strong) UIViewController    * vc;
@property(nonatomic,strong) UIActionSheet       * sheet;
@property(nonatomic,copy)   SHActionSheetBlock    block;

@end


@implementation SHActionSheetBlocksTests

-(void)setUp; {
  [super setUp];
  
  self.block = ^(NSUInteger theButtonIndex) {
    
  };
  
  self.vc    = UIViewController.new;
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  

}

-(void)tearDown; {
  [super tearDown];
}

-(void)testTitle; {
  STAssertNotNil(self.sheet.title, nil);
}

-(void)testButtons; {
  STAssertEquals(self.sheet.numberOfButtons, 4U, nil);
}


@end
