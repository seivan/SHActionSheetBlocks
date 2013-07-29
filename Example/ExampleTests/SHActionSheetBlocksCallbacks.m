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

@end

@implementation SenTestCase (SRTAdditions)

- (void)SH_runCurrentRunLoopUntilTestPasses:(PXPredicateBlock)predicate timeout:(NSTimeInterval)timeout; {
  NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
  
  NSTimeInterval timeoutTime = [timeoutDate timeIntervalSinceReferenceDate];
  NSTimeInterval currentTime;
  
  for (currentTime = [NSDate timeIntervalSinceReferenceDate];
       !predicate() && currentTime < timeoutTime;
       currentTime = [NSDate timeIntervalSinceReferenceDate]) {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
  }
  
  STAssertTrue(currentTime <= timeoutTime, @"Timed out");
}

@end

#import "SHActionSheetBlocksSuper.h"
@interface SHActionSheetBlocksCallbacks : SHActionSheetBlocksSuper

@end




@implementation SHActionSheetBlocksCallbacks

-(void)setUp; {
  [super setUp];
  self.block = ^(NSUInteger theButtonIndex) {};
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  self.vc = UIViewController.new;
  [UIApplication sharedApplication].keyWindow.rootViewController = self.vc;
  
  
}

-(void)tearDown; {
  [super tearDown];
}

-(void)testSeparateBlocksPerButton; {




  __block BOOL isFinished = NO;
  __block BOOL isFinished2 = NO;
  [self.sheet SH_addButtonCancelWithTitle:@"Cancel" withBlock:^(NSUInteger theButtonIndex) {

  }];
  
  [self.sheet SH_addButtonWithTitle:@"Button1" withBlock:^(NSUInteger theButtonIndex) {

  }];
  
  [self.sheet SH_addButtonWithTitle:@"Button2" withBlock:^(NSUInteger theButtonIndex) {

  }];
  
  [self.sheet SH_addButtonDestructiveWithTitle:@"Delete" withBlock:^(NSUInteger theButtonIndex) {
    isFinished = YES;

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


[self SH_runCurrentRunLoopUntilTestPasses:^BOOL{
  return isFinished;
} timeout:5];
  
  [self SH_runCurrentRunLoopUntilTestPasses:^BOOL{
    return isFinished2;
  } timeout:5];


}


@end
