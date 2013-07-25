##iOS Template app for App Services

This is a basic Books app that will be built using Objective-C, XCode, and StoryBoards.

Some important point code snippets.

Things that the template is missing

### SDK Setup
This template now uses the new [Apigee iOS SDK](https://github.com/apigee/apigee-ios-sdk)

You'll have to do a few things to get this new framework to work.

1. Build the framework by cloning the SDK and running the following script in the command line `./Scripts/framework.sh`
2. Add two linker flags into the build settings of your project `-ObjC -all_load`
3. Add the following frameworks to your project
  1. CoreGraphics
  2. CoreLocation
  3. CoreTelephony
  4. SystemConfiguration
4. Find the `ApigeeiOSSDK.framework` in the build folder of the clone SDK.

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
[[self.client dataClient] createEntity:@{@"type":@"book", @"title":book[@"title"], @"author":book[@"author"]} completionHandler:^(ApigeeClientResponse *response){
        if (response.transactionState == kApigeeClientResponseSuccess) {
            [_objects insertObject:response.response[@"entities"][0] atIndex:0];
        } else {
            [_objects insertObject:@{@"title":@"error"} atIndex:0];
        }
        [self.tableView reloadData];
    }];
```
Deleting a book

```objective-c
[[self.client dataClient] removeEntity:@"book"
                  entityID:entity[@"uuid"]
         completionHandler:^(ApigeeClientResponse *response){
             if (response.transactionState == kApigeeClientResponseSuccess) {
                 [_objects removeObjectAtIndex:indexPath.row];
                 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             }
         }];
```

Retrieving books from your UserGrid account.

```objective-c
//Getting all of your books without a filtering query.
  [[self.client dataClient] getEntities:@"book" query:nil
                        completionHandler:^(ApigeeClientResponse *result){
                            if (result.transactionState == kApigeeClientResponseSuccess) {
                                _objects = result.response[@"entities"];
                            } else {
                                _objects = @[];
                            }
                            [self.tableView reloadData];
                        }];
```

Implementing a search bar delegate method to search for books with a query
```objective-c
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    ApigeeQuery * query = [[ApigeeQuery alloc] init];
    [query addRequirement:[NSString stringWithFormat:@"title='%@'", searchBar.text]];
    [[self.client dataClient] getEntities:@"book"
                                    query:query
                        completionHandler:^(ApigeeClientResponse *result){
                            if (result.transactionState == kApigeeClientResponseSuccess) {
                                _objects = result.response[@"entities"];
                            } else {
                                _objects = @[];
                            }
                            [self.tableView reloadData];
                        }];
}
```

1. Clone Repo
2. Open in XCode
3. Click Play
