//
//  ASNavController.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/21/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASNavController.h"

@interface ASNavController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation ASNavController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
