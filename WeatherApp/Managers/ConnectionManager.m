//
//  ConnectionManager.m
//  WeatherApp
//
//  Created by Ignacio on 18/7/16.
//  Copyright © 2016 Ignacio. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFNetworking.h"

@interface ConnectionManager()

@property (nonatomic, strong) NSMutableDictionary * citiesDictionary;

@end

static NSString * const kBaseUrl = @"http://api.openweathermap.org/data/2.5/group?id=2643743,2988507,3128760,4219762,2950159,3117735,2759794,5815135,524901,4176380&units=metric&appid=07ee4f5e922183c2c49256d3e5011b4e";

//static NSString * const kBaseUrl = @"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=07ee4f5e922183c2c49256d3e5011b4e";

@implementation ConnectionManager

+ (id)sharedInstance {
    static ConnectionManager *sharedConnectionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedConnectionManager = [[self alloc] init];
    });
    return sharedConnectionManager;
}

- (id)init {
    if (self = [super init])
    {
        _citiesDictionary = nil;
    }
    return self;
}

- (void) setNewDelegate:(id)newDelegate
{
    self.delegate = newDelegate;
}

- (void)requestCities
{
    NSURL *url = [NSURL URLWithString:kBaseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url.absoluteString parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
             NSLog(@"JSON: %@", responseObject);
             
             self.citiesDictionary = [responseObject objectForKey:@"list"];
             
             if (self.delegate && [self.delegate respondsToSelector:@selector(notifyRequestSuccessWithDictionary:)])
             {
                 [self.delegate notifyRequestSuccessWithDictionary:self.citiesDictionary];
             }
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             
             if (self.delegate && [self.delegate respondsToSelector:@selector(notifyRequestErrorWithError:)])
             {
                 [self.delegate notifyRequestErrorWithError:error];
             }
             
         }];
    
}


@end
