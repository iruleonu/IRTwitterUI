//
//  IRTwitterButton.m
//  IRTwitterUI
//
//  Created by Nuno Salvador on 06/09/15.
//  Copyright (c) 2015 Nuno Salvador. All rights reserved.
//

#import "IRTwitterButton.h"

@implementation IRTwitterButton

- (void)awakeFromNib
{
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor colorWithRed:85.0/255.0 green:172.0/255.0 blue:238.0/255.0 alpha:1.0].CGColor;
}

@end
