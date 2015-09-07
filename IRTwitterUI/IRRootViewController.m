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
#import "FXBlurView.h"
#import "UIView+Extensions.h"

static float const IROffsetHeaderStop = 40.0; // Only allow 40px of scrollview y offset before disabling the transformations
static float const IRFontInsidePadding = 4.0; // Tweak needed because of the font top padding on the label
static NSString *const IRRootViewControllerTitle = @"IRTwitterUI";
typedef void (^IRCompletionBlockType)(void);

@interface IRRootViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) UIImageView *headerBackgroundImageView;
@property (nonatomic, strong) UIImageView *headerBlurrImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet IRAvatarImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameTwitterLabel;
@property (weak, nonatomic) IBOutlet IRTwitterButton *followButton;
@property (weak, nonatomic) IBOutlet UIImageView *refreshIconImageView;
@property (weak, nonatomic) IBOutlet UIView *sizerView;
@property (nonatomic) CGFloat offsetUsernameLabel; // Used to know when the username label reaches the headerView
@property (nonatomic) CGFloat offsetHeaderLabel; // Used to know when to start to move the header label
@end

@implementation IRRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.headerBackgroundImageView = [[UIImageView alloc] initWithFrame:self.headerView.bounds];
    self.headerBackgroundImageView.image = [UIImage imageNamed:@"header_backg"];
    self.headerBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerView insertSubview:self.headerBackgroundImageView belowSubview:self.headerLabel];
    
    self.headerBlurrImageView = [[UIImageView alloc] initWithFrame:self.headerView.bounds];
    self.headerBlurrImageView.image = [[UIImage imageNamed:@"header_backg"] blurredImageWithRadius:10 iterations:20 tintColor:[UIColor clearColor]];
    self.headerBlurrImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerBlurrImageView.alpha = 0;
    [self.headerView insertSubview:self.headerBlurrImageView belowSubview:self.headerLabel];
    
    self.headerView.clipsToBounds = YES;
    
    self.offsetUsernameLabel = self.usernameLabel.frame.origin.y - self.headerView.bounds.size.height + IROffsetHeaderStop + IRFontInsidePadding;
    self.offsetHeaderLabel = IROffsetHeaderStop - IRFontInsidePadding;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = self.scrollView.contentOffset.y;
    CATransform3D avatarTransform = CATransform3DIdentity;
    CATransform3D headerTransform = CATransform3DIdentity;
    
    // Pull down: If offset is negative, it means the user is pulling down
    if(offset < 0) {
        CGFloat headerScaleFactor = -(offset) / self.headerView.bounds.size.height;
        CGFloat headerSizevariation = ((self.headerView.bounds.size.height * (1.0 + headerScaleFactor)) - self.headerView.bounds.size.height) / 2.0;
        headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0);
        headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0);
        self.headerView.layer.transform = headerTransform;
    }
    else { // Scroll up/down
        // Header view
        headerTransform = CATransform3DTranslate(headerTransform, 0, MAX(-IROffsetHeaderStop, -offset), 0);
        
        // Header white Label
        CATransform3D labelTransform = CATransform3DMakeTranslation(0, MAX(-self.offsetHeaderLabel, self.offsetUsernameLabel - offset), 0);
        self.headerLabel.layer.transform = labelTransform;
        
        // Blurr image
        self.headerBlurrImageView.alpha = MIN(1.0, (offset - self.offsetUsernameLabel)/self.offsetHeaderLabel);
        
        // Avatar
        CGFloat avatarScaleFactor = (MIN(IROffsetHeaderStop, offset)) / self.avatarImageView.bounds.size.height / 1.4; // Slow down the animation
        CGFloat avatarSizeVariation = ((self.avatarImageView.bounds.size.height * (1.0 + avatarScaleFactor)) - self.avatarImageView.bounds.size.height) / 2.0;
        avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0);
        avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0);
        
        if(offset <= IROffsetHeaderStop) {
            if(self.avatarImageView.layer.zPosition < self.headerView.layer.zPosition) {
                self.headerView.layer.zPosition = 0;
            }
        }
        else {
            if(self.avatarImageView.layer.zPosition >= self.headerView.layer.zPosition) {
                self.headerView.layer.zPosition = 2;
            }
        }
    }
    
    self.headerView.layer.transform = headerTransform;
    self.avatarImageView.layer.transform = avatarTransform;
}

@end
