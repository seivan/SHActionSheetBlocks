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

-(void)testHasNoDestructiveButton; {
  STAssertEquals(self.sheet.destructiveButtonIndex, -1, nil);
}


-(void)testHasNoOtherFirstButton; {
  STAssertEquals(self.sheet.firstOtherButtonIndex, -1, nil);
}


-(void)testSH_actionSheetWithTitle; {
  STAssertEqualObjects(self.sheet.class  , UIActionSheet.class, nil);
}

-(void)testSH_actionSheetWithTitle_buttonTitles_cancelTitle_destructiveTitle_withBlock; {
  self.sheet = nil;
  NSString * cancelButtonTitle      = @"Cancel";
  NSString * destructiveButtonTitle = @"Destructive";
  
  NSArray * buttons = @[@"Button1", @"Button2", cancelButtonTitle, destructiveButtonTitle];
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title" buttonTitles:@[@"Button1", @"Button2"] cancelTitle:cancelButtonTitle destructiveTitle:destructiveButtonTitle withBlock:self.block];
  
  NSInteger buttonCount = buttons.count;
  STAssertEqualObjects(self.sheet.class  , UIActionSheet.class, nil);
  STAssertNotNil(self.sheet.title, nil);
  STAssertNotNil(self.block, nil);
  STAssertEquals(self.sheet.numberOfButtons, buttonCount, nil);
  STAssertNotNil(self.block, nil);
  STAssertEqualObjects(self.sheet.SH_blockForCancelButton, self.block, nil);
  STAssertEqualObjects(self.sheet.SH_blockForDestructiveButton , self.block, nil);
  
  STAssertEqualObjects(self.block, [self.sheet SH_blockForDestructiveButton], nil);
  STAssertEqualObjects(self.block, [self.sheet SH_blockForCancelButton], nil);
  
}

-(void)testSH_addButtonWithTitle_withBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonWithTitle:buttonTitle withBlock:self.block];
  
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEqualObjects([self.sheet buttonTitleAtIndex:buttonIndex], buttonTitle, nil);
}

-(void)testSH_addButtonDestructiveWithTitle_withBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle withBlock:self.block];
  
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEqualObjects([self.sheet buttonTitleAtIndex:buttonIndex], buttonTitle, nil);
  STAssertEquals(self.sheet.destructiveButtonIndex, buttonIndex, nil);
}

-(void)testSH_addButtonCancelWithTitle_withBlock; {
  NSString * buttonTitle = @"Button";
  NSInteger buttonIndex = [self.sheet SH_addButtonCancelWithTitle:buttonTitle withBlock:self.block];
  
  STAssertEquals(self.sheet.numberOfButtons, buttonIndex+1, nil);
  STAssertEqualObjects([self.sheet buttonTitleAtIndex:buttonIndex], buttonTitle, nil);
  STAssertEquals(self.sheet.cancelButtonIndex, buttonIndex, nil);
}


-(void)testSH_setButtonBlockForIndex_withBlock; {
  [self.sheet SH_setButtonBlockForIndex:0 withBlock:self.block];
  NSInteger zeroButtons = 0;
  STAssertEquals(self.sheet.numberOfButtons, zeroButtons, nil);
  STAssertEquals([self.sheet SH_blockForButtonIndex:0], self.block, nil);
  
  [self testSH_addButtonWithTitle_withBlock];
  
  SHActionSheetBlock block = ^(NSInteger theButtonIndex) {
    
  };

  [self.sheet SH_setButtonBlockForIndex:0 withBlock:block];
  STAssertEquals(self.sheet.numberOfButtons, 1, nil);
  STAssertEqualObjects([self.sheet SH_blockForButtonIndex:0], block, nil);
  
}

