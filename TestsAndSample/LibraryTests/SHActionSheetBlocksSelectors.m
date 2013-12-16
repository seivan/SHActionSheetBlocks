//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHActionSheetBlocksSuper.h"
@interface SHActionSheetBlocksSelectors : SHActionSheetBlocksSuper
@end



@implementation SHActionSheetBlocksSelectors

-(void)setUp; {
  [super setUp];
  
  
  self.block = ^(NSInteger theButtonIndex) {};
  

  self.sheet     = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
    
}

-(void)tearDown; {
  [super tearDown];
}

-(void)testHasDelegate; {
  XCTAssertNotNil(self.sheet.delegate, @"asd");
  
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

-(void)testHasNoDestructiveButton; {
  XCTAssertEqual(self.sheet.destructiveButtonIndex, -1);
}


-(void)testHasNoOtherFirstButton; {
  XCTAssertEqual(self.sheet.firstOtherButtonIndex, -1);
}


-(void)testSH_actionSheetWithTitle; {
  XCTAssertEqualObjects(self.sheet.class  , UIActionSheet.class);
}

-(void)testSH_actionSheetWithTitle_buttonTitles_cancelTitle_destructiveTitle_withBlock; {
  self.sheet = nil;
  NSString * cancelButtonTitle      = @"Cancel";
  NSString * destructiveButtonTitle = @"Destructive";
  
  NSArray * buttons = @[@"Button1", @"Button2", cancelButtonTitle, destructiveButtonTitle];
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title" buttonTitles:@[@"Button1", @"Button2"] cancelTitle:cancelButtonTitle destructiveTitle:destructiveButtonTitle withBlock:self.block];
  
  NSInteger buttonCount = buttons.count;
  XCTAssertEqualObjects(self.sheet.class  , UIActionSheet.class);
  XCTAssertNotNil(self.sheet.title);
  XCTAssertNotNil(self.block);
  XCTAssertEqual(self.sheet.numberOfButtons, buttonCount);
  XCTAssertNotNil(self.block);
  XCTAssertEqualObjects(self.sheet.SH_blockForCancelButton, self.block);
  XCTAssertEqualObjects(self.sheet.SH_blockForDestructiveButton , self.block);
  
  XCTAssertEqualObjects(self.block, [self.sheet SH_blockForDestructiveButton]);
  XCTAssertEqualObjects(self.block, [self.sheet SH_blockForCancelButton]);
  
}

-(void)testSH_addButtonWithTitle_withBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle withBlock:self.block];
  
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqualObjects([self.sheet buttonTitleAtIndex:buttonIndex], buttonTitle);
}

-(void)testSH_addButtonDestructiveWithTitle_withBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle withBlock:self.block];
  
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqualObjects([self.sheet buttonTitleAtIndex:buttonIndex], buttonTitle);
  XCTAssertEqual(self.sheet.destructiveButtonIndex, buttonIndex);
}

-(void)testSH_addButtonCancelWithTitle_withBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:buttonTitle withBlock:self.block];
  
  XCTAssertEqual(self.sheet.numberOfButtons, buttonIndex+1);
  XCTAssertEqualObjects([self.sheet buttonTitleAtIndex:buttonIndex], buttonTitle);
  XCTAssertEqual(self.sheet.cancelButtonIndex, buttonIndex);
}


-(void)testSH_setButtonBlockForIndex_withBlock; {
  [self.sheet SH_setButtonBlockForIndex:0 withBlock:self.block];
  NSInteger zeroButtons = 0;
  XCTAssertEqual(self.sheet.numberOfButtons, zeroButtons);
  XCTAssertEqual([self.sheet SH_blockForButtonIndex:0], self.block);
  
  [self testSH_addButtonWithTitle_withBlock];
  
  SHActionSheetBlock block = ^(NSInteger theButtonIndex) {
    
  };

  [self.sheet SH_setButtonBlockForIndex:0 withBlock:block];
  XCTAssertEqual(self.sheet.numberOfButtons, 1);
  XCTAssertEqualObjects([self.sheet SH_blockForButtonIndex:0], block);
  
}

