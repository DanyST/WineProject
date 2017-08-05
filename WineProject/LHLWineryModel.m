//
//  LHLWineryModel.m
//  WineProject
//
//  Created by Macbook Air on 21-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

#import "LHLWineryModel.h"

@interface LHLWineryModel ()

@property (strong, nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;

@end

@implementation LHLWineryModel

#pragma mark - properties custom setters
-(NSUInteger) redWineCount {
    return [self.redWines count];
}

-(NSUInteger) whiteWineCount {
    return [self.whiteWines count];
}

-(NSUInteger) otherWineCount {
    return [self.otherWines count];
}

#pragma mark - inits
-(id) init{
    if (self = [super init]){
        
        NSError *error;
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        NSURL *urlCache = [[fm URLsForDirectory:NSCachesDirectory
                                     inDomains:NSUserDomainMask] firstObject];
        
        urlCache = [urlCache URLByAppendingPathComponent:@"wines.json"];
        
        //Extraer datos json de cache
        NSData *data = [NSData dataWithContentsOfURL:urlCache
                                             options:kNilOptions
                                               error:&error];
        
        //Si no hay datos en cache, descargarlos del webService
        if (data == nil) {
          //  NSLog(@"No hubo datos en cache");
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://static.keepcoding.io/baccus/wines.json"]
                                         options:kNilOptions                                                    error:&error];
            
            //Guardar en cache
            [data writeToURL:urlCache atomically:YES];
        }else{
          //  NSLog(@"Hay datos en cache");
        }
        
        
        if (data != nil) {
            //No hubo error
            NSArray *JSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions                                                                    error:&error];
            
            if (JSONObject != nil) {
                //No hubo error
                for (NSDictionary *dict in JSONObject) {
                    LHLWineModel *wine = [LHLWineModel wineWithDictionary:dict];
                    
                    //Añadimos cada objeto de tipo LHLWineModel(vino) al array adecuado de la bodega de vinos.
                    if ([wine.type isEqualToString:RED_WINE_KEY]) {
                        if (!self.redWines) {
                            self.redWines = [NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.redWines addObject:wine];
                        }
                    }else if ([wine.type isEqualToString:WHITE_WINE_KEY]){
                        if(!self.whiteWines){
                            self.whiteWines = [NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.whiteWines addObject:wine];
                        }
                    }else if ([wine.type isEqualToString:OTHER_WINE_KEY]){
                        if (!self.otherWines) {
                            self.otherWines = [NSMutableArray arrayWithObject:wine];
                        }else{
                            [self.otherWines addObject:wine];
                        }
                    }
                }
                
            }else{
                NSLog(@"Ha habido un error desde JSON a objeto Cocoa: %@", error.localizedDescription);
            }
        }else{
            NSLog(@"Ha habido un error con la descarga de datos: %@", error.localizedDescription);
        }
        
        
        
        
    }
    return self;
}

#pragma mark - instance methods
-(LHLWineModel *)redWineAtIndex: (NSInteger) index{
    return [self.redWines objectAtIndex:index];
}

-(LHLWineModel *)whiteWineAtIndex: (NSInteger) index{
    return [self.whiteWines objectAtIndex:index];
}

-(LHLWineModel *)otherWineAtIndex: (NSInteger) index{
    return [self.otherWines objectAtIndex:index];
}




@end
