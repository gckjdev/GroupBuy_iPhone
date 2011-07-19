//
//  CreatePlaceController.m
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011骞�__MyCompanyName__. All rights reserved.
//

#import "CreatePlaceController.h"
#import "CreatePlaceRequest.h"
#import "groupbuyAppDelegate.h"
#import "PlaceLocationController.h"
#import "PlaceManager.h"
#import "Place.h"
#import "UserManager.h"

enum
{
    ROW_NAME,
    ROW_LOCATION,
    ROW_DESC,
    ROW_COUNT
};

@implementation CreatePlaceController

@synthesize location;
@synthesize nameTextField;
@synthesize descriptionTextField;
@synthesize placeController;
@synthesize defaultPlaceName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [nameTextField release];
    [descriptionTextField release];
    [placeController release];
    [defaultPlaceName release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = NSLS(@"kCreatePlaceTitle");
    
    [super viewDidLoad];
    
    self.dataTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // Do any additional setup after loading the view from its nib.
    [self setNavigationRightButton:NSLS(@"Save") action:@selector(clickSave:)];
    [self setNavigationLeftButton:NSLS(@"Back") action:@selector(clickBack:)];
        
    //    [self initLocationManager];
}

- (void)viewDidAppear:(BOOL)animated
{
    //    hasLocationData = NO;
    //    [self startUpdatingLocation];
    
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table View Delegate

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView 
//{
//	NSMutableArray* array = [NSMutableArray arrayWithArray:[ArrayOfCharacters getArray]];
//	[array addObject:kSectionNull];
//	return array;
//	
////		NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
////		return nil;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//	return [groupData sectionForLetter:title];
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionHeader = [groupData titleForSection:section];	
	
    //	switch (section) {
    //		case <#constant#>:
    //			<#statements#>
    //			break;
    //		default:
    //			break;
    //	}
	
	return sectionHeader;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	return [self getSectionView:tableView section:section];
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//	return sectionImageHeight;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//	return [self getFooterView:tableView section:section];
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//	return footerImageHeight;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// return [self getRowHeight:indexPath.row totalRow:[dataList count]];
	// return cellImageHeight;
	
	return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;		// default implementation
	
	// return [groupData totalSectionCount];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return ROW_COUNT;			// default implementation
	
	// return [groupData numberOfRowsInSection:section];
}

- (UITableViewCell*)createNameCell:(UITableView *)theTableView
{
    static NSString *CellIdentifier = @"CellName";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];				
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGRect frame = cell.contentView.frame;
        frame.origin.y += 10;
        frame.size.width -= 20;
        UITextField* textField = [[UITextField alloc] initWithFrame:frame];
        
        
        textField.placeholder = NSLS(@"kEnterPlaceName");                
        [cell.contentView addSubview:textField];                
        [textField release];
        
        self.nameTextField = textField;
        self.nameTextField.text = defaultPlaceName;
        
        [self.nameTextField becomeFirstResponder];    
    }
    
    
    return cell;
}

- (UITableViewCell*)createLocationCell:(UITableView *)theTableView
{
    static NSString *CellIdentifier = @"CellLocation";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];				
        cell.textLabel.text = NSLS(@"kChooseLocation");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    LocationService* locationService = GlobalGetLocationService();    
    if ([locationService currentLocation] != nil){
        location = [[locationService currentLocation] coordinate];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"(%3.2f, %3.2f)",
                                     location.longitude,
                                     location.latitude];
    }
    else{
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}

- (UITableViewCell*)createDescriptionCell:(UITableView *)theTableView
{
    static NSString *CellIdentifier = @"CellDesc";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];				
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGRect frame = cell.contentView.frame;
        frame.origin.y += 10;
        frame.size.width -= 20;        
        UITextField* textField = [[UITextField alloc] initWithFrame:frame];
        
        self.descriptionTextField = textField;
        
        textField.placeholder = NSLS(@"kEnterPlaceDescription");                
        [cell.contentView addSubview:textField];                
        [textField release];
    }
    
    return cell;
}

- (UITableViewCell*)createTableViewCell:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case ROW_NAME:
            return [self createNameCell:theTableView];
            
        case ROW_LOCATION:
            return [self createLocationCell:theTableView];
            
        case ROW_DESC:
            return [self createDescriptionCell:theTableView];
            
        default:
            break;
    }
    
    return nil;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {        
        cell = [self createTableViewCell:theTableView cellForRowAtIndexPath:indexPath];
	}
	
    //	[self setCellBackground:cell row:row count:count];
	
	return cell;
	
}

- (void)selectPlaceLocation
{
    if (placeController == nil){
        self.placeController = [[PlaceLocationController alloc] init];
    }
    
    placeController.location = location;

    [self.navigationController pushViewController:placeController animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row > [dataList count] - 1)
		return;
	
	[self updateSelectSectionAndRow:indexPath];
	[self reloadForSelectSectionAndRow:indexPath];	
    
	// do select row action
	// NSObject* dataObject = [dataList objectAtIndex:indexPath.row];
    
    if (indexPath.row == ROW_LOCATION){
        [self selectPlaceLocation];
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		if (indexPath.row > [dataList count] - 1)
			return;
        
		// take delete action below, update data list
		// NSObject* dataObject = [dataList objectAtIndex:indexPath.row];		
		
		// update table view
		
	}
	
}

