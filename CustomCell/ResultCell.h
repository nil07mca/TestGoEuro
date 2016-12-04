//
//  ResultCell.h
//  TestGoEuro
//
//  Created by Macbook on 04/12/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblStops;
@property (weak, nonatomic) IBOutlet UILabel *lblDeperture;
@property (weak, nonatomic) IBOutlet UILabel *lblArrival;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;

@end
