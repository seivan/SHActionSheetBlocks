//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs


typedef void (^SHKeyValueObserverPathWeakSelf)(id weakSelf);
typedef void (^SHKeyValueObserverPaths)(id weakSelf, NSString *keyPath, NSDictionary *change);

@interface NSObject (SHKeyValueObserverBlocks)

-(NSString *)SH_addObserverForKeyPath:(NSString *)keyPath block:(SHKeyValueObserverWeakSelf)theBlock;
-(NSString *)SH_addObserverForKeyPaths:(NSArray *)keyPaths block:(SHKeyValueObserverAll)theBlock;

- (void)SH_removeObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token;

- (void)SH_removeObserversWithIdentifier:(NSString *)token;


- (void)SH_removeAllBlockObservers;

@end
