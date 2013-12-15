//
//  SHAppDelegate.m
//  Library
//
//  Created by Seivan Heidari on 2013-12-15.
//  Copyright (c) 2013 Seivan. All rights reserved.
//

#import "SHAppDelegate.h"

@implementation SHAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  self.window.rootViewController = UIViewController.new;
  return YES;
}


@end