-(void)testSH_setButtonDestructiveBlock; {
  [self.sheet SH_setButtonDestructiveBlock:self.block];
  STAssertEqualObjects(self.sheet.SH_blockForDestructiveButton, nil, nil);
  
  [self testSH_addButtonDestructiveWithTitle_withBlock];
  STAssertEqualObjects(self.sheet.SH_blockForDestructiveButton, self.block, nil);

  SHActionSheetBlock block = ^(NSInteger theButtonIndex) {
    
  };

  
  [self.sheet SH_setButtonDestructiveBlock:block];
  STAssertEquals(self.sheet.numberOfButtons, 1, nil);
  STAssertEqualObjects(self.sheet.SH_blockForDestructiveButton, block, nil);
  
}


-(void)testSH_setButtonCancelBlock; {
  [self.sheet SH_setButtonCancelBlock:self.block];
  STAssertEqualObjects(self.sheet.SH_blockForCancelButton, nil, nil);
  
  [self testSH_addButtonCancelWithTitle_withBlock];
  STAssertEqualObjects(self.sheet.SH_blockForCancelButton, self.block, nil);
  
  SHActionSheetBlock block = ^(NSInteger theButtonIndex) {
    
  };
  
  [self.sheet SH_setButtonCancelBlock:block];
  STAssertEquals(self.sheet.numberOfButtons, 1, nil);
  STAssertEqualObjects(self.sheet.SH_blockForCancelButton, block, nil);
  
}

-(void)testSH_setWillShowBlock; {
  STAssertNil(self.sheet.SH_blockWillShow, nil);
  SHActionSheetShowBlock block = ^(UIActionSheet *theActionSheet) {
    
  };

  [self.sheet SH_setWillShowBlock:block];
  STAssertEqualObjects(self.sheet.SH_blockWillShow, block, nil);
}

-(void)testSH_setDidShowBlock; {
  STAssertNil(self.sheet.SH_blockDidShow, nil);
  SHActionSheetShowBlock block = ^(UIActionSheet *theActionSheet) {
    
  };
  
  [self.sheet SH_setDidShowBlock:block];
  STAssertEqualObjects(self.sheet.SH_blockDidShow, block, nil);
}

-(void)testSH_setWillDismisBlock; {
  STAssertNil(self.sheet.SH_blockWillDismiss, nil);
  SHActionSheetDismissBlock block = ^(UIActionSheet *theActionSheet, NSInteger theButtonIndex) {
    
  };
  
  [self.sheet SH_setWillDismissBlock:block];
  STAssertEqualObjects(self.sheet.SH_blockWillDismiss, block, nil);
}

-(void)testSH_setDidDismisBlock; {
  STAssertNil(self.sheet.SH_blockDidDismiss, nil);
  SHActionSheetDismissBlock block = ^(UIActionSheet *theActionSheet, NSInteger theButtonIndex) {
    
  };
  
  [self.sheet SH_setDidDismissBlock:block];
  STAssertEqualObjects(self.sheet.SH_blockDidDismiss, block, nil);
}

-(void)testSH_blockForButtonIndex; {
  [self testSH_setButtonBlockForIndex_withBlock];
  STAssertNotNil([self.sheet SH_blockForButtonIndex:0], nil);
}

-(void)testSH_blockForDestructiveButton; {
  [self testSH_setButtonDestructiveBlock];
  STAssertNotNil(self.sheet.SH_blockForDestructiveButton, nil);
}

-(void)testSH_blockForCancelButton; {
  [self testSH_setButtonCancelBlock];
  STAssertNotNil(self.sheet.SH_blockForCancelButton, nil);
}

-(void)testSH_blockWillShow; {
  [self testSH_setWillShowBlock];
  STAssertNotNil(self.sheet.SH_blockWillShow, nil);
}

-(void)testSH_blockDidShow; {
  [self testSH_setDidShowBlock];
  STAssertNotNil(self.sheet.SH_blockDidShow, nil);
}

-(void)testSH_blockWillDismiss; {
  [self testSH_setWillDismisBlock];
  STAssertNotNil(self.sheet.SH_blockWillDismiss, nil);
}

-(void)testSH_blockDidDismiss; {
  [self testSH_setDidDismisBlock];
  STAssertNotNil(self.sheet.SH_blockDidDismiss, nil);
}




@end
