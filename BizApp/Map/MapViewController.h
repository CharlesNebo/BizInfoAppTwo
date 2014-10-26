//
//  MapViewController.h
//  BizApp
//
//  Created by Charles Nebo on 26/10/14.
//  Copyright (c) 2014 charles Nebo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

- (IBAction)zoomClicked:(id)sender;
- (IBAction)mapTypeClicked:(id)sender;

@end
