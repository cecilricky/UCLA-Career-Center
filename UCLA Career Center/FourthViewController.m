//
//  FourthViewController.m
//  UCLA Career Center
//
//  Created by Ricky Yu on 2/9/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//
#import "ContactTableCell.h"
#import <sys/sysctl.h>
#import <stdlib.h>
#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController
{
    NSArray *tableData;
    NSArray *contactName;
    NSArray *contactEmail;
    NSArray *contactNumber;
}
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
	// Do any additional setup after loading the view.
   // datas=[NSArray arrayWithObjects:@"Egg Benddic",@"heloo",@"fuaivniurhgvaiuhrigvabnivbanuiebvnisubvnisubviubseviusbeviaebvisbvaieubvaikubvauibkviabviaeubira",@"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ContactDatas" ofType:@"plist"];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    contactName=[dict objectForKey:@"contactName"];
    contactNumber=[dict objectForKey:@"contactNumber"];
    contactEmail=[dict objectForKey:@"contactEmail"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 //   NSLog(@"%@",[contactName objectAtIndex:1]);
   // NSLog(@"%@",[contactEmail objectAtIndex:1]);
   // NSLog(@"%@",[contactNumber objectAtIndex:1]);
    
    return [contactName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier=@"CustomContactTableCell";
/*
    ContactTableCell *cell=(ContactTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactTableCell" owner:self options:nil];

        cell=[nib objectAtIndex:0];
    }
      //  cell.textLabel.text=[datas objectAtIndex:indexPath.row];
  
    cell.namelabel.text=[contactName objectAtIndex:indexPath.row];
    cell.emaillabel.text=[contactEmail objectAtIndex:indexPath.row];
    cell.numberlabel.text=[contactNumber objectAtIndex:indexPath.row];

        return cell;

    //static NSString *simpleTableIdentifier = @"SimpleTableItem";
 */
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 16.0 ];

    //Main cell name
    cell.textLabel.text = [contactName objectAtIndex:indexPath.row];
    cell.textLabel.font  = myFont;
    
    //subcell- phone number
    cell.detailTextLabel.text=[contactNumber objectAtIndex:indexPath.row];
    
    //Not fully functional call function below
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(cell.frame.origin.x + 100, cell.frame.origin.y + 20, 100, 30);
    [button setTitle:[contactNumber objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    button.backgroundColor= [UIColor clearColor];
    [cell.contentView addSubview:button];
    */
    
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
