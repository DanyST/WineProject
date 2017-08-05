//
//  AppDelegate.m
//  WineProject
//
//  Created by Macbook Air on 07-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

#import "AppDelegate.h"
#import "LHLWineViewController.h"
#import "LHLWebViewController.h"
#import "LHLWineModel.h"
#import "LHLWineryModel.h"
#import "LHLWineryTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
    
- (void)customizeAppearance{
    UINavigationBar.appearance.barTintColor = [UIColor colorWithRed:0.5
                                                              green:0
                                                               blue:0.13
                                                              alpha:1];
    
    UINavigationBar.appearance.tintColor = [UIColor colorWithWhite:1
                                                             alpha:1];
    
    UINavigationBar.appearance.barStyle = UIStatusBarStyleLightContent;
}
    
-(UIViewController *)rootViewControllerForPadWithModel: (LHLWineryModel *)aModel{
    
    //creamos los controladores
    LHLWineryTableViewController *wineryVC = [[LHLWineryTableViewController alloc] initWithModel:aModel
                                                                                           style:UITableViewStylePlain];
    
    LHLWineViewController *wineVC = [[LHLWineViewController alloc] initWithModel:[wineryVC lastWineSelected]];
    
    //creamos los navigations controllers
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    UINavigationController *wineNav = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    //creamos el conbinador: UISplitViewController
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[wineryNav, wineNav];
    
    //asignamos delegados
    splitVC.delegate = wineVC;
    wineryVC.delegate = wineVC;
    
    return splitVC;

}

-(UIViewController *)rootViewControllerForPhoneWithModel: (LHLWineryModel *)aModel{
    //controlador
    LHLWineryTableViewController *wineryVC = [[LHLWineryTableViewController alloc] initWithModel:aModel
                                                                                           style:UITableViewStylePlain];
    //conbinador
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    
    //delegado
    wineryVC.delegate = wineryVC;
    
    return wineryNav;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // aplicamos diseño con el patron proxy appearance
    [self customizeAppearance];
    
    // creamos el modelo
    LHLWineryModel *model = [[LHLWineryModel alloc] init];
    
    //Configuramos controladores, conbinadores y delegados según
    //el tipo de dispositivo
    UIViewController *rootVC = nil;
    
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //tambien se puede con este metodo: UI_USER_INTERFACE_IDIOM()
        //iPad
        rootVC = [self rootViewControllerForPadWithModel:model];
    }else if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        //iPhone
        rootVC = [self rootViewControllerForPhoneWithModel:model];
    }
    
    // Le asignamos un controlador de inicio
    self.window.rootViewController = rootVC;
   // self.window.backgroundColor = [UIColor redColor];
    [[self window] makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
