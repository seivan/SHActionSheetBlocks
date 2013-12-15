//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHActionSheetBlocksSuper.h"
@interface SHActionSheetBlocksOldTests : SHActionSheetBlocksSuper
@end


@implementation SHActionSheetBlocksOldTests

-(void)setUp; {
  [super setUp];
  
  
  self.block = ^(NSInteger theButtonIndex) {};
  
  self.sheet     = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  

}

-(void)tearDown; {
  self.block = nil;
  self.sheet = nil;
  [super tearDown];
}

-(void)testHasDelegate; {
  XCTAssertNotNil(self.sheet.delegate);
}

-(void)testHasTitle; {
  XCTAssertNotNil(self.sheet.title);
}

-(void)testHasNoButtons; {
  XCTAssertEqual(self.sheet.numberOfButtons, 0);
}

-(void)testHasNoCancelButton; {
  XCTAssertEqual(self.sheet.cancelButtonIndex, -1);
}

-(void)testHasNoOtherFirstButton; {
  XCTAssertEqual(self.sheet.firstOtherButtonIndex, -1);
}

#pragma mark - Buttons
-(void)testAddFirstButton; {
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:nil
                                                   withBlock:nil];

  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(nil, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);

  
  
}
-(void)testAddFirstButtonWithTitle; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:nil];
  
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  
  
  
}

-(void)testAddFirstButtonWithTitleAndBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:self.block];
  
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  
  
  
}

-(void)testAddFirstButtonWithTitleAndCustomBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:^(NSInteger theButtonIndex) {
                                                    
                                                  }];
  
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertTrue(self.block != [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  
  
}

-(void)testSetButtonBlockForFirstIndex; {
  NSInteger buttonIndex = 0;
  [self.sheet SH_setButtonBlockForIndex:buttonIndex withBlock:self.block];
  XCTAssertEqual(0, self.sheet.numberOfButtons);
  
}
-(void)testSetButtonBlockForFirstIndexWithExistingButtonWithTitle; {
  NSInteger buttonIndex = 0;
  [self testAddFirstButtonWithTitle];
  XCTAssertNil([self.sheet SH_blockForButtonIndex:buttonIndex]);

  [self.sheet SH_setButtonBlockForIndex:buttonIndex withBlock:self.block];
  XCTAssertEqual(buttonIndex+1, self.sheet.numberOfButtons);
  XCTAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertNotNil([self.sheet buttonTitleAtIndex:buttonIndex]);
}



-(void)testAddSecondButtonWithTitleAndBlock; {
  [self testAddFirstButtonWithTitleAndCustomBlock];
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle
                                                  withBlock:self.block];
  
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);

}

#pragma mark - Buttons Cancel
-(void)testAddCancelButton; {
  
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:nil withBlock:nil];

  XCTAssertNil([self.sheet SH_blockForCancelButton]);
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(nil, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqual(self.sheet.cancelButtonIndex, buttonIndex);
  
}

-(void)testAddCancelButtonWithTitle; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:buttonTitle withBlock:nil];
  
  XCTAssertNil([self.sheet SH_blockForCancelButton]);
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqual(self.sheet.cancelButtonIndex, buttonIndex);
  
}

-(void)testAddCancelButtonWithTitleAndBlock; {
  NSString * buttonTitle = @"Cancel";
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:buttonTitle withBlock:self.block];
  
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqual(self.sheet.cancelButtonIndex, buttonIndex);
  XCTAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex]);
  
}

