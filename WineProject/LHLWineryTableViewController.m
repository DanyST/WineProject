//
//  LHLWineryTableViewController.m
//  WineProject
//
//  Created by Luis Herrera on 22-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

#import "LHLWineryTableViewController.h"
#import "LHLWineViewController.h"

@interface LHLWineryTableViewController ()

@end

@implementation LHLWineryTableViewController

-(id) initWithModel: (LHLWineryModel *) aModel
              style: (UITableViewStyle) aStyle{
    
    if(self = [super initWithStyle:aStyle]){
        _model = aModel;
        self.title = @"Wine Project";
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName = nil;
    
    if (section == RED_WINE_SECTION){
        sectionName = @"Red Wines";
    }else if (section == WHITE_WINE_SECTION){
        sectionName = @"White Wines";
    }else{
        sectionName = @"Other wines";
    }
    return sectionName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    
    if (section == RED_WINE_SECTION) {
        count = self.model.redWineCount;
    }else if (section == WHITE_WINE_SECTION){
        count = self.model.whiteWineCount;
    }else {
        count = self.model.otherWineCount;
    }
    
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    //Creamos la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil){
        // la creamos de cero
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Averiguar de que modelo (vino) nos estan hablando
    LHLWineModel *wine = [self wineForIndexPath:indexPath];
    
    // sincronizamos celda (vista) y modelo (vino)
    cell.imageView.image = wine.photo;
    cell.textLabel.text = wine.name;
    cell.detailTextLabel.text = wine.wineCompanyName;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // averiguamos de que vino se trata
    LHLWineModel *wine = [self wineForIndexPath:indexPath];
    
    //avisar al delegado
    [self.delegate wineryTableViewController:self didSelectedWine:wine];
    
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //Enviar notificación
        NSNotification *n = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
                                                          object:self
                                                        userInfo:@{KEY_WINE: wine}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
        
        //Guardar el ultimo vino seleccionado
        [self saveLastSelectedWineAtSection:indexPath.section
                                     AndRow:indexPath.row];

    }
    // creamos un controllador para dicho vino
    //LHLWineViewController *wineVC = [[LHLWineViewController alloc]initWithModel:wine];
    
    // hacemos push al navigation controller dentro del cual estamos
    //[self.navigationController pushViewController:wineVC
    //                                     animated:YES];
}

#pragma mark - WineryTableViewControllerDelegate
-(void)wineryTableViewController:(LHLWineryTableViewController *)wineryVC
                 didSelectedWine:(LHLWineModel *)aWine{
    LHLWineViewController *wineVC = [[LHLWineViewController alloc]initWithModel:aWine];
    
    [self.navigationController pushViewController:wineVC animated:YES];
}

#pragma mark - Utils

-(LHLWineModel *)wineForIndexPath: (NSIndexPath *)indexPath{
    
    //Averiguamos de que vino se trata
    LHLWineModel *wine = nil;
    
    if (indexPath.section == RED_WINE_SECTION){
        wine = [self.model redWineAtIndex:indexPath.row];
    }else if (indexPath.section == WHITE_WINE_SECTION){
        wine = [self.model whiteWineAtIndex:indexPath.row];
    }else{
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    return wine;
}

#pragma mark - Persistencia con NSUserDefaults

-(NSDictionary *)setDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Por defecto, mostraremos el primero de los tintos.
    NSDictionary *coordsDefault = @{SECTION_KEY: @(RED_WINE_SECTION), ROW_KEY: @0};
    
    //Lo asignamos
    [defaults setObject:coordsDefault forKey:LAST_WINE_KEY];
    
    //Guardamos
    [defaults synchronize];
    
    return coordsDefault;
}

-(void)saveLastSelectedWineAtSection: (NSUInteger)section AndRow:(NSUInteger)row{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{SECTION_KEY: @(section), ROW_KEY: @(row)} forKey:LAST_WINE_KEY];
    [defaults synchronize];
}

-(LHLWineModel *)lastWineSelected{
    
    NSIndexPath *indexPath = nil;
    NSDictionary *coords= nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY];
    
    if (coords == nil) {
        // No hay nada bajo la clave LAST_WINE_KEY.
        // Esto quiere decir que es la primera vez que se llama a la App
        // Ponemos un valor por defecto: el primero de los tintos
        coords = [self setDefaults];
    }
    
    //Transformamos esas coordenadas en un indexpath.
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey:ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey:SECTION_KEY] integerValue]];
    
    //Devolvemos el vino en cuestión.
    return [self wineForIndexPath:indexPath];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
