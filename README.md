![](./Script/DDFlexboxView.xctemplate/TemplateIcon.png)

# DDFlexbox

A flexbox framework for easy using.

# Install

```
pod 'DDFlexbox'
```

# Template install

Recommend using templates to create flexbox views.

```sh
cd Script/
sh install.sh
```

# Getting start

An UITableViewCell layout likes:

```swift
flexbox.row.padding(10).alignItems(.center).setup({ (b) in
    b.bindView(myImageView).width(40).height(40)
    b.blocker(width: 10)
    b.column.flexGrow(1).flexShrink(1).setup { (b) in
        b.bindView(myTextLabel)
        b.bindView(myDetailTextLabel)
    }
})
```

# Debug

```swift
FlexboxDebugEnable = true
```

# Feature

1. Easy to use. It more simple than AutoLayout.
2. Work well with AutoLayout.
3. Manage by node tree, not view tree. So you do not need concern `addSubview` and the view hierarchy.
4. Virtual node to reduce the deep of view tree.