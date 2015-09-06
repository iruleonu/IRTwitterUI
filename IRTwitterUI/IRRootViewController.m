//
//  IRRootViewController.m
//  IRTwitterUI
//
//  Created by Nuno Salvador on 06/09/15.
//  Copyright (c) 2015 Nuno Salvador. All rights reserved.
//

#import "IRRootViewController.h"
#import "IRTwitterButton.h"
#import "IRAvatarImageView.h"

@interface IRRootViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet IRAvatarImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameTwitterLabel;
@property (weak, nonatomic) IBOutlet IRTwitterButton *followButton;
@property (weak, nonatomic) IBOutlet UIImageView *refreshIconImageView;
@property (weak, nonatomic) IBOutlet UIView *sizerView;
@end

@implementation IRRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
