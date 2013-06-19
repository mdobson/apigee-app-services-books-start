##iOS Template app for App Services

This is a basic Books app that will be built using Objective-C, XCode, and StoryBoards.

Some important point code snippets.

Things that the template is missing

* UI
    1. Setup segue to the new book view named `@"newBook"`
    2. Setup outlets in detail view for the following properties
        * Title
        * Author
        * UUID
* Code
    1. Setup client intialization
    2. Setup lookup of all books
        * Set cell text label to book title
    3. Display single book object in detail view
        * Set values for title, author, and uuid in code.
    4. Setup Adding a new book
    5. Setup deleting a book
    6. **Bonus!** Implement a search bar in the master view that uses a query to look a book up by title.



Initializing our Objetive-C SDK.

```objective-c
_client = [[UGClient alloc] initWithOrganizationId:@"YOUR APIGEE.COM USERNAME" withApplicationID:@"sandbox"];
```
Creating an entity with a NSMutableDictionary Literal

```objective-c
NSMutableDictionary *book = @{ @"type":@"book", @"title":"The Great Gatsby", @"author":@"Fitzgerald"}; 
UGClientResponse *response = [_client createEntity:book];
//Lets check if our response was accepted by the server, and add the created object to a collection called _objects
if (response.transactionState == kUGClientResponseSuccess) {
    [_objects insertObject:response.response[@"entities"][0] atIndex:0];
}
```
Deleting a book

```objective-c
NSDictionary *entity = [_objects objectAtIndex:indexPath.row];
UGClientResponse * response = [_client removeEntity:@"book" entityID:entity[@"uuid"]];
if (response.transactionState == kUGClientResponseSuccess) {
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
```
Retrieving books from your UserGrid account.
```objective-c
//Getting all of your books without a filtering query.
UGClientResponse *result = [_client getEntities:@"book" query:nil];
if (result.transactionState == kUGClientResponseSuccess) {
   _objects = result.response[@"entities"];
} else {
   _objects = @[];
}
```

1. Clone Repo
2. Open in XCode
3. Click Play
