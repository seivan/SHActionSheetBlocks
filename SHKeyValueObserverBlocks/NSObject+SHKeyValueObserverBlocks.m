//
//  UIViewController+SHSegueBlock.m
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "NSObject+SHKeyValueObserverBlocks.h"
#import <objc/runtime.h>

@interface SHKeyValueObserverBlocksManager : NSObject

@property(nonatomic,strong) NSMapTable   * mapBlocks;
@property(nonatomic,strong) NSMutableSet * setOfHijackedClasses;

+(instancetype)sharedManager;
-(void)hijackDeallocForClass:(Class)theClass;
-(void)SH_memoryDebugger;
@end


@implementation SHKeyValueObserverBlocksManager
#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable strongToStrongObjectsMapTable];
    self.setOfHijackedClasses = [NSMutableSet set];

    [self SH_memoryDebugger];
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
#pragma mark Swizzling
-(void)hijackDeallocForClass:(Class)theClass; {
  if ([self.setOfHijackedClasses containsObject:theClass] == NO) {
    
    SEL    deallocSelector               = NSSelectorFromString(@"dealloc");
    SEL    hijackedDeallocSelector       = NSSelectorFromString(@"hijackedDealloc");
    Method deallocMethod                 = class_getInstanceMethod(theClass, deallocSelector);
    Method hijackedDeallocMethod         = class_getInstanceMethod(theClass, hijackedDeallocSelector);
    
    IMP    hijackedDeallocImplementation = method_getImplementation(hijackedDeallocMethod);
    
    //merge hijackedDeallocImplementation on the deallocSelector
    class_replaceMethod(theClass,
                        deallocSelector,
                        hijackedDeallocImplementation,
                        method_getTypeEncoding(deallocMethod)
                        );
    
    
    [self.setOfHijackedClasses addObject:theClass];
  }

}

#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

    NSLog(@"MAP %@",self.mapBlocks);
    NSLog(@"SET %@",self.setOfHijackedClasses);
    [self SH_memoryDebugger];
  });
}


@end

@interface NSObject ()
@property(nonatomic,readonly) NSMapTable   * mapObserverBlocks;
@property(nonatomic,readonly) NSString     * identifier;

@end


@implementation NSObject (SHKeyValueObserverBlocks)

#pragma mark -
#pragma mark Create Observers



-(void)SH_addObserverForKeyPath:(NSString *)keyPath block:(SHKeyValueObserverBlock)theBlock; {
  [self SH_addObserverForKeyPaths:@[keyPath] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    theBlock(weakSelf, keyPath, change);
  }];
}

-(void)SH_addObserverForKeyPaths:(NSArray *)keyPaths block:(SHKeyValueObserverBlock)theBlock; {
  
  [self hijackDealloc];

  [keyPaths enumerateObjectsUsingBlock:^(NSString * keyPath, NSUInteger _, BOOL *__) {
    NSMutableDictionary * blocks = [self.mapObserverBlocks objectForKey:self.identifier];
    if(blocks == nil) blocks = @{}.mutableCopy;
    blocks[keyPath] = [theBlock copy];
    [self.mapObserverBlocks setObject:blocks forKey:self.identifier];
    [self addObserver:self forKeyPath:keyPath options:0 context:NULL];
  }];

}

#pragma mark -
#pragma mark Remove Observers
- (void)SH_removeObserverForKeyPath:(NSString *)keyPath; {
  NSMutableDictionary * blocks = [self.mapObserverBlocks objectForKey:self.identifier];
  [self removeObserver:self forKeyPath:keyPath];
  [blocks removeObjectForKey:keyPath];
  [self.mapObserverBlocks setObject:blocks forKey:self.identifier];
  
}

-(void)SH_removeAllBlockObservers; {
  NSMutableDictionary * blocks = [self.mapObserverBlocks objectForKey:self.identifier];
  [self.mapObserverBlocks removeObjectForKey:self.identifier];
  [blocks enumerateKeysAndObjectsUsingBlock:^(NSString * keyPath, id _, BOOL *__) {
    [self removeObserver:self forKeyPath:keyPath];
  }];
  [self.mapObserverBlocks removeObjectForKey:self.identifier];
}


#pragma mark -
#pragma mark Privates

#pragma mark -
#pragma mark Swizzling
-(void)hijackedDealloc; {
  [self SH_removeAllBlockObservers];
}

-(void)hijackDealloc; {
  Class class = [self class];
  [SHKeyValueObserverBlocksManager.sharedManager hijackDeallocForClass:class];
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters

static char kDisgustingSwizzledVariableKey;
-(NSString *)identifier; {
  NSString * _identifier = objc_getAssociatedObject(self, kDisgustingSwizzledVariableKey);
  if(_identifier == nil) {
    _identifier = [[NSUUID UUID] UUIDString];
    objc_setAssociatedObject(self, kDisgustingSwizzledVariableKey, _identifier, OBJC_ASSOCIATION_ASSIGN);
  }
  return _identifier;
}

-(NSMapTable *)mapObserverBlocks; {
  return SHKeyValueObserverBlocksManager.sharedManager.mapBlocks;
}


#pragma mark -
#pragma mark Standard Observer
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context; {
  NSMutableDictionary * blocks = [self.mapObserverBlocks objectForKey:self.identifier];
  SHKeyValueObserverBlock block = blocks[keyPath];
  if(block) block(self,keyPath,change);
}
#pragma clang diagnostic pop

@end
