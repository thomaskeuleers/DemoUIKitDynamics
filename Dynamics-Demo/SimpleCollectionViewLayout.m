//
//  SimpleCollectionViewLayout.m
//  Dynamics-Demo
//
//  Created by Thomas Keuleers on 19/09/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import "SimpleCollectionViewLayout.h"

#define ITEM_HEIGHT 220
#define ITEM_WIDTH 220

@implementation SimpleCollectionViewLayout

- (id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 30.0;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [super layoutAttributesForItemAtIndexPath:indexPath];
    return attrs;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
