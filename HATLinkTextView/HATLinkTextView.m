//
//  HATLinkTextView.m
//  athomeplease
//
//  Created by Hatuyuki4 on 2015/01/27.
//  Copyright (c) 2015年 Hatuyuki4. All rights reserved.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

#import "HATLinkTextView.h"

@implementation HATLinkTextView

- (void)setUp
{
    // Create links
    _links = [NSMutableArray array];
    
    self.scrollEnabled = NO;
    self.selectable = NO;
    self.editable = NO;
    
    // Add gesture
    UITapGestureRecognizer *tapGesture;
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self setUp];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self setUp];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (!self) {
        return nil;
    }
    
    [self setUp];
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUp];
}

//--------------------------------------------------------------//
#pragma mark -- Link --
//--------------------------------------------------------------//

- (void)addLinkWithRange:(NSRange)range linkColor:(UIColor*)color addBorder:(BOOL)addBorder handler:(linkHandler)handler
{
    [self addLinkWithRange:range linkFont:self.font linkColor:color addBorder:addBorder handler:handler];
}

- (void)addLinkWithRange:(NSRange)range linkFont:(UIFont*)font linkColor:(UIColor*)color addBorder:(BOOL)addBorder handler:(linkHandler)handler
{
    // Create attributes
    NSMutableDictionary *attributes;
    attributes = [NSMutableDictionary dictionary];
    if (color) {
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    if (addBorder) {
        [attributes setObject:@(NSUnderlineStyleSingle) forKey:NSUnderlineStyleAttributeName];
    }
    
    
    [self addLinkWithRange:range attributes:attributes handler:handler];
}

- (void)addLinkWithRange:(NSRange)range attributes:(NSDictionary*)attributes handler:(linkHandler)handler
{
    
    // Fix range
    NSRange fixRange;
    fixRange = range;
    if (self.text.length < fixRange.location) {
        // Out of bounds
        return;
    }
    else if (self.text.length < fixRange.length + fixRange.location) {
        fixRange = NSMakeRange(fixRange.location, self.text.length - fixRange.location);
    }
    
    // Replace linked attribtes
    NSMutableAttributedString *attributedString;
    
    if (self.attributedText.length > 0) {
        attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    else {
        attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    
    // Add attribute
    if (attributes != nil) {
        [attributedString addAttributes:attributes range:fixRange];
    }
    
    self.attributedText = attributedString;
    
    // Add link
    NSMutableDictionary *link;
    link = [NSMutableDictionary dictionary];
    [link setObject:[NSValue valueWithRange:range] forKey:@"range"];
    [link setObject:handler forKey:@"handler"];
    
    [_links addObject:link];
}


- (void)removeAllLink
{
    [_links removeAllObjects];
    
    // Clear attributed text
    self.text = [self.attributedText string];
}

//--------------------------------------------------------------//
#pragma mark -- Action --
//--------------------------------------------------------------//

- (void)singleTapAction:(UITapGestureRecognizer*)tapGesture
{
    CGPoint location = [tapGesture locationInView:self];
    UITextPosition *textPosition = [self closestPositionToPoint:location];
    NSInteger selectedTextPosition = [self offsetFromPosition:self.beginningOfDocument toPosition:textPosition];
    
    for (NSDictionary *linkInfo in _links) {
        NSRange range = [linkInfo[@"range"] rangeValue];
        
        if (NSLocationInRange (selectedTextPosition,range)) {
            linkHandler handler = linkInfo[@"handler"];
            if (handler) {
                handler();
            }
        }
    }
}

@end
