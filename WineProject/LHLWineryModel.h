//
//  LHLWineryModel.h
//  WineProject
//
//  Created by Macbook Air on 21-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

@import Foundation;
#import "LHLWineModel.h"

#define RED_WINE_KEY   @"Tinto"
#define WHITE_WINE_KEY @"Blanco"
#define OTHER_WINE_KEY @"Rosado"

@interface LHLWineryModel : NSObject

@property (readonly, nonatomic) NSUInteger redWineCount;
@property (readonly, nonatomic) NSUInteger whiteWineCount;
@property (readonly, nonatomic) NSUInteger otherWineCount;

-(LHLWineModel *)redWineAtIndex: (NSInteger) index;

-(LHLWineModel *)whiteWineAtIndex: (NSInteger) index;

-(LHLWineModel *)otherWineAtIndex: (NSInteger) index;

@end
