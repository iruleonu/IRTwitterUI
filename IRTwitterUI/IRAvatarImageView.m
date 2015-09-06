//
//  IRAvatarImageView.m
//  IRTwitterUI
//
//  Created by Nuno Salvador on 06/09/15.
//  Copyright (c) 2015 Nuno Salvador. All rights reserved.
//

#import "IRAvatarImageView.h"

@implementation IRAvatarImageView

- (void)awakeFromNib
{
    self.layer.cornerRadius = 10.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 3.0;
}

@end