-(void)testAddCancelButtonWithTitleAndCustomBlock; {
  NSString * buttonTitle = @"Cancel";
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:buttonTitle
                                                  withBlock:^(NSInteger theButtonIndex) {
                                                    
                                                  }];
  
  XCTAssertNotNil([self.sheet SH_blockForCancelButton]);
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertTrue(self.block != [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqual(self.sheet.cancelButtonIndex, buttonIndex);

  
  
}


-(void)testSetCancelButtonBlockForFirstIndexWithExistingButtonWithTitle; {
  NSInteger buttonIndex = 0;
  [self testAddCancelButtonWithTitle];
  XCTAssertNil([self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertNil([self.sheet SH_blockForCancelButton]);
  
  [self.sheet SH_setButtonBlockForIndex:buttonIndex withBlock:self.block];
  XCTAssertEqual(buttonIndex+1, self.sheet.numberOfButtons);
  XCTAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertNotNil([self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertNotNil([self.sheet SH_blockForCancelButton]);
}

-(void)testSetCancelButtonDifferentBlock; {
 NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:@"Cancel" withBlock:^(NSInteger theButtonIndex) {
    
  }];
  XCTAssertFalse(self.block == [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertFalse(self.block == self.sheet.SH_blockForCancelButton);
  
  [self.sheet SH_setButtonCancelBlock:self.block];
  XCTAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqualObjects(self.block, self.sheet.SH_blockForCancelButton);

}


-(void)testAddCancelButtonWithTwoNormalButtons; {
  [self testAddSecondButtonWithTitleAndBlock];
  [self testAddCancelButtonWithTitleAndBlock];
}

#pragma mark - Buttons Destructive
-(void)testAddDestructiveButton; {
  
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:nil withBlock:nil];
  XCTAssertNil([self.sheet SH_blockForDestructiveButton]);
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(nil, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqual(self.sheet.destructiveButtonIndex, buttonIndex);
  
}

-(void)testAddDestructiveButtonWithTitle; {
  NSString * buttonTitle = @"Destructive";
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle withBlock:nil];
  
  XCTAssertNil([self.sheet SH_blockForDestructiveButton]);
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqual(self.sheet.destructiveButtonIndex, buttonIndex);
  
}

-(void)testAddDestructiveButtonWithTitleAndBlock; {
  NSString * buttonTitle = @"Destructive";
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle withBlock:self.block];
  
  XCTAssertNotNil([self.sheet SH_blockForDestructiveButton]);
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqual(self.sheet.destructiveButtonIndex, buttonIndex);
  XCTAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex]);
  
}

-(void)testAddDestructiveButtonWithTitleAndCustomBlock; {
  NSString * buttonTitle = @"Destructive";
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle
                                                  withBlock:^(NSInteger theButtonIndex) {
                                                    
                                                  }];
  
  XCTAssertNotNil([self.sheet SH_blockForDestructiveButton]);
  XCTAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex);
  XCTAssertEqual(self.sheet.numberOfButtons-1, buttonIndex);
  XCTAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertTrue(self.block != [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqual(self.sheet.destructiveButtonIndex, buttonIndex);
  
  
}

-(void)testSetDestructiveButtonBlockForFirstIndexWithExistingButtonWithTitle; {
  NSInteger buttonIndex = 0;
  [self testAddDestructiveButtonWithTitle];
  
  XCTAssertNil([self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertNil([self.sheet SH_blockForDestructiveButton]);
  
  [self.sheet SH_setButtonBlockForIndex:buttonIndex withBlock:self.block];
  XCTAssertNotNil([self.sheet SH_blockForDestructiveButton]);
  XCTAssertEqual(buttonIndex+1, self.sheet.numberOfButtons);
  XCTAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertNotNil([self.sheet buttonTitleAtIndex:buttonIndex]);
  XCTAssertEqual(self.sheet.destructiveButtonIndex, buttonIndex);

}


-(void)testSetDestructiveButtonDifferentBlock; {
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:@"Destructive" withBlock:^(NSInteger theButtonIndex) {
    
  }];
  XCTAssertFalse(self.block == [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertFalse(self.block == self.sheet.SH_blockForDestructiveButton);
  
  [self.sheet SH_setButtonDestructiveBlock:self.block];
  XCTAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex]);
  XCTAssertEqualObjects(self.block, self.sheet.SH_blockForDestructiveButton);

}


-(void)testAddDestructiveButtonWithTwoNormalButtons; {
  [self testAddSecondButtonWithTitleAndBlock];
  [self testAddDestructiveButtonWithTitleAndBlock];
}

-(void)testAllButtons; {
  [self testAddCancelButtonWithTwoNormalButtons];
  [self testAddDestructiveButtonWithTwoNormalButtons];
}





@end
