//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs
typedef void (^SHControlEventBlock)(UIControl * sender);

@interface UIControl (SHControlBlocks)

#pragma mark -
#pragma mark Add block
-(void)SH_addControlBlockForControlEvents:(UIControlEvents)controlEvents
                           withEventBlock:(SHControlEventBlock)theBlock;



#pragma mark -
#pragma mark Remove block
-(void)SH_removeControlBlockForControlEvents:(UIControlEvents)controlEvents;
-(void)SH_removeControlBlock:(SHControlEventBlock)theBlock;
-(void)SH_removeAllControlBlocks;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters
@property(nonatomic,readonly) NSDictionary * SH_controlBlocks;

@end
