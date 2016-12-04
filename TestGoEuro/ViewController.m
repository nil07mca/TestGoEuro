//
//  ViewController.m
//  TestGoEuro
//
//  Created by Macbook on 04/12/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "ViewController.h"
#import "ConnectionManager.h"
#import "JovisTopTabBar.h"
#import "SearchData.h"
#import "ResultCell.h"


@interface ViewController () <JovisTopTabBarDelegate>
@property (strong, nonatomic) JovisTopTabBar *tabBar;
@property (strong, nonatomic) NSArray *arrResults;
@property (weak, nonatomic) IBOutlet UITableView *tblResult;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCustomTabBar];
    // Do any additional setup after loading the view, typically from a nib.
    [_tblResult registerNib:[UINib nibWithNibName:@"ResultCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ResultCell"];
    [[ConnectionManager sharedManager] loadTrainsWithSuccessHandler:^(NSArray *results) {
        _arrResults = results;
        [_tblResult reloadData];
    } andFailureHandler:^(NSError *error) {
        ;
    }];
}

- (void)setUpCustomTabBar {
    if (_tabBar) {
        [_tabBar removeFromSuperview];
        _tabBar = nil;
        return;
    }
    _tabBar = [[JovisTopTabBar alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    [self.view addSubview:_tabBar];
    [_tabBar setBackgroundColor:[UIColor colorWithRed:15/255.0 green:97/255.0 blue:163/255.0 alpha:1.0]];
    [_tabBar setTitleArray:[NSMutableArray arrayWithArray:@[@"Train",@"Bus",@"Flight"]]];
    [_tabBar setIndicatorLineHeight:3.0];
    [_tabBar setIndicatorLineColor:[UIColor colorWithRed:252/255.0 green:156/255.0 blue:63/255.0 alpha:1.0]];
    [_tabBar setTitleFont:[UIFont systemFontOfSize:15]];
    UIColor *tc = [UIColor whiteColor];
    [_tabBar setTitleColorForSelected:tc];
    [_tabBar setTitleColorForNormal:tc];
    [_tabBar setDelegate:self];
    [_tabBar initializeUI];
    
    [_tabBar selectTabWithIndex:0];
}

#pragma mark - Custom tab bar delegate
- (void)topTabBar:(JovisTopTabBar *)topTabBar didSelectTabIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [[ConnectionManager sharedManager] loadTrainsWithSuccessHandler:^(NSArray *results) {
                _arrResults = results;
                [_tblResult reloadData];
            } andFailureHandler:^(NSError *error) {
                ;
            }];
        }
            break;
        case 1:
        {
            [[ConnectionManager sharedManager] loadBusesWithSuccessHandler:^(NSArray *results) {
                _arrResults = results;
                [_tblResult reloadData];
            } andFailureHandler:^(NSError *error) {
                ;
            }];
        }
            break;
        case 2:
        {
            [[ConnectionManager sharedManager] loadFlightsWithSuccessHandler:^(NSArray *results) {
                _arrResults = results;
                [_tblResult reloadData];
            } andFailureHandler:^(NSError *error) {
                ;
            }];                   }
            break;
            
        default:
            break;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    do more stuff here
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // only want one section to display data in this case
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ResultCell";
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell = [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (ResultCell *) configureCell:(ResultCell *)cell forIndexPath:(NSIndexPath*)indexPath {
    SearchData *result = [_arrResults objectAtIndex:indexPath.row];
    cell.lblPrice.text = [NSString stringWithFormat:@"€ %.2f",result.price];;
    if (result.numberOfStops>0) {
        cell.lblStops.text = [NSString stringWithFormat:@"%d Stop(s)",result.numberOfStops];
    }else{
        cell.lblStops.text = @"Direct";
    }
    cell.lblDuration.text = result.duration;
    cell.lblDeperture.text = result.departureTime;
    cell.lblArrival.text = result.arrivalTime;
    
    cell.imgLogo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:result.providerLogo]]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
