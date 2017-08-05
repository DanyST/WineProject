//
//  LHLWineViewController.h
//  WineProject
//
//  Created by Macbook Air on 07-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

@import UIKit;
#import "LHLWineryTableViewController.h"

@class LHLWineModel;

@interface LHLWineViewController : UIViewController <UISplitViewControllerDelegate, WineryTableViewControllerDelegate>

@property (strong, nonatomic) LHLWineModel* model;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *wineCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *grapes;
@property (weak, nonatomic) IBOutlet UILabel *notes;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *origin;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews;


-(id) initWithModel: (LHLWineModel *)aModel;

-(IBAction)displayWeb:(id)sender;
@end
