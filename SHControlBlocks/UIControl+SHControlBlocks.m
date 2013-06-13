//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIControl+SHControlBlocks.h"



@interface SHControlBlocksManager : NSObject
@property(nonatomic,strong) NSMapTable     * mapBlocks;
+(instancetype)sharedManager;
-(void)SH_memoryDebugger;
@end
@implementation SHControlBlocksManager
#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
    [self SH_memoryDebugger];
  }
  
  return self;
}
+(instancetype)sharedManager; {
  static SHControlBlocksManager *_sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHControlBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}
#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}
@end

@interface SHControl : NSObject
-(instancetype)initWithControlBlockForControlEvents:(UIControlEvents)controlEvents
                            withEventBlock:(SHControlEventBlock)theBlock;

@property(nonatomic,assign) UIControlEvents     controlEvents;
@property(nonatomic,strong) NSHashTable       * tableBlocks;
@end

@implementation SHControl

-(instancetype)initWithControlBlockForControlEvents:(UIControlEvents)controlEvents
                           withEventBlock:(SHControlEventBlock)theBlock; {
  self = [super init];
	if (self) {
    self.tableBlocks   = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
    [self.tableBlocks addObject:theBlock];
    self.controlEvents = controlEvents;
	}
	return self;
}



-(void)performAction:(id)sender; {
	for (SHControlEventBlock block in self.tableBlocks) {
    block(sender);
  }
}

@end

@interface UIControl ()
@property(nonatomic,readonly) NSHashTable * tableControls;
@end

@interface UIControl (Private)
-(SHControl *)shControlForControlEvents:(UIControlEvents)theControlEvents;
@end



@implementation UIControl (SHControlBlocks)
-(SHControl *)shControlForControlEvents:(UIControlEvents)theControlEvents; {
  SHControl * shControl = nil;
  for (SHControl * control in self.tableControls)
    if (control.controlEvents == theControlEvents ) {
      shControl = control;
      continue;
    }

  return shControl;
}
#pragma mark -
#pragma mark Add block
-(void)SH_addControlEvents:(UIControlEvents)controlEvents
                 withBlock:(SHControlEventBlock)theBlock; {


  
  SHControlEventBlock block = [theBlock copy];
  SHControl * control = [self shControlForControlEvents:controlEvents];
  if(control) {
    [control.tableBlocks addObject:block];
  }
  else {
    control = [[SHControl alloc]
               initWithControlBlockForControlEvents:controlEvents
               withEventBlock:block];
  }
  [self addTarget:control action:@selector(performAction:) forControlEvents:controlEvents];
  [self.tableControls addObject:control];

}

-(void)SH_addControlEventTouchUpInsideWithBlock:(SHControlEventBlock)theBlock; {
  [self SH_addControlEvents:UIControlEventTouchUpInside withBlock:theBlock];
}

#pragma mark -
#pragma mark Helpers
-(NSSet *)SH_blocksForControlEvents:(UIControlEvents)theControlEvents; {
  return nil;
}

-(NSSet *)SH_controlEventsForBlock:(SHControlEventBlock)theBlock; {
  return nil;
}


#pragma mark -
#pragma mark Remove block
-(void)SH_removeControlEventTouchUpInside; {
  [self SH_removeBlocksForControlEvents:UIControlEventTouchUpInside];
}

-(void)SH_removeBlocksForControlEvents:(UIControlEvents)controlEvents; {
  SHControl * control = [self shControlForControlEvents:controlEvents];
  [self removeTarget:control action:NULL forControlEvents:controlEvents];
  [self.tableControls removeObject:control];
}



-(void)SH_removeControlEventsForBlock:(SHControlEventBlock)theBlock; {
  for (SHControl * control in self.tableControls){
    if([control.tableBlocks containsObject:theBlock])
      [control.tableBlocks removeObject:theBlock];
    if(control.tableBlocks.count == 0)
      [self removeTarget:control action:NULL forControlEvents:control.controlEvents];
  }
}

-(void)SH_removeAllControlEventsBlocks; {
  self.tableControls = nil;
}


#pragma mark -
#pragma mark Properties


#pragma mark -
#pragma mark Getters
-(NSDictionary *)SH_controlBlocks; {
  return nil; //return self.mutableBlocks.copy;
}

-(BOOL)SH_isTouchUpInsideEnabled; {
  return NO;
}

#pragma mark -
#pragma mark Privates
-(NSHashTable *)tableControls; {
  NSHashTable * tableControls =  [[SHControlBlocksManager sharedManager].mapBlocks objectForKey:self];
  if (tableControls == nil)
    self.tableControls = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];

  return tableControls;
}

-(void)setTableControls:(NSHashTable *)tableControls; {
  if(tableControls)
    [[SHControlBlocksManager sharedManager].mapBlocks setObject:tableControls forKey:self];
  else {
    for (SHControl * control in self.tableControls)
      [self removeTarget:control action:NULL forControlEvents:control.controlEvents];
    [[SHControlBlocksManager sharedManager].mapBlocks removeObjectForKey:self];
  }

}


#pragma mark -
#pragma mark - Properties

#pragma mark -
#pragma mark - Getters
@end

