# Tabby

// TODO: Add the image here.

<div align = "center">
<br>
<a href="https://github.com/Carthage/Carthage" target="blank"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" /></a>
<a href="http://cocoadocs.org/docsets/Tabby" target="blank"><img src="https://img.shields.io/cocoapods/v/Tabby.svg?style=flat" /></a>
<a href="http://cocoadocs.org/docsets/Tabby" target="blank"><img src="https://img.shields.io/cocoapods/l/Tabby.svg?style=flat" /></a>
<a href="http://cocoadocs.org/docsets/Tabby" target="blank"><img src="https://img.shields.io/cocoapods/p/Tabby.svg?style=flat" /></a>
<a href="http://cocoadocs.org/docsets/Tabby" target="blank"><img src="https://img.shields.io/cocoapods/metrics/doc-percent/Tabby.svg?style=flat" /></a>
<img src="https://img.shields.io/badge/%20in-swift%202.2-orange.svg" />
<br><br>
</div>

## Description

**Tabby** is the new solution for your tab bar. It's a full substitution for those UITabBarControllers, UITabBars and UITabBarItems that are not customizable at all. **Tabby** on the other hand is fully customizable and it has the easiness you would expect from any of our libraries.

## Usage

There are multiple ways to use Tabby, either you subclass it and make a controller out of it, or you create a variable of it and make it your main controller as you would for your UITabBarController.

```swift
let controller = TabbyController()
controller.controllers = [
  (self.firstNavigation, UIImage(named: "cow")),
  (self.secondController, UIImage(named: "donut")),
  (self.thirdNavigation, UIImage(named: "fish"))
]
```

And there you have it, your controller with different images set for you.

#### Customization

As stated before, there are lots of customization points in **Tabby**, you can find the [constants](https://github.com/hyperoslo/Tabby/blob/master/Sources/Library/Constant.swift#L3) file here, with fonts, colors and animations.

A part from the typical constants, you'll be able to change the translucency, the indicator and the separator between the tab and the controller, with the possibility to add a shadow if you want.

```swift
controller.translucent = true
controller.showSeparator = false
controller.showIndicator = false
controller.animations = [
  TabbyAnimation.Kind.Flip,
  TabbyAnimation.Kind.Morph,
  TabbyAnimation.Kind.Swing
]
```

#### Animations

There are lots of default [animations](https://github.com/hyperoslo/Tabby/blob/master/Sources/Animations/TabbyAnimation.swift#L5) that you can use, but if you are not satisfied with it, you have a delegate method that will inform you when the button was just tapped.

```swift
func tabbyButtonDidPress(index: Int)
```

The default animations are:

```swift
Pop, Flip, Morph, Shake, Swing, PushUp, PushDown, None
```

## Installation

**Tabby** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Tabby'
```

**Tabby** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "hyperoslo/Tabby"
```

## Author

Made by Hyper Interaktiv AS. Contact us at ios@hyper.no.

## Contributing

We would love you to contribute to **Tabby**, check the [CONTRIBUTING](https://github.com/hyperoslo/Tabby/blob/master/CONTRIBUTING.md) file for more info.

## License

**Tabby** is available under the MIT license. See the [LICENSE](https://github.com/hyperoslo/Tabby/blob/master/LICENSE.md) file for more info.
