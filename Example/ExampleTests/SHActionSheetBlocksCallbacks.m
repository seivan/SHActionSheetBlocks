//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHActionSheetBlocksSuper.h"

@interface SenTestCase (SRTAdditions)
typedef BOOL (^PXPredicateBlock)();
typedef void (^PXExecuteBlock)(BOOL isFinished);
@end

@implementation SenTestCase (SRTAdditions)

- (void)SH_runTests:(PXExecuteBlock)theExecuteBlock withCurrentRunLoopUntilTestPasses:(PXPredicateBlock)predicate timeout:(NSTimeInterval)timeout; {
  
  NSDate * timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
  
  NSTimeInterval timeoutTime = [timeoutDate timeIntervalSinceReferenceDate];
  NSTimeInterval currentTime = 0.0;
  
  for (currentTime = [NSDate timeIntervalSinceReferenceDate];
       (predicate() == NO && currentTime < timeoutTime);
       currentTime = [NSDate timeIntervalSinceReferenceDate]) {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
  }
  
  STAssertTrue(currentTime <= timeoutTime, @"Timed out");
}

- (void)SH_xrunTests:(PXExecuteBlock)theExecuteBlock withCurrentRunLoopUntilTestPasses:(PXPredicateBlock)predicate timeout:(NSTimeInterval)timeout; {
  
  NSDate * timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
  
  NSTimeInterval timeoutSeconds = [timeoutDate timeIntervalSinceReferenceDate];
  NSTimeInterval currentTime = 0.0;
  
  for (currentTime = [NSDate timeIntervalSinceReferenceDate];
       (predicate() == NO && currentTime < timeoutSeconds);
       currentTime = [NSDate timeIntervalSinceReferenceDate]) {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
  }
  
  STAssertTrue(currentTime <= timeoutSeconds, @"Timed out");
}


@end

#import "SHActionSheetBlocksSuper.h"
@interface SHActionSheetBlocksCallbacks : SHActionSheetBlocksSuper

@end




@implementation SHActionSheetBlocksCallbacks

-(void)setUp; {
  [super setUp];
  self.block = ^(NSInteger theButtonIndex) {};
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  self.vc = UIViewController.new;
  [UIApplication sharedApplication].keyWindow.rootViewController = self.vc;
  
  
}

-(void)tearDown; {
  [super tearDown];
}

-(void)testSeparateBlocksPerButton; {




  __block BOOL isFinished = NO;
  
  
  [self.sheet SH_addButtonCancelWithTitle:@"Cancel" withBlock:^(NSInteger theButtonIndex) {
  }];
  
  [self.sheet SH_addButtonWithTitle:@"Button1" withBlock:^(NSInteger theButtonIndex) {

  }];
  
  [self.sheet SH_addButtonWithTitle:@"Button2" withBlock:^(NSInteger theButtonIndex) {

  }];
  
  [self.sheet SH_addButtonDestructiveWithTitle:@"Delete" withBlock:^(NSInteger theButtonIndex) {
    isFinished = YES;
    self.sheet.SH_blockForCancelButton(self.sheet.cancelButtonIndex);

  }];
  
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [self.sheet showInView:self.vc.view];
    STAssertTrue(self.sheet.isVisible, nil);
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      self.sheet.SH_blockForDestructiveButton(self.sheet.destructiveButtonIndex);
    });
  });


  [self SH_xrunTests:nil withCurrentRunLoopUntilTestPasses:^BOOL{
        return isFinished;
  } timeout:5];
  

}


@end
