//
//  DSViewController.m
//  WildKingdom
//
//  Created by Dan Szeezil on 3/30/14.
//  Copyright (c) 2014 Dan Szeezil. All rights reserved.
//

#import "DSViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoCell.h"



@interface DSViewController () <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSMutableDictionary *searchResults;
@property (strong, nonatomic) NSMutableArray *searches;
@property (strong, nonatomic) Flickr *flickr;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end



@implementation DSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
    
    UIImage *navBarImage = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(27, 27, 27, 27)];
    [self.toolbar setBackgroundImage:navBarImage forToolbarPosition:UIToolbarPositionAny
                          barMetrics:UIBarMetricsDefault];
    
    UIImage *shareButtonImage = [[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.shareButton setBackgroundImage:shareButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *textFieldImage = [[UIImage imageNamed:@"search_field.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.textField setBackground:textFieldImage];
    
    self.searches = [NSMutableArray new];
    
    self.searchResults = [[NSMutableDictionary alloc] init];
    
    self.flickr = [[Flickr alloc] init];
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    
}


-(IBAction)shareButtonTapped:(id)sender
{
    
    
}


#pragma mark - UITextFieldDelegate methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    // 1
    [self.flickr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {
            // 2
            if(![self.searches containsObject:searchTerm]) {
                NSLog(@"Found %d photos matching %@", [results count],searchTerm);
                [self.searches insertObject:searchTerm atIndex:0];
                self.searchResults[searchTerm] = results; }
            // 3
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        } else { // 1
            NSLog(@"Error searching Flickr: %@", error.localizedDescription);
        } }];
    [textField resignFirstResponder];
    return YES; 
}


#pragma mark UICollectionView Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *searchTerm = self.searches[section];
    return [self.searchResults[searchTerm] count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.searches.count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FlickrPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    
    NSString *searchTerm = self.searches[indexPath.section];
    cell.photo = self.searchResults[searchTerm][indexPath.row];
    return cell;

}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    return [[UICollectionReusableView alloc] init];
//    
//}


#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *searchTerm = self.searches[indexPath.section];
    FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
    
    CGSize retval = photo.thumbnail.size.width >0 ? photo.thumbnail.size : CGSizeMake(80, 80);
    retval.height += 25;
    retval.width += 25;
    return retval;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(20, 10, 20, 10);
    
}





@end










