//
//  OADFirstViewController.h
//  OAuth Demo
//
//  Created by Aaron Parecki on 11/18/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OADFirstViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *signInBtn;
@property (strong, nonatomic) IBOutlet UIButton *signOutBtn;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tokenLabel;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *tokenField;

- (IBAction)signInWasTapped:(id)sender;
- (IBAction)signOutWasTapped:(id)sender;

@end
