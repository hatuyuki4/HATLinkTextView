//
//  ViewController.m
//  HATLinkTextViewSample
//
//  Created by Hatuyuki4 on 2015/07/25.
//  Copyright (c) 2015年 Hatuyuki4. All rights reserved.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//


#import "ViewController.h"

#import "HATLinkTextView.h"


@implementation ViewController
{
    HATLinkTextView *_linkTextView;
    
    __weak IBOutlet HATLinkTextView *_storyboadTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *text = @"あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん";
    
    // ストーリーボードから作る
    // Make by storyboard
    NSLog(@"storyboardText = %@",_storyboadTextView.text);
    [_storyboadTextView addLinkWithRange:NSMakeRange(5, 5) linkColor:[UIColor blueColor] addBorder:YES handler:^{
        NSLog(@"Storyboad LinkTap!");
    }];

    /*
    // レンジがオーバーしている場合
    // Out of bounds
    [_storyboadTextView addLinkWithRange:NSMakeRange(10, 100) linkColor:[UIColor cyanColor] addBorder:YES handler:^{
        NSLog(@"Storyboad out of bounds!");
    }];
     
    // リンクがある状態からかぶせた場合
    [_storyboadTextView addLinkWithRange:NSMakeRange(15, 5) linkColor:[UIColor brownColor] addBorder:YES handler:^{
        NSLog(@"Storyboad cross over!");
    }];
    */
    
    // リンクテキスト作る
    // Make by code
    _linkTextView = [[HATLinkTextView alloc] init];
    _linkTextView.font = [UIFont systemFontOfSize:24.0f];
    _linkTextView.text = text;
    
    /*
    // リンク作る
    // Make link
    [_linkTextView addLinkWithRange:NSMakeRange(5, 5) linkColor:[UIColor blueColor] addBorder:NO handler:^{
        NSLog(@"LinkTap!");
    }];
    */
    
    // フォント指定してリンク作る
    // Make link with font
    [_linkTextView addLinkWithRange:NSMakeRange(10, 5) linkFont:[UIFont boldSystemFontOfSize:24.0f] linkColor:[UIColor magentaColor] addBorder:NO handler:^{
        NSLog(@"LinkTap With font");
    }];
    [self.view addSubview:_linkTextView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_storyboadTextView sizeToFit];
    
    // Layout link text view
    CGRect linkTextFrame;
    linkTextFrame.size = [_linkTextView sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.bounds) - 16.0, CGFLOAT_MAX)];
    linkTextFrame.origin = CGPointMake(8.0, CGRectGetMaxY(_storyboadTextView.frame) + 16.0f);
    
    _linkTextView.frame = linkTextFrame;
}

@end
