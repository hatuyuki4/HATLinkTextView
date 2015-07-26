HATLinkTextView
======================
HATLinkTextViewはTextViewにHTMLのようなリンクを挿入し
タップイベントを挿入するライブラリです。

### 使い方
// NSRangeでリンクの範囲を指定します。
// タップイベントのアクションはブロックに記述します。
[_linkTextView addLinkWithRange:NSMakeRange(5, 5) linkColor:[UIColor blueColor] addBorder:NO handler:^{
NSLog(@"LinkTap!");
}];

// 下線の有無、リンクの色、リンクのフォントを指定することができます。
[_linkTextView addLinkWithRange:NSMakeRange(10, 5) linkFont:[UIFont boldSystemFontOfSize:24.0f] linkColor:[UIColor magentaColor] addBorder:NO handler:^{
NSLog(@"LinkTap With font");
}];

画像
----------------
Storyboardからも使えます。  
![Storyboardからも使えます。](https://raw.githubusercontent.com/hatuyuki4/HATLinkTextView/master/images/ScreenShot_storyboard.png)

![](https://raw.githubusercontent.com/hatuyuki4/HATLinkTextView/master/images/ScreenShot.png)

ライセンス
----------
All source code is licensed under the [MIT](https://raw.githubusercontent.com/hatuyuki4/HATLinkTextView/master/LICENSE.txt).