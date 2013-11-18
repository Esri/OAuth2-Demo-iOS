//
//  OADAppDelegate.h
//  OAuth Demo
//
//  Created by Aaron Parecki on 11/18/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const OADTokenDefaultsName = @"OADTokenDefaultsName";
static NSString *const OADUsernameDefaultsName = @"OADUsernameDefaultsName";
static NSString *const OADTokenExpirationDefaultsName = @"OADTokenExpirationDefaultsName";
static NSString *const OADNewTokenAvailable = @"OADNewTokenAvailable";

@interface OADAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
