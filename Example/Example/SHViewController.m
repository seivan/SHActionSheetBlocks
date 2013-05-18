//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//




#import "SHViewController.h"
@interface SHViewController ()
-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;
@end

@implementation SHViewController
@synthesize name;
-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  if(self.SH_userInfo.count > 0)
    NSLog(@"Sent here by unwinding programatically and using userInfo; %@", self.SH_userInfo);
  else
    NSLog(@"Sent here by unwinding through IB and no userInfo; %@", self.SH_userInfo);
  [super viewDidAppear:animated];
  [self SH_performSegueWithIdentifier:@"push" andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    id<SHExampleProtocol> destionationController =   theSegue.destinationViewController;
    destionationController.name = theSegue.identifier;
  }];

}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;{

}


@end
