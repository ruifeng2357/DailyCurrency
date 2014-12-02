//
//  SuperViewController.m
//  HaiYouWang
//
//  Created by KimHakMin on 12/13/13.
//  Copyright (c) 2013 KimHakMin. All rights reserved.
//

#import "SuperViewController.h"
#import "SVProgressHUD.h"

@interface SuperViewController ()

@end



@implementation SuperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (nibNameOrNil != nil)
	{
		if ([Common getDeviceType] == DEVICE_TYPE_IPHONE4)
			nibNameOrNil = [nibNameOrNil stringByAppendingString:@"_iOS4"];
		else if ([Common getDeviceType] == DEVICE_TYPE_IPAD)
			nibNameOrNil = [nibNameOrNil stringByAppendingString:@"_iPAD"];
	}

	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

	if (self) {}

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Do any additional setup after loading the view.
}

- (void)startProgress
{
	[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
}

- (void)stopProgress
{
	[SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)showAlert:(NSString*)msg
{
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Alarm" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	[alertView show];
}

@end



