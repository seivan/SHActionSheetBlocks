//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHSegueBlocks.h"
#import "SHViewController.h"
#import "SHActionSheetBlocks.h"
#import "SHBarButtonItemBlocks.h"

@interface SHViewController ()
<UIActionSheetDelegate>

-(void)popUpActionSheet;
@end

@implementation SHViewController

-(void)viewDidLoad; {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [UIBarButtonItem SH_barButtonItemWithBarButtonSystemItem:UIBarButtonSystemItemPlay withBlock:^(UIBarButtonItem *sender) {
    [self performSegueWithIdentifier:@"second" sender:nil];
  }];

}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  [self popUpActionSheet];
  

}

-(void)popUpActionSheet; {
  UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"title" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
  
  [sheet addButtonWithTitle:@"button1"];
  [sheet setDestructiveButtonIndex:1];
  [sheet setCancelButtonIndex:0];

  [sheet addButtonWithTitle:@"button2"];
  [sheet addButtonWithTitle:@"button3"];
  [sheet showInView:self.view];

}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

#pragma mark -
#pragma mark <UIActionSheetDelegate>
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;{
    NSLog(@"clickedButtonAtIndex: %d", buttonIndex);
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(UIActionSheet *)actionSheet; {
  
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet;{
  
}
// before animation and showing view
- (void)didPresentActionSheet:(UIActionSheet *)actionSheet; {
  
}
// after animation

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; {
  NSLog(@"willDismissWithButtonIndex: %d", buttonIndex);
}
// before animation and hiding view
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex; {
  NSLog(@"didDismissWithButtonIndex: %d", buttonIndex);
}
// after animation

@end
