//
//  CitiesTableViewController.m
//  WeatherApp
//
//  Created by Ignacio on 18/7/16.
//  Copyright © 2016 Ignacio. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "ConnectionManager.h"
#import "CityTableViewCell.h"

@interface CitiesTableViewController () <WeatherNotifierDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDictionary * citiesResponseDictionary;
@property (strong, nonatomic) NSArray * citiesArray;

@end

@implementation CitiesTableViewController

static const NSInteger kCellHeight = 60;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ConnectionManager sharedInstance] setNewDelegate:self];
    [[ConnectionManager sharedInstance] requestCities];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.citiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    
    [cell setCityNameWhithName:[[self.citiesArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    NSArray * weather = [[self.citiesArray objectAtIndex:indexPath.row] objectForKey:@"weather"];
    
    [cell setWeatherDescriptionWithDescription:[self obtainDescriptionFromArray:weather]];
    [cell setWeatherIconWithIconID:[self obtainIconFromArray:weather]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

-(NSString *)obtainDescriptionFromArray: (NSArray*) weatherArray
{
    NSString * description = [[NSString alloc] init];
    
    for(NSDictionary * info in weatherArray)
    {
        description = [info objectForKey:@"description"];
    }
    
    return description;
}

-(NSString *)obtainIconFromArray: (NSArray*) weatherArray
{
    NSString * iconID = [[NSString alloc] init];
    
    for(NSDictionary * info in weatherArray)
    {
        iconID = [info objectForKey:@"icon"];
    }
    
    return iconID;
}

#pragma mark - Notifications

-(void)notifyRequestSuccessWithDictionary:(NSDictionary *)dictionaryOfCities
{
    self.citiesResponseDictionary = dictionaryOfCities;
    NSMutableArray * data = [[NSMutableArray alloc] init];
    
    for(NSDictionary * city in self.citiesResponseDictionary)
    {
        [data addObject:city];
    }
    
    self.citiesArray = data;
    
    [self.tableView reloadData];
}

-(void)notifyRequestErrorWithError:(NSError *)error
{
    [self.refreshControl endRefreshing];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:@"Error retrieving weather"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:okButton];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
