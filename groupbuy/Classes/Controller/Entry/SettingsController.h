//
//  SettingsController.h
//  groupbuy
//
//  Created by qqn_pipi on 11-8-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "CityPickerViewController.h"

@interface SettingsController : PPViewController <CityPickerDelegate> {
    
    UILabel *cityLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *cityLabel;


- (IBAction)clickSetCity:(id)sender;
@end
