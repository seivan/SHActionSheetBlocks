//
//  UIGestureRecognizer+SHGestureRecognizerBlocks.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs
typedef void (^SHGestureRecognizerBlock)(UIGestureRecognizer * sender, UIGestureRecognizerState state, CGPoint location);



@interface UIGestureRecognizer (SHGestureRecognizerBlocks)

#pragma mark -
#pragma mark Init
-(instancetype)SH_initWithBlock:(SHGestureRecognizerBlock)theBlock;
+(instancetype)SH_recognizerWithBlock:(SHGestureRecognizerBlock)theBlock;

#pragma mark -
#pragma mark Add blocks
-(instancetype)SH_initWithBlock:(SHGestureRecognizerBlock)theBlock;

#pragma mark -
#pragma mark Remove blocks
-(instancetype)SH_initWithBlock:(SHGestureRecognizerBlock)theBlock;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters
@property(nonatomic,readonly) NSArray * SH_blocks;



//#pragma mark -
//#pragma mark Configuration
//
//#pragma mark -
//#pragma mark Property
//+(BOOL)SH_isAutoRemovingObservers;
//+(void)SH_isAutoRemovingObservers:(BOOL)shouldRemoveObservers;
//#pragma mark - 
//#pragma mark Create Observers
//
//-(NSString *)SH_addObserverForKeyPaths:(id<NSFastEnumeration>)theKeyPaths
//                                 block:(SHKeyValueObserverBlock)theBlock;
//
//-(NSString *)SH_addObserverForKeyPaths:(id<NSFastEnumeration>)theKeyPaths
//                           withOptions:(NSKeyValueObservingOptions)theOptions
//                                 block:(SHKeyValueObserverBlock)theBlock;
//
//
//#pragma mark -
//#pragma mark Helpers
//-(BOOL)SH_handleObserverForKeyPath:(NSString *)theKeyPath
//                        withChange:(NSDictionary *)theChange
//                           context:(void *)context;
//
//
//#pragma mark -
//#pragma mark Remove Observers
//-(void)SH_removeObserversForKeyPaths:(id<NSFastEnumeration>)theKeyPaths
//                         withIdentifiers:(id<NSFastEnumeration>)theIdentifiers;
//
//-(void)SH_removeObserversWithIdentifiers:(id<NSFastEnumeration>)theIdentifiers;
//
//-(void)SH_removeObserversForKeyPaths:(id<NSFastEnumeration>)theKeyPaths;
//
//-(void)SH_removeAllObservers;

@end
