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

static NSInteger businessNameWidth = 166;
static NSInteger businessAddressHeight = 216;
static NSInteger businessCategoriesHeight = 216;
static NSInteger businessLabelMaxHeight = 200;
static NSInteger defaultRowHeight = 97 - 20 - 16 - 16;

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ASResultsListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *resultsList;

@property (nonatomic, strong) ASBusiness *business;
@property (nonatomic, assign) NSInteger businessNameHeight;
@property (nonatomic, assign) NSInteger businessAddressHeight;
@property (nonatomic, assign) NSInteger businessCategoriesHeight;

@property (nonatomic, strong) ASYelpClient *client;
@property (nonatomic, strong) NSMutableArray *businesses;


@end

@implementation ASResultsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Yelp";
        
        self.client = [[ASYelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"setup table stuff");
    
    
    /* fake data */
    self.business = [[ASBusiness alloc] init];
    //self.business.name = @"Basil Thai Restaurant & Bar";
    self.business.name = @"Grand Pu Bah";
    self.business.distance = 0.07;
    self.business.price = 2;
    self.business.reviewCount = 687;
    self.business.address = @"88 Division Street, Mission Bay";
    //self.business.address = @"88 Division Street, Mission Bay, San Francisco, California";
    self.business.categories = @[@"Thai", @"Seafood", @"Salad"];
    //self.business.categories = @[@"Thai", @"Seafood", @"Salad", @"Pizza", @"Sushi", @"Italian", @"French", @"Fast Food"];
    /* fake data */
    
    /* when i load the data, i could precomute the sring heights */
    self.businessNameHeight = [self.business.name boundingRectWithSize:CGSizeMake(businessNameWidth, businessLabelMaxHeight) options:NSStringDrawingUsesDeviceMetrics attributes:nil context:nil].size.height;
    self.businessAddressHeight = [self.business.address boundingRectWithSize:CGSizeMake(businessAddressHeight, businessLabelMaxHeight) options:NSStringDrawingUsesDeviceMetrics attributes:nil context:nil].size.height;
    self.businessCategoriesHeight = [[self.business getCategoriesString] boundingRectWithSize:CGSizeMake(businessCategoriesHeight, businessLabelMaxHeight) options:NSStringDrawingUsesDeviceMetrics attributes:nil context:nil].size.height;
    
    self.businesses = [[NSMutableArray alloc] init];
    
    [self loadData];

    
    // Do any additional setup after loading the view from its nib.
    self.resultsList.dataSource = self;
    self.resultsList.delegate = self;
    
    NSLog(@"read from nib");
    
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
    NSLog(@"%i", self.businessNameHeight);
    return self.businessNameHeight + 7 + self.businessAddressHeight + 3 + self.businessCategoriesHeight + 3 + defaultRowHeight;
}

#pragma mark - private

- (void)loadData
{
    
     [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
    
         
         for(NSDictionary *business in [response objectForKey:@"businesses"]){
             ASBusiness *parsedBusiness = [[ASBusiness alloc] init];
             
             parsedBusiness.name = [business objectForKey:@"name"];
             parsedBusiness.reviewCount = [[business objectForKey:@"reviewCount"] integerValue];
             
             
             
             [self.businesses addObject:parsedBusiness];
             
             [self.resultsList reloadData];
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"error: %@", [error description]);
     }];
    
}


@end
