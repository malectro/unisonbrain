//
//  UBStudentCell.m
//  unison
//
//  Created by Amy Piller on 9/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentCell.h"

@implementation UBStudentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _name = [[UILabel alloc] init];
        _section = [[UILabel alloc] init];
        _tagList = [[DWTagList alloc] init];
        _tagSession = [[DWTagList alloc] init];
        
        
        [self addSubview:_name];
        [self addSubview:_section];
        [self addSubview:_tagList];
        [self addSubview:_tagSession];
        
        
        //[self.tagList setTags:[[_breach.codes allObjects] valueForKey:@"name"]];

        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    _name.frame = CGRectMake(10.0f, 10.0f, 180.0f, 20.0f);
    _section.frame = CGRectMake(_name.frame.size.width + 10.0f, 10.0f, 45.0f, 20.0f);
    _tagList.frame = CGRectMake(_name.frame.size.width + _section.frame.size.width + 10.0f, 10.0f, 160.0f, 20.0f);
    _tagSession.frame = CGRectMake(_name.frame.size.width + _section.frame.size.width + _tagList.frame.size.width + 10.0f, 10.f, 100.0f, 20.0f);
    
    _name.font = [UIFont boldSystemFontOfSize:14.0f];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
