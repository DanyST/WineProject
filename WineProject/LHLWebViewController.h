//
//  WebViewController.h
//  WineProject
//
//  Created by Macbook Air on 15-05-17.
//  Copyright © 2017 LHL. All rights reserved.
//

@import UIKit;
#import "LHLWineModel.h"

@interface LHLWebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView * webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (strong, nonatomic) LHLWineModel *model;

-(id)initWithModel: (LHLWineModel *)aModel;
@end
