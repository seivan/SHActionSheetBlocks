//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs

//typedef void(^SHPrepareForSegue)(UIStoryboardSegue *theSegue);
//typedef void(^SHPrepareForSegueDestinationViewController)(UIViewController * theDestinationViewController);
//typedef void(^SHPrepareForSegueWithUserInfo)(NSMutableDictionary * theUserInfo);

typedef void (^BKSenderBlock)(id sender);
typedef void (^BKSenderKeyPathBlock)(id obj, NSString *keyPath);
typedef void (^SHKeyValueObserverReceiver)(id obj, NSDictionary *change);
typedef void (^SHKeyValueObserverAll)(id obj, NSString *keyPath, NSDictionary *change);

@interface NSObject (SHKeyValueObserverBlocks)

/** Adds an observer to an object conforming to NSKeyValueObserving.
 
 Adds a block observer that executes a block upon a state change.
 
 @param keyPath The property to observe, relative to the reciever.
 @param task A block with no return argument, and a single parameter: the reciever.
 @return Returns a globally unique process identifier for removing
 observation with removeObserverWithBlockToken:.
 @see addObserverForKeyPath:identifier:options:task:
 */
-(NSString *)SH_addObserverForKeyPath:(NSString *)keyPath task:(BKSenderBlock)task;

/** Adds an observer to an object conforming to NSKeyValueObserving.
 
 Adds a block observer that executes the same block upon
 multiple state changes.
 
 @param keyPaths An array of properties to observe, relative to the reciever.
 @param task A block with no return argument and two parameters: the
 reciever and the key path of the value change.
 @return A unique identifier for removing
 observation with removeObserverWithBlockToken:.
 @see addObserverForKeyPath:identifier:options:task:
 */
-(NSString *)SH_addObserverForKeyPaths:(NSArray *)keyPaths task:(BKMultipleObservationBlock)task;

/** Adds an observer to an object conforming to NSKeyValueObserving.
 
 Adds a block observer that executes a block upon a state change
 with specific options.
 
 @param keyPath The property to observe, relative to the reciever.
 @param options The NSKeyValueObservingOptions to use.
 @param task A block with no return argument and two parameters: the
 reciever and the change dictionary.
 @return Returns a globally unique process identifier for removing
 observation with removeObserverWithBlockToken:.
 @see addObserverForKeyPath:identifier:options:task:
 */
- (NSString *)SH_addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options task:(BKObservationBlock)task;

/** Adds an observer to an object conforming to NSKeyValueObserving.
 
 Adds a block observer that executes the same block upon
 multiple state changes with specific options.
 
 @param keyPaths An array of properties to observe, relative to the reciever.
 @param options The NSKeyValueObservingOptions to use.
 @param task A block with no return argument and three parameters: the
 reciever, the key path of the value change, and the change dictionary.
 @param task A block responding to the reciever, the key path, and the KVO change.
 @return A unique identifier for removing
 observation with removeObserverWithBlockToken:.
 @see addObserverForKeyPath:identifier:options:task:
 */
- (NSString *)SH_addObserverForKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options task:(BKMultipleObservationBlock)task;

/** Adds an observer to an object conforming to NSKeyValueObserving.
 
 Adds a block observer that executes the block upon a
 state change.
 
 @param keyPath The property to observe, relative to the reciever.
 @param token An identifier for the observation block.
 @param options The NSKeyValueObservingOptions to use.
 @param task A block responding to the reciever and the KVO change.
 observation with removeObserverWithBlockToken:.
 @see addObserverForKeyPath:task:
 */
- (void)SH_addObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token options:(NSKeyValueObservingOptions)options task:(BKObservationBlock)task;

/** Adds an observer to an object conforming to NSKeyValueObserving.
 
 Adds a block observer that executes the same block upon
 multiple state changes.
 
 @param keyPaths An array of properties to observe, relative to the reciever.
 @param token An identifier for the observation block.
 @param options The NSKeyValueObservingOptions to use.
 @param task A block responding to the reciever, the key path, and the KVO change.
 observation with removeObserversWithIdentifier:.
 @see addObserverForKeyPath:task:
 */
- (void)SH_addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)token options:(NSKeyValueObservingOptions)options task:(BKMultipleObservationBlock)task;

/** Removes a block observer.
 
 @param keyPath The property to stop observing, relative to the reciever.
 @param token The unique key returned by addObserverForKeyPath:task:
 or the identifier given in addObserverForKeyPath:identifier:task:.
 @see removeObserversWithIdentifier:
 */
- (void)SH_removeObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token;

/** Removes multiple block observers with a certain identifier.
 
 @param token A unique key returned by addObserverForKeyPath:task:
 and addObserverForKeyPaths:task: or the identifier given in
 addObserverForKeyPath:identifier:task: and
 addObserverForKeyPaths:identifier:task:.
 @see removeObserverForKeyPath:identifier:
 */
- (void)SH_removeObserversWithIdentifier:(NSString *)token;

/** Remove all registered block observers. */
- (void)SH_removeAllBlockObservers;

@end
