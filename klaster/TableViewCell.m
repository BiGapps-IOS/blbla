//
//  TableViewCell.m
//  Base64ToPsfZomm
//
//  Created by Menny Alterscu on 11/11/16.
//  Copyright © 2016 Menny Alterscu. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
