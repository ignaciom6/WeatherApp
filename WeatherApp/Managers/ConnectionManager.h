//
//  ConnectionManager.h
//  WeatherApp
//
//  Created by Ignacio on 18/7/16.
//  Copyright © 2016 Ignacio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeatherNotifierDelegate <NSObject>

-(void)notifyRequestSuccessWithDictionary:(NSDictionary *)dictionaryOfCities;
-(void)notifyRequestErrorWithError:(NSError *)error;

@end


@interface ConnectionManager : NSObject

@property (strong, nonatomic) id<WeatherNotifierDelegate> delegate;

+(id)sharedInstance;
-(void)setNewDelegate:(id)newDelegate;
-(void)requestCities;

@end
