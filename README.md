##iOS Template app for App Services

This is a basic Books app that will be built using Objective-C, XCode, and StoryBoards.

Some important point code snippets.

Things that the template is missing

### TODOs for completion

1. Setup segue to the new book view named `@"newBook"`
2. Setup outlets in detail view for the following properties
    * Title
    * Author
    * UUID
3. Setup client intialization
4. Setup lookup of all books
    * Make sure the objects appear in the `_objects` array
    * Set title text of cell to the book title
6. Setup Adding a new book
7. Setup deleting a book
8. **Bonus!** Implement a search bar in the master view that uses a query to look a book up by title.



Initializing our Objetive-C SDK.

```objective-c
self.client = [[UGClient alloc] initWithOrganizationId:@"YOUR APIGEE.COM USERNAME" withApplicationID:@"sandbox"];
```
Creating an entity with a NSMutableDictionary Literal

```objective-c
NSMutableDictionary *book = @{ @"type":@"book", @"title":"The Great Gatsby", @"author":@"Fitzgerald"}; 
UGClientResponse *response = [self.client createEntity:book];
//Lets check if our response was accepted by the server, and add the created object to a collection called _objects
if (response.transactionState == kUGClientResponseSuccess) {
    [_objects insertObject:response.response[@"entities"][0] atIndex:0];
}
```
Deleting a book

```objective-c
NSDictionary *entity = [_objects objectAtIndex:indexPath.row];
UGClientResponse * response = [self.client removeEntity:@"book" entityID:entity[@"uuid"]];
if (response.transactionState == kUGClientResponseSuccess) {
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
```
Retrieving books from your UserGrid account.
```objective-c
//Getting all of your books without a filtering query.
UGClientResponse *result = [self.client getEntities:@"book" query:nil];
if (result.transactionState == kUGClientResponseSuccess) {
   _objects = result.response[@"entities"];
} else {
   _objects = @[];
}
```

Implementing a search bar delegate method to search for books with a query
```objective-c
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
}
```

1. Clone Repo
2. Open in XCode
3. Click Play
