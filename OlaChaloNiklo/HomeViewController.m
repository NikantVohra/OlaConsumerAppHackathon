//
//  HomeViewController.m
//  OlaChaloNiklo
//
//  Created by Vohra, Nikant on 07/02/15.
//  Copyright (c) 2015 Vohra, Nikant. All rights reserved.
//

#import "HomeViewController.h"
#import "SCUI.h"


@interface HomeViewController()
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property BOOL menuOpened;
@property (weak, nonatomic) IBOutlet UIButton *soundCloudButton;
@property (weak, nonatomic) IBOutlet UIImageView *soundCloundIcon;

@end



@implementation HomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.soundCloudButton.hidden = YES;
    self.soundCloundIcon.hidden = YES;
    self.menuOpened = false;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (IBAction)menuButton:(id)sender {
    self.homeImageView.image = [UIImage imageNamed:@"menuImage"];
    self.soundCloudButton.hidden = NO;
    self.soundCloundIcon.hidden = NO;
    NSLog(@"menu button pressed");
}

- (IBAction)connectWithSoundcloud:(id)sender {
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Canceled!");
        } else if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            NSLog(@"Done!");
            SCAccount *account = [SCSoundCloud account];
            [self.soundCloudButton setTitle:@"SOUNDCLOUD CONNECTED" forState:UIControlStateNormal];
            self.soundCloudButton.enabled = NO;
            NSLog(@"%@",[SCSoundCloud account]);
        }
    };
    
    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
        SCLoginViewController *loginViewController;
        
        loginViewController = [SCLoginViewController
                               loginViewControllerWithPreparedURL:preparedURL
                               completionHandler:handler];
        [self presentModalViewController:loginViewController animated:YES];
    }];
}






@end
