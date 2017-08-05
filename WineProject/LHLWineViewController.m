//
//  LHLWineViewController.m
//  WineProject
//
//  Created by Macbook Air on 07-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

#import "LHLWineModel.h"
#import "LHLWineViewController.h"
#import "LHLWebViewController.h"

@implementation LHLWineViewController

-(id) initWithModel: (LHLWineModel *)aModel{
    if (self = [super initWithNibName:nil
                               bundle:nil]){
        _model = aModel;
        self.title = aModel.name;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self syncModelWithView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        self.navigationItem.rightBarButtonItem = self.splitViewController.displayModeButtonItem;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Utils

-(void)syncModelWithView{
    _name.text = self.model.name;
    _wineCompanyName.text = self.model.wineCompanyName;
    _type.text = self.model.type;
    _origin.text = self.model.origin;
    _photo.image = self.model.photo;
    _notes.text = self.model.notes;
    _grapes.text = [self arrayToString:self.model.grapes];
    
    [self displayRating: self.model.rating];
    
    [self.notes setNumberOfLines:0];
}

-(void)clearRating{
    for (UIImageView *imageView in self.ratingViews) {
        [imageView setImage:nil];
    }
}


-(void)displayRating: (int) aRating{
    [self clearRating];
    
    UIImage *glass = [UIImage imageNamed:@"splitView_score_glass"];
    
    for (int i = 0; i < aRating; i++) {
        [[self.ratingViews objectAtIndex:i] setImage:glass];
    }
}

-(NSString *)arrayToString: (NSArray *) grapes{
    NSString* repl;
    if ([grapes count] ==1){
        repl = [@"100% " stringByAppendingString:[grapes lastObject]];
    }else{
        repl = [[grapes componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    return repl;
}
#pragma mark - Actions
-(IBAction)displayWeb:(id)sender{
    LHLWebViewController *webVC = [[LHLWebViewController alloc] initWithModel:self.model];

    [self.navigationController pushViewController:webVC
                                         animated:YES];
}

#pragma mark - UISplitViewControllerDelegate

-(void)splitViewController:(UISplitViewController *)svc
   willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        self.navigationItem.rightBarButtonItem = svc.displayModeButtonItem;
    }
}

#pragma mark - WineryTableViewControllerDelegate
-(void)wineryTableViewController:(LHLWineryTableViewController *)wineryVC
                 didSelectedWine:(LHLWineModel *)aWine{
    
    self.model = aWine;
    
    //Sincronizamos modelo y vista que ha sido seleccionado por WineryTableViewController
    [self syncModelWithView];
    
    self.title = aWine.name;
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
