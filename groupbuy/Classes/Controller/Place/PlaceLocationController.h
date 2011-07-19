//
//  PlaceLocationController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PPViewController.h"
#import "PPImageView.h"

@interface PlaceLocationController : PPViewController {
    MKMapView               *mapView;
    CLLocationCoordinate2D  location;
    PPImageView             *marker;
}

@property (nonatomic, retain) IBOutlet MKMapView        *mapView;
@property (nonatomic, retain) IBOutlet PPImageView      *marker;
@property (nonatomic, assign) CLLocationCoordinate2D    location;

- (void)finishSelectLocation:(id)sender;

@end
