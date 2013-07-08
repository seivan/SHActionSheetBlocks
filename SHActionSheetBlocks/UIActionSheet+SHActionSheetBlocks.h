//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs
typedef void (^SHActionSheetBlock)(NSUInteger theButtonIndex);

typedef void (^SHActionSheetWillShowBlock)(UIActionSheet * theActionSheet);
typedef void (^SHActionSheetDidShowBlock)(UIActionSheet * theActionSheet);

typedef void (^SHActionSheetWillDismissBlock)(UIActionSheet * theActionSheet, NSUInteger theButtonIndex);
typedef void (^SHActionSheetDidDismissBlock)(UIActionSheet * theActionSheet, NSUInteger theButtonIndex);

@interface UIActionSheet (SHActionSheetBlocks)

#pragma mark -
#pragma mark Init
+(instancetype)SH_actionSheetWithTitle:(NSString *)theTitle;

#pragma mark -
#pragma mark Add
-(NSUInteger)SH_addButtonWithTitle:(NSString *)theTitle
                      withBlock:(SHActionSheetBlock)theBlock;

-(NSUInteger)SH_setDestructiveButtonWithTitle:(NSString *)theTitle
                                 withBlock:(SHActionSheetBlock)theBlock;

-(NSUInteger)SH_setCancelButtonWithTitle:(NSString *)theTitle
                            withBlock:(SHActionSheetBlock)theBlock;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setWillShowBlock:(SHActionSheetWillShowBlock)theBlock;
-(void)SH_setDidShowBlock:(SHActionSheetDidShowBlock)theBlock;

-(void)SH_setWillDismissBlock:(SHActionSheetWillDismissBlock)theBlock;
-(void)SH_setDidDismissBlock:(SHActionSheetDidDismissBlock)theBlock;

#pragma mark -
#pragma mark Getters

//@property(nonatomic,readonly) SHActionSheetBlock blockCancel;

@property(nonatomic,readonly) SHActionSheetWillShowBlock    SH_blockWillShow;
@property(nonatomic,readonly) SHActionSheetDidShowBlock     SH_blockDidShow;

@property(nonatomic,readonly) SHActionSheetWillDismissBlock SH_blockWillDismiss;
@property(nonatomic,readonly) SHActionSheetDidDismissBlock  SH_blockDidDismiss;

@end
