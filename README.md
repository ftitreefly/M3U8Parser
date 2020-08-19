# iOSCheatSheet

```objective-c

// Search Bar TextField

if (@available(iOS 13.0, *)) 
  self.searchBar.searchTextField.backgroundColor =  UIColor.black4Color;
  self.searchBar.searchTextField.layer.cornerRadius = 8;
  self.searchBar.searchTextField.layer.borderWidth = 1;
  self.searchBar.searchTextField.layer.borderColor = UIColor.black5Color.CGColor;
  self.searchBar.searchTextField.textColor = UIColor.veryLightPinkColor;
  self.searchBar.searchTextField.font = UIFont.textStyle21Font;
} else {
  // Fallback on earlier versions
  UIView *subviews = [self.searchBar.subviews lastObject];
  UITextField *textView = (id)[subviews.subviews objectAtIndex:1];
  textView.backgroundColor =  UIColor.black4Color;
  textView.layer.cornerRadius = 8;
  textView.layer.borderWidth = 1;
  textView.layer.borderColor = UIColor.black5Color.CGColor;
  textView.textColor = UIColor.veryLightPinkColor;
  textView.font = UIFont.textStyle21Font;
}
```
