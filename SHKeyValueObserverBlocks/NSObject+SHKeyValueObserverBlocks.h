//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs


typedef void (^SHKeyValueObserverBlock)(id weakSelf, NSString *keyPath, NSDictionary *change);

@interface NSObject (SHKeyValueObserverBlocks)

#pragma mark - 
#pragma mark Create Observers
-(NSString *)SH_addObserverForKeyPath:(NSString *)keyPath block:(SHKeyValueObserverBlock)theBlock;
-(NSString *)SH_addObserverForKeyPaths:(NSArray *)keyPaths block:(SHKeyValueObserverBlock)theBlock;

#pragma mark -
#pragma mark Remove Observers
- (void)SH_removeObserverForKeyPath:(NSString *)keyPath;
- (void)SH_removeAllBlockObservers;

@end
