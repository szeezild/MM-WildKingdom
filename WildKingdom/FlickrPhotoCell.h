//
//  FlickrPhotoCell.h
//  WildKingdom
//
//  Created by Dan Szeezil on 3/30/14.
//  Copyright (c) 2014 Dan Szeezil. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class FlickrPhoto;

@interface FlickrPhotoCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) FlickrPhoto *photo;


@end
