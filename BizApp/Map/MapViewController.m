//
//  MapViewController.m
//  BizApp
//
//  Created by Charles Nebo on 26/10/14.
//  Copyright (c) 2014 charles Nebo. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()


@end

@implementation MapViewController




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
    _mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)zoomIn:(id)sender
{
    MKUserLocation *userLocation = self.mapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(
                                                                   userLocation.location.coordinate, 20000,20000);
    [self.mapView setRegion:region animated:NO];
    
}

- (IBAction)changeMapType:(UITextField *)sender

{
    
    if (self.mapView.mapType == MKMapTypeStandard)
        self.mapView.mapType = MKMapTypeSatellite;
    else
        self.mapView.mapType = MKMapTypeStandard;
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    mapView.centerCoordinate = userLocation.location.coordinate;
}

- (IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self performSearch];
}

- (void) performSearch
{
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.searchText.text;
    request.region = self.mapView.region;
    
    self.matchingItems = [[NSMutableArray alloc] init];
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
     {
         if (response.mapItems.count == 0)
             
             NSLog(@"No Matches");
         else
             for (MKMapItem *item in response.mapItems)
             {
                 [_matchingItems addObject:item];
                 MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
                 annotation.coordinate = item.placemark.coordinate;
                 annotation.title = item.name;
                 [self.mapView addAnnotation:annotation];
                 
                 
                 
             }
         
     }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Source Controller = %@", [segue sourceViewController]);
    NSLog(@"Destination Controller = %@", [segue destinationViewController]);
    NSLog(@" segue identifier = %@", [segue identifier]);
    
    if ([segue.identifier isEqualToString:@"SegueMap"])
    {
        MapViewController *detailVC = [segue destinationViewController];
        detailVC.mapItems = self.matchingItems;
        
    }
    
    
}

@end







