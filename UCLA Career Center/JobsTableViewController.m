//
//  JobsTableViewController.m
//  UCLA Career Center
//
//  Created by Gabriel Lopez on 3/2/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "JobsTableViewController.h"

@interface JobsTableViewController () {
    NSMutableArray *jobs;
}

@end

@implementation JobsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Jobs";
    
    //retrieve info from Parse.com
    PFQuery *query = [PFQuery queryWithClassName:@"Job"];
    [query selectKeys:@[@"name", @"industries", @"number", @"gpa", @"hours", @"descrip", @"deadline"]];
    NSArray *results = [query findObjects:nil];
    
    //create array
    jobs = [[NSMutableArray alloc] init];

    for (PFObject *obj in results) {
        Job *job = [[Job alloc] init];
        job.name = [obj valueForKey:@"name"];
        job.industries = [obj valueForKey:@"industries"];
        job.number = [obj valueForKey:@"number"];
        job.gpa = [obj valueForKey:@"gpa"];
        job.hours = [obj valueForKey:@"hours"];
        job.descrip = [obj valueForKey:@"descrip"];
        job.deadline = [obj valueForKey:@"deadline"];
        
        [jobs addObject:job];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return jobs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Job *current = [jobs objectAtIndex:indexPath.row];
    cell.textLabel.text = [current name];
    cell.detailTextLabel.text = [current deadline];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    JobDescriptionViewController *jdvc = [segue destinationViewController];
    // Pass the selected object to the new view controller.
    // what's the selected cell?
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Job *c = jobs[path.row];
    [jdvc setCurrentJob:c];
}


@end
