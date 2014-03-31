//
//  FlickrPhotoCell.m
//  WildKingdom
//
//  Created by Dan Szeezil on 3/30/14.
//  Copyright (c) 2014 Dan Szeezil. All rights reserved.
//

#import "FlickrPhotoCell.h"
#import "flickrPhoto.h"

@implementation FlickrPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setPhoto:(FlickrPhoto *)photo {
    
    if (_photo != photo) {
        _photo = photo;
    }
    self.imageView.image = _photo.thumbnail;
}


@end
