//
//  MasterViewController.m
//  HTMLParsing
//
//  Created by Matt Galloway on 19/05/2012.
//  Copyright (c) 2012 Swipe Stack Ltd. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "TFHpple.h"
#import "Tutorial.h"


@interface MasterViewController () {
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //image slide section
    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"img1.png"],
                             [UIImage imageNamed:@"img2.png"],
                             [UIImage imageNamed:@"img3.png"],
                             [UIImage imageNamed:@"img4.png"],
                             nil];
    //    _ImageSection = [[UIImageView alloc] initWithFrame:
    //                             CGRectMake(100, 125, 150, 130)];
    _ImageSection.animationImages = imageArray;
    _ImageSection.animationDuration = 15;
    [self.view addSubview:_ImageSection];
    [_ImageSection startAnimating];
    
    
	[self loadTutorials];
    [self loadTutorials2];
    
}

//For events section
-(void)loadTutorials {
    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:@"http://cssauclabbs.org/uclacareercenter/cc.html"];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3
    NSString *tutorialsXpathQueryString = @"//div[@class='events']/ul/li/a";
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    // 4
    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in tutorialsNodes) {
        // 5
        Tutorial *tutorial = [[Tutorial alloc] init];
        [newTutorials addObject:tutorial];
        
        // 6
        tutorial.title = [[element firstChild] content];
        
        // 7
        tutorial.url = [element objectForKey:@"href"];
        tutorial.time = [element objectForKey:@"alt"];
      //  NSString* siteurl = @"http://guishanyijia.com/";
        //tutorial.url = [siteurl stringByAppendingString:tutorial.url];
    }
    
       // 8
    _objects = newTutorials;
    [self.tableView reloadData];
}

//ForJumpStart Section
-(void)loadTutorials2 {
    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:@"http://cssauclabbs.org/uclacareercenter/cc.html"];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3
    NSString *tutorialsXpathQueryString = @"//div[@class='workshops']/ul/li/a";
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    // 4
    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in tutorialsNodes) {
        // 5
        Tutorial *tutorial = [[Tutorial alloc] init];
        [newTutorials addObject:tutorial];
        
        // 6
        tutorial.title = [[element firstChild] content];
        
        // 7
        tutorial.url = [element objectForKey:@"href"];
        tutorial.time = [element objectForKey:@"alt"];
        //  NSString* siteurl = @"http://guishanyijia.com/";
        //tutorial.url = [siteurl stringByAppendingString:tutorial.url];
    }
    
    // 8
    _objects2 = newTutorials;
    [self.tableView reloadData];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
        tableViewHeaderFooterView.textLabel.textColor = [UIColor grayColor];
    }
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
    
    switch (section) {
        case 0:
            return @"Events";
            break;
        case 1:
            return @"JumpStart";
            break;
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _objects.count;
            break;
        case 1:
            return _objects2.count;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    
    if (indexPath.section == 0) {
        Tutorial *thisTutorial = [_objects objectAtIndex:indexPath.row];
        cell.textLabel.text = thisTutorial.title;
        cell.detailTextLabel.text = thisTutorial.time;
    
    } else if (indexPath.section == 1) {
        Tutorial *thisTutorial2 = [_objects2 objectAtIndex:indexPath.row];
        cell.textLabel.text = thisTutorial2.title;
        cell.detailTextLabel.text = thisTutorial2.time;
    }
  //  cell.detailTextLabel.text = thisTutorial.url;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     //   NSDate *object = _objects[indexPath.row];
        Tutorial *thisTutorial = [_objects objectAtIndex:indexPath.row];
        Tutorial *thisTutorial2 = [_objects2 objectAtIndex:indexPath.row];
        [[segue destinationViewController] setSelecturl:thisTutorial.url];
        [[segue destinationViewController] setSelecturl:thisTutorial2.url];
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (!self.detailViewController) {
//        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
//    }
//    NSDate *object = [_objects objectAtIndex:indexPath.row];
//    self.detailViewController.detailItem = object;
//    [self.navigationController pushViewController:self.detailViewController animated:YES];
//}


@end
