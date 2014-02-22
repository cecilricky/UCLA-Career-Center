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
    __weak IBOutlet UISegmentedControl *validationControl;
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
    [messageLabel setHidden:YES];
    [firstName setHidden:YES];
    [lastName setHidden:YES];
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
- (IBAction)changeNextButton:(id)sender {
    [messageLabel setText:@""];
    NSString *segmentTitle = [validationControl titleForSegmentAtIndex:[validationControl selectedSegmentIndex]];
    if ([segmentTitle isEqualToString:@"Login"])
    {
        [nextButton setTitle:@"Login" forState:UIControlStateNormal];
        [firstName setHidden:YES];
        [lastName setHidden:YES];
    }
    else
    {
        [nextButton setTitle:@"Create ID" forState:UIControlStateNormal];
        [firstName setHidden:NO];
        [lastName setHidden:NO];
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
    
    [messageLabel setTextColor:[UIColor blackColor]];
    [messageLabel setHidden:NO];

    if (![self NSStringIsValidEmail:[userID text]]) //Bad email.
    {
        [messageLabel setTextColor:[UIColor redColor]];
        [messageLabel setText:@"Not a valid email."];
        return;
    }
    else
    {
         NSString *segmentTitle = [validationControl titleForSegmentAtIndex:[validationControl selectedSegmentIndex]];        
        if ([segmentTitle isEqualToString:@"Login"]) //Login with an existing ID
            
        {
            //Query the existing database.
            PFQuery *query = [PFQuery queryWithClassName:@"User"];
            [query whereKey:@"username" equalTo:[userID text]];
            [query whereKey:@"password" equalTo:[userPassword text]];
            NSArray *users = [query findObjects];
            
            if ([users count] == 0) //Couldn't find user based off of query
            {
                [messageLabel setTextColor:[UIColor redColor]];
                [messageLabel setText:@"Couldn't find your information"];
            }
            else //User validated information.
            {
                [messageLabel setText:@"You have been logged in!"];
                //Display new view controller here.
            }
        }
        else //Create a new id
        {
            PFQuery *query = [PFQuery queryWithClassName:@"User"];
            [query whereKey:@"username" equalTo:[userID text]];
            NSArray *users = [query findObjects];
            
            if ([users count] >= 1) //User already exists
            {
                [messageLabel setTextColor:[UIColor redColor]];
                [messageLabel setText:@"That user already exists"];
            }
            else if ([[userPassword text] length] <= MinPasswordLength)
            {
                [messageLabel setTextColor:[UIColor redColor]];
                [messageLabel setText: [NSString stringWithFormat:@"Password must have at least %d characters", MinPasswordLength]];
            }
            else
            {
                PFObject *newUser = [PFObject objectWithClassName:@"User"];
                newUser[@"username"] = [userID text];
                newUser[@"password"] = [userPassword text];
                newUser[@"firstName"] = [firstName text];
                newUser[@"lastName"] = [lastName text];
                [newUser saveInBackground];
                [messageLabel setText:@"New login ID successfully created"];
            }
        }
    }
}



@end
