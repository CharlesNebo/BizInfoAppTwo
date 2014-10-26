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
    // Do any additional setup after loading the view.
    
    _myMapView.showsUserLocation = YES;
     self.myMapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)zoomClicked:(id)sender
{
    MKUserLocation *userLocation = self.myMapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(
    userLocation.location.coordinate, 20000,20000);
    
    [self.myMapView setRegion:region animated:NO];
}

- (IBAction)mapTypeClicked:(id)sender

{
    if (self.myMapView.mapType == MKMapTypeStandard)
        self.myMapView.mapType = MKMapTypeSatellite;
    else
        self.myMapView.mapType = MKMapTypeStandard;

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    mapView.centerCoordinate = userLocation.location.coordinate;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end