- (BOOL)checkName
{
    if ([nameTextField.text length] == 0){
        [self popupMessage:NSLS(@"kPlaceNameEmpty") title:NSLS(@"")];        
        return NO;
    }
    
    BOOL result = YES;
    NSString* text = nameTextField.text;
    
    NSMutableCharacterSet* charSet = [[NSMutableCharacterSet alloc] init];
    [charSet addCharactersInString:@"-_~!@#$%^&*()+=`[]\\{}|;':\",./<>?"];
    [charSet formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text rangeOfCharacterFromSet:charSet].location != NSNotFound){
        [self popupMessage:NSLS(@"kPlaceNameIncorrect") title:NSLS(@"")];
        result = NO;
    }
    [charSet release];
    return result;
}

- (void)createPlace:(NSString*)name description:(NSString*)description longitude:(double)longitude latitude:(double)latitude
{
    // TODO
    NSString* userId = [UserManager getUserId];
    NSString* appId = [AppManager getPlaceAppId];
    
    [self showActivityWithText:NSLS(@"kCreatingPlace")];
    dispatch_async(workingQueue, ^{
        
        CreatePlaceOutput* output = [CreatePlaceRequest send:SERVER_URL userId:userId appId:appId name:name description:description longtitude:longitude latitude:latitude];
        
        // For Test Only
        // output.placeId = [NSString stringWithInt:time(0)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideActivity];
            if (output.resultCode == ERROR_SUCCESS){               
                // save place data locally
                [PlaceManager createPlace:output.placeId name:name desc:description longitude:longitude latitude:latitude 
                               createUser:userId
                             followUserId:userId
                                   useFor:PLACE_USE_FOLLOW];
                
                [self.navigationController popViewControllerAnimated:YES];

            }
            else if (output.resultCode == ERROR_NETWORK){
                [UIUtils alert:NSLS(@"kSystemFailure")];
                
            }
            else{
                // other error TBD
                [UIUtils alert:NSLS(@"kUnknowFailure")];
            }
        });        
    });    
}

- (void)clickSave:(id)sender
{
    if ([self checkName] == NO){
        return;
    }
    
    LocationService* locationService = GlobalGetLocationService();
    location = [[locationService currentLocation] coordinate];
    
    [self createPlace:nameTextField.text 
          description:descriptionTextField.text 
            longitude:location.longitude 
             latitude:location.latitude];
}

///*
// * We want to get and store a location measurement that meets the desired accuracy. For this example, we are
// *      going to use horizontal accuracy as the deciding factor. In other cases, you may wish to use vertical
// *      accuracy, or both together.
// */
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//	
//    // save to current location
//    self.currentLocation = newLocation;
//	NSLog(@"Current location is %@, horizontalAccuracy=%f, timestamp=%@", [self.currentLocation description], [self.currentLocation horizontalAccuracy], [[currentLocation timestamp] description]);
//	
//	// we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
//	// [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation:) object:kTimeOutObjectString];
//	
//	// we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
//	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation:) object:kTimeOutObjectString];
//	
//	// IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
//	[self stopUpdatingLocation:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
//	
//    self.location = newLocation.coordinate;
//    [self.dataTableView reloadData];
//    
//    hasLocationData = YES;
//	// translate location to address
//	// [self reverseGeocodeCurrentLocation:self.currentLocation];
//	
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//	
//    // The location "unknown" error simply means the manager is currently unable to get the location.
//    // We can ignore this error for the scenario of getting a single location fix, because we already have a 
//    // timeout that will stop the location manager to save power.
//    if ([error code] != kCLErrorLocationUnknown) {
//        [self stopUpdatingLocation:NSLocalizedString(@"Error", @"Error")];
//    }	
//}
//
//#pragma mark reverseGeocoder
//
//- (void)reverseGeocode:(CLLocationCoordinate2D)coordinate
//{
//    self.reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
//    reverseGeocoder.delegate = self;
//    [reverseGeocoder start];
//}
//
//- (void)reverseGeocodeCurrentLocation:(CLLocation *)theLocation
//{
//    self.reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:theLocation.coordinate];
//    reverseGeocoder.delegate = self;
//    [reverseGeocoder start];
//}
//
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
//{
//    NSLog(@"MKReverseGeocoder has failed.");	
//}
//
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
//{
//	self.currentPlacemark = placemark;
//	NSLog(@"reverseGeocoder finish, placemark=%@", [placemark description] );
//	//	NSLog(@"current country is %@, province is %@, city is %@, street is %@%@", self.currentPlacemark.country, currentPlacemark.administrativeArea, currentPlacemark.locality, placemark.thoroughfare, placemark.subThoroughfare);	
//}


@end
