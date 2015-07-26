//
//  HATLinkTextView.h
//  athomeplease
//
//  Created by Hatuyuki4 on 2015/01/27.
//  Copyright (c) 2015年 Hatuyuki4. All rights reserved.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

#import <UIKit/UIKit.h>

@interface HATLinkTextView : UITextView

typedef void(^linkHandler)(void);

@property (nonatomic,readonly)NSMutableArray *links;

- (void)addLinkWithRange:(NSRange)range linkColor:(UIColor*)color addBorder:(BOOL)addBorder handler:(linkHandler)handler;
- (void)addLinkWithRange:(NSRange)range linkFont:(UIFont*)font linkColor:(UIColor*)color addBorder:(BOOL)addBorder handler:(linkHandler)handler;
- (void)addLinkWithRange:(NSRange)range attributes:(NSDictionary*)attributes handler:(linkHandler)handler;
- (void)removeAllLink;


@end
