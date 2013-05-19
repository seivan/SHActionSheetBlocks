//
//  UIViewController+SHSegueBlock.m
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "NSObject+SHKeyValueObserverBlocks.h"


@interface SHKeyValueObserverBlocksManager : NSObject

@property(nonatomic,strong) NSMapTable * mapBlocks;

+(instancetype)sharedManager;

-(void)SH_memoryDebugger;
@end


@implementation SHKeyValueObserverBlocksManager
#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks      = [NSMapTable weakToWeakObjectsMapTable];

//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHKeyValueObserverBlocksManager *_sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHKeyValueObserverBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}

#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 5.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

    NSLog(@"BLOCK %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}

@end

@interface NSObject ()

@property(nonatomic,readonly) NSMapTable * mapBlocks;


@end

@implementation NSObject (SHKeyValueObserverBlocks)

#pragma mark -
#pragma mark Privates

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters
-(NSMapTable *)mapBlocks; {
  return SHKeyValueObserverBlocksManager.sharedManager.mapBlocks;
}

@end
