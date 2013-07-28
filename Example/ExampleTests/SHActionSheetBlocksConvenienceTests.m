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

-(void)testAddFirstButton; {
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:nil
                                                   withBlock:nil];

  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(nil, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);

  
  
}
-(void)testAddFirstButtonWithTitle; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:nil];
  
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  
  
  
}

-(void)testAddFirstButtonWithTitleAndBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:self.block];
  
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  
  
  
}

-(void)testAddFirstButtonWithTitleAndCustomBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:^(NSUInteger theButtonIndex) {
                                                    
                                                  }];
  
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertTrue(self.block != [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  
  
}

-(void)testSetButtonBlockForFirstIndex; {
  NSInteger buttonIndex = 0;
  [self.sheet SH_setButtonBlockForIndex:buttonIndex withBlock:self.block];
  STAssertEquals(0, self.sheet.numberOfButtons, nil);
  
}
-(void)testSetButtonBlockForFirstIndexWithExistingButtonWithTitle; {
  NSInteger buttonIndex = 0;
  [self testAddFirstButtonWithTitle];
  STAssertNil([self.sheet SH_blockForButtonIndex:buttonIndex], nil);

  [self.sheet SH_setButtonBlockForIndex:buttonIndex withBlock:self.block];
  STAssertEquals(1, self.sheet.numberOfButtons, nil);
  STAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertNotNil([self.sheet buttonTitleAtIndex:buttonIndex], nil);
}



-(void)testAddSecondButtonWithTitleAndBlock; {
  [self testAddFirstButtonWithTitleAndCustomBlock];
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:self.block];
  
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);

}

-(void)testAddCancelButton; {
  
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:nil withBlock:nil];
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(nil, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEquals(self.sheet.cancelButtonIndex, buttonIndex, nil);
  
}

-(void)testAddCancelButtonWithTitle; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:buttonTitle withBlock:nil];
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEquals(self.sheet.cancelButtonIndex, buttonIndex, nil);
  
}

-(void)testAddCancelButtonWithTitleAndBlock; {
  NSString * buttonTitle = @"Cancel";
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:buttonTitle withBlock:self.block];
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEquals(self.sheet.cancelButtonIndex, buttonIndex, nil);
  STAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  
}

-(void)testAddCancelButtonWithTitleAndCustomBlock; {
  NSString * buttonTitle = @"Cancel";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:^(NSUInteger theButtonIndex) {
                                                    
                                                  }];
  
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertTrue(self.block != [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  
  
}



@end
