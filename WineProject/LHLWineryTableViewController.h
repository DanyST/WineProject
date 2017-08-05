//
//  LHLWineryTableViewController.h
//  WineProject
//
//  Created by Luis Herrera on 22-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

@import UIKit;

#import "LHLWineryModel.h"

#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

#define NEW_WINE_NOTIFICATION_NAME @"newWine"
#define KEY_WINE @"wine"

#define SECTION_KEY @"section"
#define ROW_KEY @"row"
#define LAST_WINE_KEY @"lastWine"

@class LHLWineryTableViewController;

@protocol WineryTableViewControllerDelegate <NSObject>

-(void) wineryTableViewController: (LHLWineryTableViewController *)wineryVC
              didSelectedWine: (LHLWineModel *)aWine;

@end

@interface LHLWineryTableViewController : UITableViewController <WineryTableViewControllerDelegate>

@property (nonatomic, strong) LHLWineryModel *model;
@property (nonatomic, weak) id<WineryTableViewControllerDelegate> delegate;

-(id) initWithModel: (LHLWineryModel *) aModel
              style: (UITableViewStyle) aStyle;

-(LHLWineModel *)lastWineSelected;
@end

