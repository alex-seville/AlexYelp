//
//  ASFiltersViewController.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASFiltersViewController.h"

/* filter cell types */
#import "ASFilterMultiSelectTableViewCell.h"

@interface ASFiltersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterList;


@end

@implementation ASFiltersViewController

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
    NSLog(@"huh?");
    
    self.filterList.dataSource = self;
    self.filterList.delegate = self;
    
    
    
    /* we need this for our custom filter cells*/
    /* segmented */
    UINib *filterMultiSelectCellNib = [UINib nibWithNibName:@"ASFilterMultiSelectTableViewCell" bundle:nil];
    [self.filterList registerNib:filterMultiSelectCellNib forCellReuseIdentifier:@"ASFilterMultiSelectTableViewCell"];
    /* toggle */
    UINib *toggleMultiSelectCellNib = [UINib nibWithNibName:@"ASFilterToggleTableViewCell" bundle:nil];
    [self.filterList registerNib:toggleMultiSelectCellNib forCellReuseIdentifier:@"ASFilterToggleTableViewCell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitable methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"row in section for %i", section);
    if (section == 0){
        return 1;
    }else if (section == 1){
        return 4;
    }else if (section == 2){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"dequeue cell");
    if (indexPath.section == 0){
        return [tableView dequeueReusableCellWithIdentifier:@"ASFilterMultiSelectTableViewCell" forIndexPath:indexPath];
    }
    return [tableView dequeueReusableCellWithIdentifier:@"ASFilterToggleTableViewCell" forIndexPath:indexPath];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"title for section: %i", section);
    if (section == 0){
        return @"Price";
    }else if (section == 1){
        return @"Most Popular";
    }else if (section == 2){
        return @"Distance";
    }
    return @"Sort by";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

@end
