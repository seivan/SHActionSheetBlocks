//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHActionSheetBlocksSuper.h"
@interface SHActionSheetBlocksConvenienceTests : SHActionSheetBlocksSuper
@end


@implementation SHActionSheetBlocksConvenienceTests

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

-(void)testHasDelegate; {
  STAssertNotNil(self.sheet.delegate, nil);
}

-(void)testHasTitle; {
  STAssertNotNil(self.sheet.title, nil);
}

-(void)testHasNoButtons; {
  STAssertEquals(self.sheet.numberOfButtons, 0, nil);
}

-(void)testHasNoCancelButton; {
  STAssertEquals(self.sheet.cancelButtonIndex, -1, nil);
}

-(void)testHasNoOtherFirstButton; {
  STAssertEquals(self.sheet.firstOtherButtonIndex, -1, nil);
}

-(void)testAddFirstButtonWithTitleAndBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                   withBlock:self.block];
  NSLog(@"%d", self.sheet.firstOtherButtonIndex);
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(0, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects([self.sheet SH_blockForButtonIndex:buttonIndex], self.block, nil);
  
  
  
}



@end
