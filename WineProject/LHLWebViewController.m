//
//  WebViewController.m
//  WineProject
//
//  Created by Macbook Air on 15-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

#import "LHLWebViewController.h"
#import "LHLWineryTableViewController.h"



@implementation LHLWebViewController

#pragma mark - init
-(id)initWithModel: (LHLWineModel *)aModel{
    if (self = [super initWithNibName:nil
                               bundle:nil]){
        _model = aModel;
        self.title = @"Web";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self syncViewToModel];
    
    //Nos damos de alta en la notificación
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:NEW_WINE_NOTIFICATION_NAME
                 object:nil];
  }

#pragma mark - Notifications
-(void)wineDidChange: (NSNotification *)notification{
    
    NSDictionary *dict = notification.userInfo;
    
    self.model = [dict objectForKey:KEY_WINE];
    [self syncViewToModel];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //Nos damos de baja en la notificación
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Memory manager
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.indicatorView setHidden:NO];
    [self.indicatorView startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.indicatorView.hidden = YES;
    [self.indicatorView stopAnimating];

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.indicatorView.hidden = YES;
    [self.indicatorView stopAnimating];

    //Crear una alerta
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:[error localizedDescription]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    //Crear un boton de alerta
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^ (UIAlertAction * action) {
                                                              [self.navigationController popToRootViewControllerAnimated:YES];
                                                          }];
    //Añadir el boton a la alerta
    [alert addAction:defaultAction];
    
    //Mostrar la alerta
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Utils
-(void)syncViewToModel{
    
    self.title = self.model.wineCompanyName;
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.model.wineCompanyWeb]];
    
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
