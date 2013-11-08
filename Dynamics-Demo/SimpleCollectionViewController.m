//
//  SimpleCollectionViewController.m
//  Dynamics-Demo
//
//  Created by Thomas Keuleers on 19/09/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import "SimpleCollectionViewController.h"
#import "SimpleCollectionViewCell.h"
#import "SimpleCollectionViewLayout.h"
#import "MessagesCollectionViewLayout.h"

#define CELL_IDENTIFIER @"SimpleCellIdentifier"

@interface SimpleCollectionViewController ()

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, assign) bool isShowingMessageLayout;

@end

@implementation SimpleCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"SimpleCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:CELL_IDENTIFIER];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 200; i++) {
        NSString *string = [NSString stringWithFormat:@"String %d",i + 1];
        [array addObject:string];
    }
    
    self.array = array;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SimpleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0f green:(arc4random() % 255) / 255.0f blue:(arc4random() % 255) / 255.0f alpha:1.0f];
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

- (IBAction)switchLayoutButtonTapped:(id)sender {
    
    UICollectionViewFlowLayout *newLayout = nil;
    
    if (!self.isShowingMessageLayout) {
        newLayout = [[MessagesCollectionViewLayout alloc] init];
    } else {
        newLayout = [[SimpleCollectionViewLayout alloc] init];
    }
    
    self.isShowingMessageLayout = !self.isShowingMessageLayout;

    self.collectionView.collectionViewLayout = newLayout;
}
@end
