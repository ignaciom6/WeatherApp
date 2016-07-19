//
//  CityTableViewCell.h
//  WeatherApp
//
//  Created by Ignacio on 18/7/16.
//  Copyright © 2016 Ignacio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell

-(void)setCityNameWhithName:(NSString *)name;
-(void)setWeatherDescriptionWithDescription:(NSString *)description;
-(void)setWeatherIconWithIconID:(NSString *)iconID;

@end
