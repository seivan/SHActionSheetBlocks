//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIControl+SHControlBlocks.h"



@interface SHControlBlocksManager : NSObject
@property(nonatomic,strong) NSHashTable     * mapBlocks;
+(instancetype)sharedManager;
-(void)SH_memoryDebugger;
@end
@implementation SHControlBlocksManager
#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSHashTable weakObjectsHashTable];
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
    self.tableBlocks   = [NSHashTable weakObjectsHashTable];
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
@property(nonatomic,strong) NSMutableSet * mutableBlocks;
@end



@implementation UIControl (SHControlBlocks)

#pragma mark -
#pragma mark Add block
-(void)SH_addControlEvents:(UIControlEvents)controlEvents
                 withBlock:(SHControlEventBlock)theBlock; {

  SHControl * control = [[SHControl alloc]
                         initWithControlBlockForControlEvents:controlEvents
                         withEventBlock:[theBlock copy]];
  [self addTarget:control action:@selector(performAction:) forControlEvents:controlEvents];
  [self.mutableBlocks addObject:control];
}

-(void)SH_addControlEventTouchUpInsideWithBlock:(SHControlEventBlock)theBlock; {
  [self SH_addControlEvents:UIControlEventTouchUpInside withBlock:theBlock];
}

#pragma mark -
#pragma mark Helpers
-(NSSet *)SH_blocksForControlEvent:(UIControlEvents)theControlEvents; {
  
}

-(NSSet *)SH_controlEventsForBlock:(SHControlEventBlock)theBlock; {
  
}


#pragma mark -
#pragma mark Remove block
-(void)SH_removeControlEventTouchUpInside; {
  
}

-(void)SH_removeBlocksForControlEvents:(UIControlEvents)controlEvents; {
  
}



-(void)SH_removeControlEventsForBlock:(SHControlEventBlock)theBlock; {
//  [self.mutableBlocks removeObject:theBlock];
//  if(self.mutableBlocks.count < 1)
//    [self SH_removeAllBlocks];
}

-(void)SH_removeAllControlEventsBlocks; {
//  [self.view removeGestureRecognizer:self];
//  [self removeTarget:nil action:nil];
  self.mutableBlocks = nil;
}


#pragma mark -
#pragma mark Properties


#pragma mark -
#pragma mark Getters
-(NSSet *)SH_controlBlocks; {
  return self.mutableBlocks.copy;
}

-(BOOL)SH_isTouchUpInsideEnabled; {
  return NO;
}

#pragma mark -
#pragma mark Privates


#pragma mark -
#pragma mark - Properties

#pragma mark -
#pragma mark - Getters
-(NSMutableSet *)mutableBlocks; {
  NSMutableSet * blocks = nil;
  //[[SHControlBlocksManager sharedManager].mapBlocks
//   objectForKey:self];
  if(blocks == nil) {
    blocks = [NSMutableSet set];
    self.mutableBlocks = blocks;
  }
  return blocks;
}

#pragma mark -
#pragma mark - Setters
-(void)setMutableBlocks:(NSMutableSet *)theSet; {
//  if(theSet == nil) {
////    [self removeTarget:nil action:nil];
//    [SHControlBlocksManager.sharedManager.mapBlocks
//     removeObjectForKey:self];
//  }
//  else
//    [SHControlBlocksManager.sharedManager.mapBlocks
//     setObject:theSet forKey:self];
  
}

@end

