//
//  ViewController.m
//  DailyCurrency
//
//  Created by RiKS on 11/7/14.
//  Copyright (c) 2014 DMY. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize lblAsianDate;
@synthesize lblAsianUSD;
@synthesize lblAsianEUR;
@synthesize lblAsianCHF;
@synthesize lblAsianGBP;
@synthesize lblAsianJPY;
@synthesize lblAsianCAD;
@synthesize lblAsianAUD;
@synthesize lblAsianNZD;

@synthesize lblEngDate;
@synthesize lblEngUSD;
@synthesize lblEngEUR;
@synthesize lblEngCHF;
@synthesize lblEngGBP;
@synthesize lblEngJPY;
@synthesize lblEngCAD;
@synthesize lblEngAUD;
@synthesize lblEngNZD;

@synthesize lblUsaDate;
@synthesize lblUsaUSD;
@synthesize lblUsaEUR;
@synthesize lblUsaCHF;
@synthesize lblUsaGBP;
@synthesize lblUsaJPY;
@synthesize lblUsaCAD;
@synthesize lblUsaAUD;
@synthesize lblUsaNZD;

- (id) init
{
	self = [super init];
	bAlertPrompt = NO;
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self startProgress];
	CommManager* commMgr = [CommManager getCommMgr:self];
	[commMgr getDailyCurrencyData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
	_timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
												  target: self
											selector:@selector(onTick:)
												userInfo: nil repeats:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
	[_timer invalidate];
}

-(void)onTick:(NSTimer *)timer {
	CommManager* commMgr = [CommManager getCommMgr:self];
	[commMgr getDailyCurrencyData];
}

-(void) getDailyCurrencyDataResult:(int)retcode message:(NSString *)msg retdata:(NSDictionary *)retdata
{
	[self stopProgress];
	if (retcode == 0)
	{
		if (retdata != nil)
		{
			[lblEngDate setText: [retdata objectForKey:@"curdate"]];
			[lblUsaDate setText: [retdata objectForKey:@"curdate"]];
			[lblAsianDate setText: [retdata objectForKey:@"curdate"]];
			
			NSDictionary *retAsian = [retdata objectForKey:@"asiastate"];
			if (retAsian != nil)
			{
				[lblAsianUSD setText:[retAsian objectForKey:@"usd"]];
				[lblAsianEUR setText:[retAsian objectForKey:@"eur"]];
				[lblAsianCHF setText:[retAsian objectForKey:@"chf"]];
				[lblAsianGBP setText:[retAsian objectForKey:@"gbp"]];
				[lblAsianJPY setText:[retAsian objectForKey:@"jpy"]];
				[lblAsianCAD setText:[retAsian objectForKey:@"cad"]];
				[lblAsianAUD setText:[retAsian objectForKey:@"aud"]];
				[lblAsianNZD setText:[retAsian objectForKey:@"nzd"]];
			}
			
			NSDictionary *retEng = [retdata objectForKey:@"englandstate"];
			if (retEng != nil)
			{
				[lblEngUSD setText:[retEng objectForKey:@"usd"]];
				[lblEngEUR setText:[retEng objectForKey:@"eur"]];
				[lblEngCHF setText:[retEng objectForKey:@"chf"]];
				[lblEngGBP setText:[retEng objectForKey:@"gbp"]];
				[lblEngJPY setText:[retEng objectForKey:@"jpy"]];
				[lblEngCAD setText:[retEng objectForKey:@"cad"]];
				[lblEngAUD setText:[retEng objectForKey:@"aud"]];
				[lblEngNZD setText:[retEng objectForKey:@"nzd"]];
			}
			
			NSDictionary *retUSA = [retdata objectForKey:@"unitedstate"];
			if (retUSA != nil)
			{
				[lblUsaUSD setText:[retUSA objectForKey:@"usd"]];
				[lblUsaEUR setText:[retUSA objectForKey:@"eur"]];
				[lblUsaCHF setText:[retUSA objectForKey:@"chf"]];
				[lblUsaGBP setText:[retUSA objectForKey:@"gbp"]];
				[lblUsaJPY setText:[retUSA objectForKey:@"jpy"]];
				[lblUsaCAD setText:[retUSA objectForKey:@"cad"]];
				[lblUsaAUD setText:[retUSA objectForKey:@"aud"]];
				[lblUsaNZD setText:[retUSA objectForKey:@"nzd"]];
			}
		}
	}
	else
	{
		if (bAlertPrompt == NO)
		{
			[self showAlert:msg];
			bAlertPrompt = YES;
		}
	}
	
	return;
}

@end
