//
//  ASFiltersViewController.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASFiltersViewController.h"

/* filter cell types */
#import "ASFilterToggleTableViewCell.h"
#import "ASFilterExpandableTableViewCell.h"

@interface ASFiltersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterList;
@property (weak, nonatomic) NSMutableArray *categories;


@end

@implementation ASFiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        /* based on sample by Nick Halper */
        self.categories = [NSMutableArray arrayWithObjects:
                        @{
                             @"name": @"Most Popular",
                             @"type": @"ASFilterToggleTableViewCell",
                             @"list": @[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
                        },
                        @{
                             @"name": @"Distance",
                             @"type": @"ASFilterExpandableTableViewCell",
                             @"list": @[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"]
                        },
                        @{
                             @"name": @"Sort By",
                             @"type": @"ASFilterExpandableTableViewCell",
                             @"list": @[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"]
                        },
                        @{
                             @"name": @"General Features",
                             @"type": @"ASFilterExpandableTableViewCell",
                             @"list": @[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible", @"Full Bar", @"Beer & Wine only", @"Happy Hour", @"Free Wi-fi", @"Paid Wi-fi"]
                        },
                        nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.filterList.dataSource = self;
    self.filterList.delegate = self;
    
    
    
    /* we need this for our custom filter cells*/
    /* toggle */
    UINib *toggleCellNib = [UINib nibWithNibName:@"ASFilterToggleTableViewCell" bundle:nil];
    [self.filterList registerNib:toggleCellNib forCellReuseIdentifier:@"ASFilterToggleTableViewCell"];
    /* expandable */
    UINib *expandableCellNib = [UINib nibWithNibName:@"ASFilterExpandableTableViewCell" bundle:nil];
    [self.filterList registerNib:expandableCellNib forCellReuseIdentifier:@"ASFilterExpandableTableViewCell"];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitable methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"num rows in section");
    if (section == 0){
        return [NSArray arrayWithArray:self.categories[section][@"list"]].count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"dequeuing: %i %i %@", indexPath.section, indexPath.row, self.categories[indexPath.section][@"type"]);
    return [tableView dequeueReusableCellWithIdentifier:self.categories[indexPath.section][@"type"] forIndexPath:indexPath];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categories[section][@"name"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categories.count;
}



@end
