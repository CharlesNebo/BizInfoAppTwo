//
//  MapViewController.h
//  BizApp
//
//  Created by Charles Nebo on 26/10/14.
//  Copyright (c) 2014 charles Nebo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController <MKMapViewDelegate, MKAnnotation>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic) NSMutableArray *matchingItems;
@property (strong, nonatomic) NSArray *mapItems;




- (IBAction)textFieldReturn:(UITextField *)sender;
- (IBAction)zoomIn:(id)sender;

- (IBAction)changeMapType:(id)sender;

@end
