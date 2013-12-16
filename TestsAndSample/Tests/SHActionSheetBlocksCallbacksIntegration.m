//
//  SHActionSheetBlocksCallbacksScenarion.m
//  Example
//
//  Created by Seivan Heidari on 7/31/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHActionSheetBlocksSuper.h"


@interface SHActionSheetBlocksCallbacksIntegration : SHActionSheetBlocksSuper
@property(nonatomic,strong) UIViewController    * vc;
@property(nonatomic,strong) UIActionSheet       * sheet;


@end

@implementation SHActionSheetBlocksCallbacksIntegration
-(void)beforeEach; {
  [super beforeEach];
  
  
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  self.vc    = UIViewController.new;

  
  [UIApplication sharedApplication].keyWindow.rootViewController = self.vc;
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];

  
}


-(void)testSingleButton; {
  NSString * buttonTitle   = @"Button1";
  __block BOOL didPassTest = NO;
  [self.sheet SH_addButtonWithTitle:buttonTitle withBlock:^(NSInteger theButtonIndex) {
    XCTAssertEqual(theButtonIndex, 0);
    didPassTest = YES;
  }];
  [self.sheet showInView:self.vc.view];
  [tester tapViewWithAccessibilityLabel:buttonTitle];
  
  XCTAssertTrue(didPassTest);
  
}

-(void)testDestructiveButton; {
  NSString * buttonTitle   = @"Delete";
  __block BOOL didPassTest = NO;
  [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle withBlock:^(NSInteger theButtonIndex) {
    XCTAssertEqual(theButtonIndex, 0);
    XCTAssertEqual(theButtonIndex, self.sheet.destructiveButtonIndex);
    didPassTest = YES;
  }];
  [self.sheet showInView:self.vc.view];
  [tester tapViewWithAccessibilityLabel:buttonTitle];
  
  XCTAssertTrue(didPassTest);
  
}

-(void)testCancelButton; {
  NSString * buttonTitle   = @"Cancel";
  __block BOOL didPassTest = NO;
  [self.sheet SH_addButtonCancelWithTitle:buttonTitle withBlock:^(NSInteger theButtonIndex) {
    XCTAssertEqual(theButtonIndex, 0);
    XCTAssertEqual(theButtonIndex, self.sheet.cancelButtonIndex);
    didPassTest = YES;
  }];
  [self.sheet showInView:self.vc.view];
  [tester tapViewWithAccessibilityLabel:buttonTitle];
  
  XCTAssertTrue(didPassTest);
}

-(void)testSingleBlock; {
  
  NSArray * buttons = @[@"Button", @"Cancel", @"Delete"];
  
  [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    __block BOOL didPassTest = NO;
    NSMutableArray * theButtonList = buttons.mutableCopy;
    NSString * buttonTitle = theButtonList.firstObject;
    [theButtonList removeObjectAtIndex:0];
    
    NSString * cancelButtonTitle = theButtonList.firstObject;
    [theButtonList removeObjectAtIndex:0];
    
    NSString * destructiveButtonTitle = theButtonList.firstObject;
    [theButtonList removeObjectAtIndex:0];
    
    self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"
                                           buttonTitles:@[buttonTitle]
                                            cancelTitle:cancelButtonTitle
                                       destructiveTitle:destructiveButtonTitle
                                              withBlock:^(NSInteger theButtonIndex) {
                                                didPassTest = YES;
                                                
                                                
                                              }];
    [self.sheet showInView:self.vc.view];
    [tester tapViewWithAccessibilityLabel:obj];
    XCTAssertTrue(didPassTest);

  }];
}


-(void)testSheetAppearanceLifeCycleBlocks; {
  
    NSString * buttonTitle   = @"Delete";
  
  __block BOOL willShowBlock    = NO;
  __block BOOL didShowBlock     = NO;
  __block BOOL willDismissBlock = NO;
  __block BOOL didDismissBlock  = NO;
  
//  [self SH_performAsyncTestsWithinBlock:^(BOOL *didFinish) {
    
    [self.sheet SH_addButtonDestructiveWithTitle:buttonTitle withBlock:^(NSInteger theButtonIndex) {}];
  
    [self.sheet SH_setWillShowBlock:^(UIActionSheet *theActionSheet) {
      willShowBlock = YES;
    }];
    
    [self.sheet SH_setDidShowBlock:^(UIActionSheet *theActionSheet) {
      didShowBlock = YES;
    }];
    
    [self.sheet SH_setWillDismissBlock:^(UIActionSheet *theActionSheet, NSInteger theButtonIndex) {
      willDismissBlock = YES;
      XCTAssertEqualObjects(self.sheet, theActionSheet);
      XCTAssertEqual(theButtonIndex, theActionSheet.destructiveButtonIndex);
    }];
    
    [self.sheet SH_setDidDismissBlock:^(UIActionSheet *theActionSheet, NSInteger theButtonIndex) {
      didDismissBlock = YES;
      XCTAssertEqualObjects(self.sheet, theActionSheet);
      XCTAssertEqual(theButtonIndex, theActionSheet.destructiveButtonIndex);
    }];
  
  [self.sheet showInView:self.vc.view];
  [tester tapViewWithAccessibilityLabel:buttonTitle];
//  } withTimeout:5];
  
  
  XCTAssertTrue(willShowBlock);
  XCTAssertTrue(didShowBlock);
  XCTAssertTrue(willDismissBlock);
  XCTAssertTrue(didDismissBlock);
  
  
}




@end
