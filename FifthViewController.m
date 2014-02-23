//
//  FifthViewController.m
//  UCLA Career Center
//
//  Created by Jamey Roland on 2/22/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "FifthViewController.h"
#import <Parse/Parse.h>

#define MinPasswordLength 7
@interface FifthViewController ()
{
    
    __weak IBOutlet UITextField *userID;
    __weak IBOutlet UITextField *userPassword;
    __weak IBOutlet UITextField *firstName;
    __weak IBOutlet UITextField *lastName;
    __weak IBOutlet UITextField *userEmail;
    __weak IBOutlet UITextField *userCompany;
    
    __weak IBOutlet UISegmentedControl *userType;
    __weak IBOutlet UISegmentedControl *userAction;
    __weak IBOutlet UIButton *nextButton;
    __weak IBOutlet UILabel *messageLabel;
}

@end

@implementation FifthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [userID setDelegate:self];
    [userPassword setDelegate:self];
    [firstName setDelegate:self];
    [lastName setDelegate:self];
    [userEmail setDelegate:self];
    [userCompany setDelegate:self];
    
    [messageLabel setHidden:YES];
    [firstName setHidden:YES];
    [lastName setHidden:YES];
    [userEmail setHidden:YES];
    [userCompany setHidden:YES];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma UserDefined

- (IBAction)switchUserType:(id)sender {
    [messageLabel setText:@""];
    NSString *segmentTitle = [userType titleForSegmentAtIndex:[userType selectedSegmentIndex]];
    if ([segmentTitle isEqualToString:@"Student"]) //User is a student
    {
        [userCompany setHidden:YES];
    }
    else //User is an employer
    {
        if ([[userAction titleForSegmentAtIndex:[userAction selectedSegmentIndex]] isEqualToString:@"Create ID"])
        {
            [userCompany setHidden:NO];
        }
    }
}

- (IBAction)switchUserAction:(id)sender {
    [messageLabel setText:@""];
    NSString *segmentTitle = [userAction titleForSegmentAtIndex:[userAction selectedSegmentIndex]];
    if ([segmentTitle isEqualToString:@"Login"]) //User is logging in
    {
        [nextButton setTitle:@"Login" forState:UIControlStateNormal];
        [firstName setHidden:YES];
        [lastName setHidden:YES];
        [userEmail setHidden:YES];
        [userCompany setHidden:YES];
    }
    else //User is creating a new account
    {
        [nextButton setTitle:@"Create ID" forState:UIControlStateNormal];
        [firstName setHidden:NO];
        [lastName setHidden:NO];
        [userEmail setHidden:NO];
        if ([[userType titleForSegmentAtIndex:[userType selectedSegmentIndex]] isEqualToString:@"Student"])
        {
            [userCompany setHidden:YES];
        }
        else
        {
            [userCompany setHidden:NO];
        }
        
    }
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return ([emailTest evaluateWithObject:checkString] && ([checkString hasSuffix:@"ucla.edu"]));
}


- (IBAction)loginOrCreateID:(id)sender {
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser)
    {
        //Set up the next View.
    }
    [messageLabel setTextColor:[UIColor blackColor]];
    [messageLabel setHidden:NO];
    
    if ([[userAction titleForSegmentAtIndex:[userAction selectedSegmentIndex]] isEqualToString:@"Login"]) //User Login
        
    {
        if ([[userID text] isEqualToString:@""] || [[userPassword text] isEqualToString:@""])
        {
            [messageLabel setTextColor:[UIColor redColor]];
            [messageLabel setText:@"Fill in all fields"];
            return;
        }
        PFUser *user = [PFUser user]; //Create a new user based off info
        [user setUsername:[userID text]];
        [user setPassword:[userPassword text]];
        [PFUser logInWithUsername:[user username] password:[user password]];
        [PFUser logInWithUsernameInBackground:[user username] password:[user password] block:^(PFUser *user, NSError *error) {
            if (user) {
                [messageLabel setText:@"Successful login"];
                //Set up the next view.
            }
            else
            {
                NSString *errorString = [error userInfo][@"error"];
                [messageLabel setTextColor:[UIColor redColor]];
                [messageLabel setText:errorString];
            }
        }];
        
    }
    else //Create new user
    {
        if ([[userID text] isEqualToString:@""] || [[userPassword text] isEqualToString:@""] || [[firstName text] isEqualToString:@""] ||[[lastName text] isEqualToString:@""] || [[userEmail text] isEqualToString:@""]) //Ensure all fields full.
        {
            [messageLabel setTextColor:[UIColor redColor]];
            [messageLabel setText:@"Fill in all fields"];
            return;
        }
        
        PFUser *newUser = [PFUser user]; //Create a new user based off info
        [newUser setUsername:[userID text]];
        [newUser setPassword:[userPassword text]];
        newUser[@"first"] = [firstName text];
        newUser[@"last"] = [lastName text];
        newUser[@"email"] = [userEmail text];
        
        if ([[userType titleForSegmentAtIndex:[userType selectedSegmentIndex]]isEqualToString:@"Student"])
        {
            if (![self NSStringIsValidEmail:[userEmail text]])
            {
                [messageLabel setTextColor:[UIColor redColor]];
                [messageLabel setText:@"Not a valid UCLA Email"];
                return;
            }
        }
        else
        {
            if ([[userCompany text] isEqualToString:@""])
            {
                [messageLabel setTextColor:[UIColor redColor]];
                [messageLabel setText:@"Fill in all fields"];
                return;
            }
            newUser[@"company"] = [userCompany text];
        }
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
           if (!error)
           {
               [messageLabel setText:@"New login successfully created"];
           }
           else
           {
               NSString *errorString = [error userInfo][@"error"];
               [messageLabel setTextColor:[UIColor redColor]];
               [messageLabel setText:errorString];
           }
        }];
    }
}

@end
