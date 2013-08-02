////
////  ExampleTests.m
////  ExampleTests
////
////  Created by Seivan Heidari on 7/27/13.
////  Copyright (c) 2013 Seivan Heidari. All rights reserved.
////
//
//
//#import "SHActionSheetBlocksSuper.h"
//@interface SHActionSheetBlocksCallbacks : SHActionSheetBlocksSuper
//
//@end
//
//
//
//
//@implementation SHActionSheetBlocksCallbacks
//
//-(void)setUp; {
//  [super setUp];
//  self.block = ^(NSInteger theButtonIndex) {};
//  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
//  self.vc = UIViewController.new;
//  [UIApplication sharedApplication].keyWindow.rootViewController = self.vc;
//  
//  
//}
//
//-(void)tearDown; {
//  [super tearDown];
//}
//
//-(void)testSeparateBlocksPerButton; {
//
//
//
//
//  __block BOOL didCallCancelButton      = NO;
//  __block BOOL didCallButtonOne         = NO;
//  __block BOOL didCallButtonTwo         = NO;
//  __block BOOL didCallDestructiveButton = NO;
//
//  [self.sheet SH_addButtonCancelWithTitle:@"Cancel" withBlock:^(NSInteger theButtonIndex) {
//    didCallCancelButton = YES;
//  }];
//  
//  [self.sheet SH_addButtonWithTitle:@"Button1" withBlock:^(NSInteger theButtonIndex) {
//    didCallButtonOne = YES;
//  }];
//  
//  [self.sheet SH_addButtonWithTitle:@"Button2" withBlock:^(NSInteger theButtonIndex) {
//    didCallButtonTwo = YES;
//  }];
//  
//  [self.sheet SH_addButtonDestructiveWithTitle:@"Delete" withBlock:^(NSInteger theButtonIndex) {
//    didCallDestructiveButton = YES;
//  //  *isFinished = YES;
//    
//    
//  }];
//  
//  
//
//
//  STAssertTrue(didCallCancelButton, nil);
//  STAssertTrue(didCallButtonOne, nil);
//  STAssertTrue(didCallButtonTwo, nil);
//  STAssertTrue(didCallDestructiveButton, nil);
//
//
//
//
//
//
//
//}
//
//@end
