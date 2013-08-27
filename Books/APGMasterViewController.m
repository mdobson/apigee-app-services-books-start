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

#import <ApigeeiOSSDK/ApigeeClient.h>

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

//This is a UIView method that allows you to trigger UI Updates and other
//view specific logic in your code. Here we are going to initialize your client
//for the self.client property and do some pre-setup by looking up our books.
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

//Here we need to setup our view logic for each table cell that a book represents.
//We want the main text label to be the title of the book.
//We want the detail label of the cell to be the book's author.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *title = _objects[indexPath.row][@"title"];
    NSString *author = _objects[indexPath.row][@"author"];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = author;
    
    return cell;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        //TODO: Step 6). Add deletion code here. You'll want to get the uuid of the book you want to delete and call the remove entity method.
        [tableView endUpdates];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

//IGNORE ALL CODE BELOW!

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

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


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
