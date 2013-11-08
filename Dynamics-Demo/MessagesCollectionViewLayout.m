//
//  MessagesCollectionViewLayout.m
//  Dynamics-Demo
//
//  Created by Thomas Keuleers on 19/09/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import "MessagesCollectionViewLayout.h"
#import "SimpleCollectionViewCell.h"
#define CELL_IDENTIFIER @"SimpleCellIdentifier"


#define ITEM_HEIGHT 150
#define ITEM_WIDTH 500

@interface MessagesCollectionViewLayout ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation MessagesCollectionViewLayout


-(id)init
{
    self = [super init];
    if (self) {
        
        self.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 10.0f;
        
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    [self.collectionView registerClass:[SimpleCollectionViewCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
    
    if (!self.animator) {
        self.animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        
        CGSize contentSize = [self collectionViewContentSize];
        
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *attributes in items) {
            UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:attributes attachedToAnchor:attributes.center];
            attachmentBehavior.length = 0;
            attachmentBehavior.damping = 0.8f;
            attachmentBehavior.frequency = 0.5f;
            [self.animator addBehavior:attachmentBehavior];
        }
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *spring in self.animator.behaviors) {
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabsf(touchLocation.y - anchorPoint.y);
        
        CGFloat scrollResistance = distanceFromTouch / 500;
        
        CGPoint center = item.center;
        center.y += scrollResistance * scrollDelta;
        item.center = center;
        
        [self.animator updateItemUsingCurrentState:item];
        
    }
    
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.animator layoutAttributesForCellAtIndexPath:indexPath];
}

@end
