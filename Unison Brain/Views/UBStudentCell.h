//
//  UBStudentCell.h
//  unison
//
//  Created by Amy Piller on 9/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWTagList.h"
#import "UBStudent.h"


@interface UBStudentCell : UITableViewCell

@property (nonatomic) UBStudent *student;
@property (nonatomic, readonly) DWTagList *tagList;
@property (nonatomic, readonly) UILabel *name;
@property (nonatomic, readonly) UILabel *section;




- (id)initWithReuseIdentifier:(NSString *)identifier;

@end
