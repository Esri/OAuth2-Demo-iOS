//
//  OADFirstViewController.m
//  OAuth Demo
//
//  Created by Aaron Parecki on 11/18/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import "OADFirstViewController.h"
#import "OADAppDelegate.h"

@interface OADFirstViewController ()

@end

@implementation OADFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshSignedInState];
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(refreshSignedInState)
												 name:OADNewTokenAvailable
											   object:nil];
}

- (void)refreshSignedInState
{
    NSDate *expDate;
    if((expDate=[[NSUserDefaults standardUserDefaults] objectForKey:OADTokenExpirationDefaultsName])) {
        NSLog(@"%@", expDate);
        if(expDate.timeIntervalSince1970 >= NSDate.date.timeIntervalSince1970) {
            [self userIsSignedIn];
        } else {
            [self userIsSignedOut];
        }
    } else {
        [self userIsSignedOut];
    }
    [self displayLoginInfo];
}

- (void)userIsSignedOut
{
    self.signInBtn.hidden = NO;
    self.signOutBtn.hidden = YES;
    self.usernameLabel.hidden = YES;
    self.usernameField.hidden = YES;
    self.tokenLabel.hidden = YES;
    self.tokenField.hidden = YES;
}

- (void)userIsSignedIn
{
    self.signInBtn.hidden = YES;
    self.signOutBtn.hidden = NO;
    self.usernameLabel.hidden = NO;
    self.usernameField.hidden = NO;
    self.tokenLabel.hidden = NO;
    self.tokenField.hidden = NO;
}

- (void)displayLoginInfo
{
    self.usernameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:OADUsernameDefaultsName];
    self.tokenField.text = [[NSUserDefaults standardUserDefaults] objectForKey:OADTokenDefaultsName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInWasTapped:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"https://www.arcgis.com/sharing/oauth2/authorize?"
                  "response_type=token&"
                  "client_id=eKNjzFFjH9A1ysYd&"
                  "redirect_uri=oauthdemo://auth"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)signOutWasTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:OADTokenDefaultsName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:OADUsernameDefaultsName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:OADTokenExpirationDefaultsName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self refreshSignedInState];
}

@end
