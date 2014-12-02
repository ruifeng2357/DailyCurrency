//
//  ViewController.h
//  DailyCurrency
//
//  Created by RiKS on 11/7/14.
//  Copyright (c) 2014 DMY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface MainViewController : SuperViewController
{
	NSTimer* _timer;
	BOOL bAlertPrompt;
}

@property (nonatomic, retain) IBOutlet UILabel* lblAsianDate;
@property (nonatomic, retain) IBOutlet UILabel* lblAsianUSD;
@property (nonatomic, retain) IBOutlet UILabel* lblAsianEUR;
@property (nonatomic, retain) IBOutlet UILabel* lblAsianCHF;
@property (nonatomic, retain) IBOutlet UILabel* lblAsianGBP;
@property (nonatomic, retain) IBOutlet UILabel* lblAsianJPY;
@property (nonatomic, retain) IBOutlet UILabel* lblAsianCAD;
@property (nonatomic, retain) IBOutlet UILabel* lblAsianAUD;
@property (nonatomic, retain) IBOutlet UILabel* lblAsianNZD;

@property (nonatomic, retain) IBOutlet UILabel* lblEngDate;
@property (nonatomic, retain) IBOutlet UILabel* lblEngUSD;
@property (nonatomic, retain) IBOutlet UILabel* lblEngEUR;
@property (nonatomic, retain) IBOutlet UILabel* lblEngCHF;
@property (nonatomic, retain) IBOutlet UILabel* lblEngGBP;
@property (nonatomic, retain) IBOutlet UILabel* lblEngJPY;
@property (nonatomic, retain) IBOutlet UILabel* lblEngCAD;
@property (nonatomic, retain) IBOutlet UILabel* lblEngAUD;
@property (nonatomic, retain) IBOutlet UILabel* lblEngNZD;

@property (nonatomic, retain) IBOutlet UILabel* lblUsaDate;
@property (nonatomic, retain) IBOutlet UILabel* lblUsaUSD;
@property (nonatomic, retain) IBOutlet UILabel* lblUsaEUR;
@property (nonatomic, retain) IBOutlet UILabel* lblUsaCHF;
@property (nonatomic, retain) IBOutlet UILabel* lblUsaGBP;
@property (nonatomic, retain) IBOutlet UILabel* lblUsaJPY;
@property (nonatomic, retain) IBOutlet UILabel* lblUsaCAD;
@property (nonatomic, retain) IBOutlet UILabel* lblUsaAUD;
@property (nonatomic, retain) IBOutlet UILabel* lblUsaNZD;

@end

