//
//  ASFiltersViewController.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASFiltersViewController.h"
#import "ASFilterSection.h"
#import "ASFilter.h"

/* filter cell types */
#import "ASFilterToggleTableViewCell.h"
#import "ASFilterExpandableTableViewCell.h"

@interface ASFiltersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterList;

@property (nonatomic, assign) BOOL distanceExpanded;
@property (nonatomic, assign) BOOL sortByExpanded;
@property (nonatomic, assign) BOOL generalExpanded;



- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)searchButtonAction:(id)sender;

@end

@implementation ASFiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.distanceExpanded = false;
        self.sortByExpanded = false;
        self.generalExpanded = false;
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
    
    [self.filterList reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitable methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ASFilterSection *filterSection = self.filterSectionsList[section];
    
    if (section == 0 ||
        (section == 1 && self.distanceExpanded) ||
        (section == 2 && self.sortByExpanded) ||
        (section == 3 && self.generalExpanded)){
        return [NSArray arrayWithArray:filterSection.filterList].count;
    }else if (section == 3){
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASFilterSection *filterSection = self.filterSectionsList[indexPath.section];
    
    if (indexPath.section == 0 ||
        (indexPath.section == 3 && self.generalExpanded) ||
        (indexPath.section == 3 && !self.generalExpanded && indexPath.row < 3)){
        ASFilterToggleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASFilterToggleTableViewCell" forIndexPath:indexPath];
        [cell setFilterObj:filterSection.filterList[indexPath.row]];
        
        [self clearRoundingEffect:cell];
        if (1  == [NSArray arrayWithArray: filterSection.filterList].count){
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 5.0;
        }else if (indexPath.row == 0 || indexPath.row == [NSArray arrayWithArray: filterSection.filterList].count-1){
            [self applyRoundingEffect:cell first:(indexPath.row == 0)];
        }
        
        
        return cell;

    }
    
    ASFilterExpandableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASFilterExpandableTableViewCell" forIndexPath:indexPath];
    [cell setFilterObj:filterSection.filterList[indexPath.row]];
    
    [self clearRoundingEffect:cell];
    
    if ((indexPath.section == 1 && self.distanceExpanded) ||
    (indexPath.section == 2 && self.sortByExpanded) ||
    (indexPath.section == 3 && self.generalExpanded)){
        [cell setExpanded:true];
        
        if (1  == [NSArray arrayWithArray: filterSection.filterList].count-1){
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 5.0;
        }else if (indexPath.row == 0 ){
            [self applyRoundingEffect:cell first:true];
        }else if (indexPath.row == [NSArray arrayWithArray: filterSection.filterList].count-1){
            [self applyRoundingEffect:cell first:false];
        }
        
    }else{
        [cell setExpanded:false];
        NSString *properLabel = @"";
        for(ASFilter *filter in filterSection.filterList){
            if (filter.state){
                properLabel = filter.name;
                
            }
        }
        cell.filterNameLabel.text = properLabel;
        if (indexPath.section != 3){
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 5.0;
        } else if (indexPath.section == 3){
            if (indexPath.row == 0 ){
                [self applyRoundingEffect:cell first:true];
            }else if (indexPath.row == 3){
                [self applyRoundingEffect:cell first:false];
            }
        }
    }
    
    
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ASFilterSection *filterSection = self.filterSectionsList[section];
    return filterSection.name;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.filterSectionsList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ASFilterSection *filterSection = _filterSectionsList[indexPath.section];
    
    if (indexPath.section > 0){
        NSInteger currentCount = [NSArray arrayWithArray:filterSection.filterList].count;
        bool expand = false;
        NSInteger currentRowCount = 1;
        
        
        if (indexPath.section == 1){
            self.distanceExpanded = !self.distanceExpanded;
            expand = self.distanceExpanded;
        }else if (indexPath.section == 2){
            self.sortByExpanded = !self.sortByExpanded;
            expand = self.sortByExpanded;
        }else if (indexPath.section == 3){
            self.generalExpanded = true;
            expand = true;
            currentRowCount = 4;
        }
        
        if (expand){
            
            
            
            NSMutableArray *indexPaths = [NSMutableArray array];
            
            for (int i = 0; i < currentCount-currentRowCount; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:currentRowCount+i inSection:indexPath.section]];
            }
            
            [self.filterList insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            
        }else{
            

            
            NSMutableArray *indexPaths = [NSMutableArray array];
            
            for (int i = 0; i < currentCount-1; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:1+i inSection:indexPath.section]];
            }
            ASFilter *tmp=[filterSection.filterList objectAtIndex:indexPath.row];
            for(ASFilter *disableFilter in filterSection.filterList){
                
                disableFilter.state = false;
                
            }
            
            [self.filterList deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            
        }
        
        
    }
    ASFilter *currFilter = filterSection.filterList[indexPath.row];
       currFilter.state = true;
    
    
    [self.filterList deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


#pragma mark private




-(void) applyRoundingEffect:(UITableViewCell *)cell first:(BOOL)first {
    if (first){
        /* from http://stackoverflow.com/questions/19910361/uitextfield-with-corner-radius-only-on-top-or-bottom */
        UIBezierPath *maskPathWithRadiusTop = [UIBezierPath bezierPathWithRoundedRect:cell.layer.bounds
                                                                    byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                                          cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = cell.layer.bounds;
        maskLayer.path = maskPathWithRadiusTop.CGPath;
        
        [cell.layer setMask:maskLayer];
    }else {
        
        UIBezierPath *maskPathWithRadiusBottom = [UIBezierPath bezierPathWithRoundedRect:cell.layer.bounds
                                                                       byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                                             cornerRadii:CGSizeMake(5.0, 5.0)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = cell.layer.bounds;
        maskLayer.path = maskPathWithRadiusBottom.CGPath;
        
        [cell.layer setMask:maskLayer];
        
    }

}

-(void) clearRoundingEffect:(UITableViewCell *)cell {
    [cell.layer setMask:nil];
    cell.layer.masksToBounds = NO;
    cell.layer.cornerRadius = 0;

    
}



- (IBAction)cancelButtonAction:(id)sender {
   
    [self goBack];
}

- (IBAction)searchButtonAction:(id)sender {
    
    [self goBack];
}

-(void) goBack {
    
    [self.delegate addItemViewController:self didChangeFilters:self.filterSectionsList];
    
    [self dismissViewControllerAnimated:YES completion: nil];
}
@end
