//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs

typedef void(^SHPrepareForSegue)(UIStoryboardSegue *theSegue);
typedef void(^SHPrepareForSegueDestinationViewController)(UIViewController * theDestinationViewController);
typedef void(^SHPrepareForSegueWithUserInfo)(NSMutableDictionary * theUserInfo);



@interface UIViewController (SHSegueBlocks)
#pragma mark -
#pragma mark Properties

@property(nonatomic,strong) NSMutableDictionary * SH_userInfo;

#pragma mark -
#pragma mark Segue Performers


-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
           andPrepareForSegueBlock:(SHPrepareForSegue)theBlock;

-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
             andDestinationViewController:(SHPrepareForSegueDestinationViewController)theBlock;


-(BOOL)SH_handlesBlockForSegue:(UIStoryboardSegue *)theSegue;
#pragma mark -
#pragma mark Don't Use
//I don't recomend using this - it's stupid. If you need your destination controller to have certain properties, use a fucking protocol.
-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
              withUserInfo:(NSDictionary *)theUserInfo;


@end
