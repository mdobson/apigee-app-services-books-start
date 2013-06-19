//
//  APGNewBookViewController.m
//  Books
//
//  Created by Matthew Dobson on 6/13/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import "APGNewBookViewController.h"

@interface APGNewBookViewController ()

@end

@implementation APGNewBookViewController

@synthesize bookTitleText, bookAuthorText, delegate;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Here is the action method that creates a book. We pull values from the new book view fields.
//Then we create a dictionary from those values, and pass that dictionary back to the main view
//using a delegate method.
-(IBAction)createBook:(id)sender {
    [[self delegate] addNewBook:@{@"title": bookTitleText.text, @"author": bookAuthorText.text}];
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

@end
