//
//  APGMasterViewController.m
//  Books
//
//  Created by Matthew Dobson on 6/13/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import "APGMasterViewController.h"

#import "APGDetailViewController.h"

#import "APGNewBookViewController.h"

#import "UGClient.h"

@interface APGMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation APGMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    static NSString *orgName = @"YOUR APIGEE.COM USERNAME";
    static NSString *appName = @"sandbox";
    //TODO: Step 3). Initialize your client here.
    //TODO: Step 4). Retrieve all books here.

    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (APGDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    //Here we perform a segue that will open the new book view.
    [self performSegueWithIdentifier:@"newBook" sender:self];
}

//This delegate method is called after we fill out our form in the new book view
//it passes a dictionary of data back, and will allow us to create a new book from the form
- (void)addNewBook:(NSDictionary *)book {
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    //TODO: Step 5). Create a new book in App Services, then add it to the _objects array.
    
    //This is called so our table view data is reloaded.
    [self.tableView reloadData];
    

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //TODO: Step 4). Set the cell text label to the book's title here.
    
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
        //TODO: Step 6). Add deletion code here. You'll want to get the uuid of the book you want to delete and call the remove entity method.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    } else if ([[segue identifier] isEqualToString:@"newBook"]) {
        //Here is where we handle the newBook segue. We want to set our main view as a delegate of the new book view so it
        //can pass data back to us
        APGNewBookViewController * vc = [[APGNewBookViewController alloc] init];
        [(APGNewBookViewController *)[segue destinationViewController] setDelegate:self];
    }
}

/*
BONUS EXAMPLE CODE.
This code will show you how to use a query to find objects. If we have time we'll implement a search bar.
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    UGQuery * query = [[UGQuery alloc] init];
    [query addRequirement:[NSString stringWithFormat:@"title='%@'", searchBar.text]];
    UGClientResponse *result = [self.client getEntities:@"book" query:query];
    if (result.transactionState == kUGClientResponseSuccess) {
        _objects = result.response[@"entities"];
    } else {
        _objects = @[];
    }
    [self.tableView reloadData];
}*/

@end
