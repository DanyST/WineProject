//
//  WineModel.m
//  WineProject
//
//  Created by Macbook Air on 08-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

#import "LHLWineModel.h"

@implementation LHLWineModel

// Cuando creas una propiedad de solo lectura e implementas un getter personalizado,
// como estamos haciendo con photo, el compilador da por hecho que no vas a necesitar
// una variable de instancia. En este caso no es así, y sí que neceisto la variable,
// así que hay que obligarle a que la incluya. Esto se hace con la linea de @synthesize,
// con la que le indicamos que queremos una propiedad llamada photo con una variable
// de instancia llamada _photo.
// En la inmensa mayoría de los casos, esto es opcional.
// Para más info: http://www.cocoaosx.com/2012/12/04/auto-synthesize-property-reglas-excepciones/
@synthesize photo = _photo;

-(UIImage *)photo{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *url = [[fm URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject];
    url = [url URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [self.name stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    NSData *data = nil;
    BOOL rc;
    NSError *error;
    // Esto va a bloquear y se debería de hacer en segundo plano
    // Sin embargo, aun no sabemos hacer eso, asi que de momento lo dejamos
    // Carga perezosa: solo cargo la imagen si hace falta.
    if (_photo == nil) {
        
        data = [NSData dataWithContentsOfURL:url];
        if (data) {
            _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        }else{
            NSLog(@"Descargando imagen");
            _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
            data = UIImagePNGRepresentation(_photo);
            rc = [data writeToURL:url options:NSDataWritingAtomic error:&error];
            if (rc == NO) {
                NSLog(@"Error al guardar imagen del vino %@. Error: %@",self.name, error.localizedDescription);
            }
        }
    }
    return _photo;
}


#pragma mark - constructors

+(id) wineWithDictionary: (NSDictionary *)aDict{
    return [[self alloc]initWithDictionary:aDict];
}

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
          typeWine: (NSString *) aTypeWine
            origin: (NSString *) aOrigin
    wineCompanyWeb: (NSURL *) aURL
             photoURL: (NSURL *) aPhotoURL
            grapes: (NSArray *) anGrapes
            rating: (int) aRating
             notes: (NSString *)aNote{

    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                             typeWine:aTypeWine
                               origin:aOrigin
                       wineCompanyWeb:aURL
                                photoURL:aPhotoURL
                               grapes:anGrapes
                               rating:aRating
                                notes:aNote];
}

+(id) wineWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineCompanyName
          typeWine: (NSString *) aTypeWine
            origin:(NSString *)aOrigin{


    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                             typeWine:aTypeWine
                               origin:aOrigin];
}

#pragma mark - init designed
-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
          typeWine: (NSString *) aTypeWine
            origin: (NSString *) aOrigin
    wineCompanyWeb: (NSURL *) aURL
          photoURL: (NSURL *) aPhotoURL
            grapes: (NSArray *) anGrapes
            rating: (int) aRating
             notes: (NSString *)aNote{

    
    if (self = [super init]){
        _name = aName;
        _wineCompanyName = aWineCompanyName;
        _type = aTypeWine;
        _origin = aOrigin;
        _wineCompanyWeb = aURL;
        _photoURL = aPhotoURL;
        _grapes = anGrapes;
        _rating = aRating;
        _notes = aNote;
    }
    
    return self;
}
#pragma mark - init of convenience
-(id) initWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineCompanyName
          typeWine: (NSString *) aTypeWine
            origin:(NSString *)aOrigin{

    
    return [self initWithName:aName
              wineCompanyName:aWineCompanyName
                     typeWine:aTypeWine
                       origin:aOrigin
               wineCompanyWeb:nil
                     photoURL:nil
                       grapes:nil
                       rating:NO_RATING
                        notes:nil];
    }

#pragma mark - InitWithDictionary: Convert a Dictionary extracted from JSON to wineModel object.
-(id)initWithDictionary: (NSDictionary *)aDict{
    
    return [self initWithName:[aDict objectForKey:@"name"]
              wineCompanyName:[aDict objectForKey:@"company"]
                     typeWine:[aDict objectForKey:@"type"]
                       origin:[aDict objectForKey:@"origin"]
               wineCompanyWeb:[NSURL URLWithString:[aDict objectForKey:@"company_web"]]
                     photoURL:[NSURL URLWithString:[aDict objectForKey:@"picture"]]
                       grapes:[self extractGrapesFromArrayDictionary:[aDict objectForKey:@"grapes"]]
                       rating:[[aDict objectForKey:@"rating"]intValue]
                        notes:[aDict objectForKey:@"notes"]];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"Nombre del vino: %@", self.name];
}

#pragma mark - Utils

-(NSArray *)extractGrapesFromArrayDictionary: (NSArray *)JSONArray{
    
    NSMutableArray *grapesArray;
    for (NSDictionary *dict in JSONArray) {
        [grapesArray addObject:[dict objectForKey:@"grape"]];
    }
    return grapesArray;
}
@end
