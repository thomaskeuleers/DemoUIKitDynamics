//
//  SimpleCollectionViewController.h
//  Dynamics-Demo
//
//  Created by Thomas Keuleers on 19/09/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCollectionViewController : UIViewController<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


- (IBAction)switchLayoutButtonTapped:(id)sender;
@end
