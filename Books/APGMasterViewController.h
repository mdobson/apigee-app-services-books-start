//
//  APGMasterViewController.h
//  Books
//
//  Created by Matthew Dobson on 6/13/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGClient.h"

@protocol MasterViewDelegate <NSObject>

- (void)addNewBook:(NSDictionary *)book;

@end

@class APGDetailViewController;

@interface APGMasterViewController : UITableViewController<MasterViewDelegate,UISearchBarDelegate>

@property (strong, nonatomic) APGDetailViewController *detailViewController;
@property (strong, nonatomic) UGClient *client;

@end
