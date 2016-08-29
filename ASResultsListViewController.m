//
//  ASResultsListViewController.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/20/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASResultsListViewController.h"
#import "ASResultListTableCell.h"
#import "ASBusiness.h"
#import "ASYelpClient.h"
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "ASFiltersViewController.h"
#import "ASFilterSection.h"
#import "ASFilter.h"



static NSInteger businessNameWidth = 166;
static NSInteger businessAddressWidth = 216;
static NSInteger businessCategoriesWidth = 216;
static NSInteger businessNameVerticalWidth = 468;
static NSInteger businessAddressVerticalWidth = 468;
static NSInteger businessCategoriesVerticalWidth = 468;

static NSInteger businessLabelMaxHeight = 200;
static NSInteger defaultRowHeight = 85 - 20 - 16 - 16;


NSString * const kYelpConsumerKey = @"xxxxxxx";
NSString * const kYelpConsumerSecret = @"xxxxxxx";
NSString * const kYelpToken = @"xxxxxxx";
NSString * const kYelpTokenSecret = @"xxxxxxxY";

@interface ASResultsListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *resultsList;

@property (nonatomic, strong) ASYelpClient *client;
@property (nonatomic, strong) NSMutableArray *businesses;

@property (nonatomic, strong) NSDictionary *nameAttributes;
@property (nonatomic, strong) NSDictionary *otherAttributes;


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (assign, nonatomic) NSString *searchKey;
- (IBAction)filterButtonAction:(id)sender;


@property (strong, nonatomic) NSArray *filterSections;

@end

@implementation ASResultsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.client = [[ASYelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        self.nameAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil];
        self.otherAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
        self.filterSections = [self.client getFilterSections];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.resultsList.hidden = true;

    self.businesses = [[NSMutableArray alloc] init];
    self.searchKey = @"Thai";
   
    self.searchBar.delegate = self;
    
    
    [self loadData];
    
    // Do any additional setup after loading the view from its nib.
    self.resultsList.dataSource = self;
    self.resultsList.delegate = self;
    
    /* we need this for our custom cell*/
    UINib *resultListCellNib = [UINib nibWithNibName:@"ASResultListTableCell" bundle:nil];
    [self.resultsList registerNib:resultListCellNib forCellReuseIdentifier:@"ASResultListTableCell"];
    
    
    
   
    
    
    
    }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASResultListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASResultListTableCell" forIndexPath:indexPath];
            [cell setBusinessToCell:self.businesses[indexPath.row]  withIndex:indexPath.row+1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.businesses.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ASBusiness *currBusiness = self.businesses[indexPath.row];
    
    NSInteger nameWidth = UIDeviceOrientationIsLandscape(self.interfaceOrientation) ? businessNameVerticalWidth : businessNameWidth;
    
    NSInteger addressWidth = UIDeviceOrientationIsLandscape(self.interfaceOrientation) ? businessAddressVerticalWidth : businessAddressWidth;
    
    NSInteger categoryWidth = UIDeviceOrientationIsLandscape(self.interfaceOrientation) ? businessCategoriesVerticalWidth : businessCategoriesWidth;
    
    NSInteger businessNameHeight = [[ASResultListTableCell renderBusinessName:currBusiness.name withIndex:indexPath.row+1]
 boundingRectWithSize:CGSizeMake(nameWidth, businessLabelMaxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.nameAttributes context:nil].size.height;
    
    
    NSInteger businessAddressHeight = [currBusiness.address boundingRectWithSize:CGSizeMake(addressWidth, businessLabelMaxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.otherAttributes context:nil].size.height;
    NSInteger businessCategoriesHeight = [[currBusiness getCategoriesString] boundingRectWithSize:CGSizeMake(categoryWidth, businessLabelMaxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.otherAttributes context:nil].size.height;
    
    
    return businessNameHeight + 7 + businessAddressHeight + 3 + businessCategoriesHeight + 3 + defaultRowHeight;
}




#pragma mark - filter

- (IBAction)filterButtonAction:(id)sender {
    
    ASFiltersViewController *vc = [[ASFiltersViewController alloc] initWithNibName:@"ASFiltersViewController" bundle:nil];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
   
    vc.filterSectionsList = self.filterSections;
    vc.delegate = self;

    [self presentViewController:vc animated:YES completion: nil];
    
    
}

#pragma mark - search



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   
    [searchBar resignFirstResponder];
    
    self.searchKey = searchBar.text;
    [self loadData];
}

#pragma ASFiltersViewController

- (void)addItemViewController:(ASFiltersViewController *)controller didChangeFilters:(NSArray *)filterSectionList {
    //self.filterSections = filterSectionList;
    [self loadData];
}

#pragma mark - private

- (void)loadData
{
    [SVProgressHUD show];
     [self.client searchWithTerm:self.searchKey filters:self.filterSections success:^(AFHTTPRequestOperation *operation, id response) {
    
         [self.businesses removeAllObjects];
         
         for(NSDictionary *business in [response objectForKey:@"businesses"]){
             
             [self.businesses addObject:[[ASBusiness alloc] initWithBusinessData:business]];
             
         }
         [self.resultsList reloadData];
         self.resultsList.hidden = false;
         [SVProgressHUD dismiss];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"error: %@", [error description]);
         self.resultsList.hidden = false;
         [SVProgressHUD dismiss];
     }];
    
}







@end
