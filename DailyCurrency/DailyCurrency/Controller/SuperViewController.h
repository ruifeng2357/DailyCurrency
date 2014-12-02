//
//  SuperViewController.h
//  HaiYouWang
//
//  Created by KimHakMin on 12/13/13.
//  Copyright (c) 2013 KimHakMin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Common.h"
#import "CommManager.h"

@interface SuperViewController : UIViewController<CommDelegate>


- (void)startProgress;
- (void)stopProgress;

- (void)showAlert:(NSString*)msg;


@end




