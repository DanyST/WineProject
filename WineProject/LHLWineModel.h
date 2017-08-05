//
//  WineModel.h
//  WineProject
//
//  Created by Macbook Air on 08-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

@import Foundation;
@import UIKit;

#define NO_RATING -1

@interface LHLWineModel : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *wineCompanyName;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *origin;
@property (strong, nonatomic) NSURL *wineCompanyWeb;
@property (strong, nonatomic, readonly) UIImage * photo;
@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSArray *grapes;
@property (nonatomic) int rating;
@property (copy, nonatomic) NSString *notes;

// Metodos de clases
+(id) wineWithDictionary: (NSDictionary *)aDict;

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
          typeWine: (NSString *) aTypeWine
            origin: (NSString *) aOrigin
    wineCompanyWeb: (NSURL *) aURL
          photoURL: (NSURL *) aPhotoURL
            grapes: (NSArray *) anGrapes
            rating: (int) aRating
             notes: (NSString *)aNote;


+(id) wineWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineCompanyName
          typeWine: (NSString *) aTypeWine
            origin:(NSString *)aOrigin;

// inicializador designado
-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
          typeWine: (NSString *) aTypeWine
            origin: (NSString *) aOrigin
    wineCompanyWeb: (NSURL *) aURL
          photoURL: (NSURL *) aPhotoURL
            grapes: (NSArray *) anGrapes
            rating: (int) aRating
             notes: (NSString *)aNote;

// inicializadores de conveniencia
-(id) initWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineCompanyName
          typeWine:(NSString *)aTypeWine
            origin:(NSString *)aOrigin;


-(id)initWithDictionary: (NSDictionary *)aDict;
@end
