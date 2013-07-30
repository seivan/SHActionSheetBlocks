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

#pragma mark - Buttons
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
                                                  withBlock:^(NSInteger theButtonIndex) {
                                                    
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
  STAssertEquals(buttonIndex+1, self.sheet.numberOfButtons, nil);
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

#pragma mark - Buttons Cancel
-(void)testAddCancelButton; {
  
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:nil withBlock:nil];

  STAssertNil([self.sheet SH_blockForCancelButton],nil);
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
  
  STAssertNil([self.sheet SH_blockForCancelButton],nil);
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
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:buttonTitle
                                                  withBlock:^(NSInteger theButtonIndex) {
                                                    
                                                  }];
  
  STAssertNotNil([self.sheet SH_blockForCancelButton],nil);
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertTrue(self.block != [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEquals(self.sheet.cancelButtonIndex, buttonIndex, nil);

  
  
}


-(void)testSetCancelButtonBlockForFirstIndexWithExistingButtonWithTitle; {
  NSInteger buttonIndex = 0;
  [self testAddCancelButtonWithTitle];
  STAssertNil([self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertNil([self.sheet SH_blockForCancelButton],nil);
  
  [self.sheet SH_setButtonBlockForIndex:buttonIndex withBlock:self.block];
  STAssertEquals(buttonIndex+1, self.sheet.numberOfButtons, nil);
  STAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertNotNil([self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertNotNil([self.sheet SH_blockForCancelButton],nil);
}

-(void)testSetCancelButtonDifferentBlock; {
 NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:@"Cancel" withBlock:^(NSInteger theButtonIndex) {
    
  }];
  STAssertFalse(self.block == [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertFalse(self.block == self.sheet.SH_blockForCancelButton, nil);
  
  [self.sheet SH_setButtonCancelBlock:self.block];
  STAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEqualObjects(self.block, self.sheet.SH_blockForCancelButton, nil);

}


-(void)testAddCancelButtonWithTwoNormalButtons; {
  [self testAddSecondButtonWithTitleAndBlock];
  [self testAddCancelButtonWithTitleAndBlock];
}

#pragma mark - Buttons Destructive
-(void)testAddDestructiveButton; {
  
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:nil withBlock:nil];
  STAssertNil([self.sheet SH_blockForDestructiveButton],nil);
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(nil, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEquals(self.sheet.destructiveButtonIndex, buttonIndex, nil);
  
}

-(void)testAddDestructiveButtonWithTitle; {
  NSString * buttonTitle = @"Destructive";
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle withBlock:nil];
  
  STAssertNil([self.sheet SH_blockForDestructiveButton],nil);
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(nil, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEquals(self.sheet.destructiveButtonIndex, buttonIndex, nil);
  
}

-(void)testAddDestructiveButtonWithTitleAndBlock; {
  NSString * buttonTitle = @"Destructive";
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle withBlock:self.block];
  
  STAssertNotNil([self.sheet SH_blockForDestructiveButton],nil);
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEquals(self.sheet.destructiveButtonIndex, buttonIndex, nil);
  STAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  
}

-(void)testAddDestructiveButtonWithTitleAndCustomBlock; {
  NSString * buttonTitle = @"Destructive";
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle
                                                  withBlock:^(NSInteger theButtonIndex) {
                                                    
                                                  }];
  
  STAssertNotNil([self.sheet SH_blockForDestructiveButton],nil);
  STAssertTrue(buttonIndex > self.sheet.firstOtherButtonIndex, nil);
  STAssertEquals(self.sheet.numberOfButtons-1, buttonIndex, nil);
  STAssertEqualObjects(buttonTitle, [self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertTrue(self.block != [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEquals(self.sheet.destructiveButtonIndex, buttonIndex, nil);
  
  
}

-(void)testSetDestructiveButtonBlockForFirstIndexWithExistingButtonWithTitle; {
  NSInteger buttonIndex = 0;
  [self testAddDestructiveButtonWithTitle];
  
  STAssertNil([self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertNil([self.sheet SH_blockForDestructiveButton],nil);
  
  [self.sheet SH_setButtonBlockForIndex:buttonIndex withBlock:self.block];
  STAssertNotNil([self.sheet SH_blockForDestructiveButton], nil);
  STAssertEquals(buttonIndex+1, self.sheet.numberOfButtons, nil);
  STAssertNotNil([self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertNotNil([self.sheet buttonTitleAtIndex:buttonIndex], nil);
  STAssertEquals(self.sheet.destructiveButtonIndex, buttonIndex, nil);

}


-(void)testSetDestructiveButtonDifferentBlock; {
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:@"Destructive" withBlock:^(NSInteger theButtonIndex) {
    
  }];
  STAssertFalse(self.block == [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertFalse(self.block == self.sheet.SH_blockForDestructiveButton, nil);
  
  [self.sheet SH_setButtonDestructiveBlock:self.block];
  STAssertEqualObjects(self.block, [self.sheet SH_blockForButtonIndex:buttonIndex], nil);
  STAssertEqualObjects(self.block, self.sheet.SH_blockForDestructiveButton, nil);

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
