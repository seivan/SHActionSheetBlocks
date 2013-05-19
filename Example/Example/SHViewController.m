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
  [super viewDidAppear:animated];
  
  [self SH_performSegueWithIdentifier:@"push" andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    id<SHExampleProtocol> destionationController =   theSegue.destinationViewController;
    destionationController.name = theSegue.identifier;
  }];

}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;{

}


@end
