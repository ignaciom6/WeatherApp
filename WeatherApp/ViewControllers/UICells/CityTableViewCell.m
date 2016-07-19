//
//  CityTableViewCell.m
//  WeatherApp
//
//  Created by Ignacio on 18/7/16.
//  Copyright © 2016 Ignacio. All rights reserved.
//

#import "CityTableViewCell.h"

@interface CityTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIconImage;

@end

@implementation CityTableViewCell

static NSString * const kImageExtension = @".png";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCityNameWhithName:(NSString *)name
{
    self.cityNameLabel.text = name;
}

-(void)setWeatherDescriptionWithDescription:(NSString *)description
{
    self.weatherDescriptionLabel.text = description;
}

-(void)setWeatherIconWithIconID:(NSString *)iconID
{
    NSString * imageName = [iconID stringByAppendingString:kImageExtension];
    
    if (imageName)
    {
        self.weatherIconImage.image = [UIImage imageNamed:imageName];
    }
}

@end