-(void)testSH_setButtonDestructiveBlock; {
  [self.sheet SH_setButtonDestructiveBlock:self.block];
  XCTAssertEqualObjects(self.sheet.SH_blockForDestructiveButton, nil);
  
  [self testSH_addButtonDestructiveWithTitle_withBlock];
  XCTAssertEqualObjects(self.sheet.SH_blockForDestructiveButton, self.block);

  SHActionSheetBlock block = ^(NSInteger theButtonIndex) {
    
  };

  
  [self.sheet SH_setButtonDestructiveBlock:block];
  XCTAssertEqual(self.sheet.numberOfButtons, 1);
  XCTAssertEqualObjects(self.sheet.SH_blockForDestructiveButton, block);
  
}


-(void)testSH_setButtonCancelBlock; {
  [self.sheet SH_setButtonCancelBlock:self.block];
  XCTAssertEqualObjects(self.sheet.SH_blockForCancelButton, nil);
  
  [self testSH_addButtonCancelWithTitle_withBlock];
  XCTAssertEqualObjects(self.sheet.SH_blockForCancelButton, self.block);
  
  SHActionSheetBlock block = ^(NSInteger theButtonIndex) {
    
  };
  
  [self.sheet SH_setButtonCancelBlock:block];
  XCTAssertEqual(self.sheet.numberOfButtons, 1);
  XCTAssertEqualObjects(self.sheet.SH_blockForCancelButton, block);
  
}

-(void)testSH_setWillShowBlock; {
  XCTAssertNil(self.sheet.SH_blockWillShow);
  SHActionSheetShowBlock block = ^(UIActionSheet *theActionSheet) {
    
  };

  [self.sheet SH_setWillShowBlock:block];
  XCTAssertEqualObjects(self.sheet.SH_blockWillShow, block);
}

-(void)testSH_setDidShowBlock; {
  XCTAssertNil(self.sheet.SH_blockDidShow);
  SHActionSheetShowBlock block = ^(UIActionSheet *theActionSheet) {
    
  };
  
  [self.sheet SH_setDidShowBlock:block];
  XCTAssertEqualObjects(self.sheet.SH_blockDidShow, block);
}

-(void)testSH_setWillDismisBlock; {
  XCTAssertNil(self.sheet.SH_blockWillDismiss);
  SHActionSheetDismissBlock block = ^(UIActionSheet *theActionSheet, NSInteger theButtonIndex) {
    
  };
  
  [self.sheet SH_setWillDismissBlock:block];
  XCTAssertEqualObjects(self.sheet.SH_blockWillDismiss, block);
}

-(void)testSH_setDidDismisBlock; {
  XCTAssertNil(self.sheet.SH_blockDidDismiss);
  SHActionSheetDismissBlock block = ^(UIActionSheet *theActionSheet, NSInteger theButtonIndex) {
    
  };
  
  [self.sheet SH_setDidDismissBlock:block];
  XCTAssertEqualObjects(self.sheet.SH_blockDidDismiss, block);
}

-(void)testSH_blockForButtonIndex; {
  [self testSH_setButtonBlockForIndex_withBlock];
  XCTAssertNotNil([self.sheet SH_blockForButtonIndex:0]);
}

-(void)testSH_blockForDestructiveButton; {
  [self testSH_setButtonDestructiveBlock];
  XCTAssertNotNil(self.sheet.SH_blockForDestructiveButton);
}

-(void)testSH_blockForCancelButton; {
  [self testSH_setButtonCancelBlock];
  XCTAssertNotNil(self.sheet.SH_blockForCancelButton);
}

-(void)testSH_blockWillShow; {
  [self testSH_setWillShowBlock];
  XCTAssertNotNil(self.sheet.SH_blockWillShow);
}

-(void)testSH_blockDidShow; {
  [self testSH_setDidShowBlock];
  XCTAssertNotNil(self.sheet.SH_blockDidShow);
}

-(void)testSH_blockWillDismiss; {
  [self testSH_setWillDismisBlock];
  XCTAssertNotNil(self.sheet.SH_blockWillDismiss);
}

-(void)testSH_blockDidDismiss; {
  [self testSH_setDidDismisBlock];
  XCTAssertNotNil(self.sheet.SH_blockDidDismiss);
  
}




@end
