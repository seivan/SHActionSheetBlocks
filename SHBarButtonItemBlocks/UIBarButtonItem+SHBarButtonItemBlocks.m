//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIBarButtonItem+SHBarButtonItemBlocks.h"



@interface SHBarButtonItemBlocksManager : NSObject
@property(nonatomic,strong) NSMapTable * mapBlocks;
+(instancetype)sharedManager;
+(SEL)selectorAction;
-(void)SH_memoryDebugger;
-(void)performAction:(UIBarButtonItem *)theSender;
@end
@implementation SHBarButtonItemBlocksManager
#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHBarButtonItemBlocksManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHBarButtonItemBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}

+(SEL)selectorAction; { return @selector(performAction:); }

-(void)performAction:(UIBarButtonItem *)theSender; {
  NSSet * blocks = [self.mapBlocks objectForKey:theSender];
  for (SHBarButtonItemBlock block in blocks) {
    block(theSender);
  }
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

//@interface SHControl : NSObject
//-(instancetype)initWithControlBlockForControlEvents:(UIControlEvents)controlEvents
//                            withEventBlock:(SHControlEventBlock)theBlock;
//
//@property(nonatomic,assign) UIControlEvents     controlEvents;
//@property(nonatomic,strong) NSHashTable       * tableBlocks;
//@end
//
//@implementation SHControl
//
//-(instancetype)initWithControlBlockForControlEvents:(UIControlEvents)controlEvents
//                           withEventBlock:(SHControlEventBlock)theBlock; {
//  self = [super init];
//	if (self) {
//    self.tableBlocks   = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
//    [self.tableBlocks addObject:theBlock];
//    self.controlEvents = controlEvents;
//	}
//	return self;
//}
//
//
//
//-(void)performAction:(id)sender; {
//  NSSet * immutableTableBlocks = self.tableBlocks.setRepresentation;
//	for (SHControlEventBlock block in immutableTableBlocks) {
//    block(sender);
//  }
//}
//
//@end

@interface UIBarButtonItem ()
@property(nonatomic,readonly) NSMutableSet * setOfBlocks;
@end




@implementation UIBarButtonItem (SHBarButtonItemBlocks)
#pragma mark -
#pragma mark Init

-(instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                 withBlock:(SHBarButtonItemBlock)theBlock; {
  
  UIBarButtonItem * barButtonItem =  [self initWithBarButtonSystemItem:systemItem
                                                                target:nil
                                                                action:nil];
  [barButtonItem SH_addBlock:theBlock];
  return barButtonItem;
}

-(instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style
                   withBlock:(SHBarButtonItemBlock)theBlock; {
  
  UIBarButtonItem * barButtonItem =  [self initWithImage:image
                                                   style:style
                                                  target:nil
                                                  action:nil];
  [barButtonItem SH_addBlock:theBlock];
  return barButtonItem;
  
}

-(instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style
                   withBlock:(SHBarButtonItemBlock)theBlock; {
  
  UIBarButtonItem * barButtonItem =  [self initWithTitle:title
                                                   style:style
                                                  target:nil
                                                  action:nil];
  [barButtonItem SH_addBlock:theBlock];
  return barButtonItem;
  
}

#pragma mark -
#pragma mark Add
-(void)SH_addBlock:(SHBarButtonItemBlock)theBlock; {
  SHBarButtonItemBlock block = [theBlock copy];
  self.target = [SHBarButtonItemBlocksManager sharedManager];
  self.action = [SHBarButtonItemBlocksManager selectorAction];
}

#pragma mark -
#pragma mark Remove
-(void)SH_removeBlock:(SHBarButtonItemBlock)theBlock; {
  [self.setOfBlocks removeObject:theBlock];
  if(self.setOfBlocks.count == 0){
    self.target = nil;
    self.action = nil;
  }
}

-(void)SH_removeAllBlocks; {
  [self.setOfBlocks removeAllObjects];
  self.target = nil;
  self.action = nil;
}



#pragma mark -
#pragma mark Add block
-(void)SH_addControlEvents:(UIControlEvents)controlEvents
                 withBlock:(SHControlEventBlock)theBlock; {


  NSAssert(theBlock, @"theBlock is required");
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
  NSAssert(theBlock, @"theBlock is required");
  [self SH_addControlEvents:UIControlEventTouchUpInside withBlock:theBlock];
}


#pragma mark -
#pragma mark Properties


#pragma mark -
#pragma mark Getters
-(NSSet *)SH_blocks; {
  return self.setOfBlocks.copy;
}

#pragma mark -
#pragma mark Privates

-(NSMutableSet *)setOfBlocks; {
  NSMutableSet * setOfBlocks =  [[SHBarButtonItemBlocksManager sharedManager].mapBlocks objectForKey:self];
  if (setOfBlocks == nil)
    self.setOfBlocks = [NSMutableSet set];

  return setOfBlocks;
}

-(void)setSetOfBlocks:(NSMutableSet *)setOfBlocks; {
  if(setOfBlocks)
    [[SHBarButtonItemBlocksManager sharedManager].mapBlocks setObject:setOfBlocks forKey:self];
  else {
    self.target = nil;
    self.action = nil;
    [[SHBarButtonItemBlocksManager sharedManager].mapBlocks removeObjectForKey:self];
  }

}


@end

