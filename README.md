# Tabby

`// TODO: Add the image here.`

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

**Tabby** is the ultimate tab bar, a full substitution for those UITabBarControllers, UITabBars and UITabBarItems that are not customizable at all. **Tabby** has animations, behaviors and it has the easiness you would expect from any of our libraries.

`// TODO: Add a gif here.`

## Usage

**Tabby** begins with a controller, the called `TabbyController`. That one has an initializer taking `TabbyBarItems`. Each item has a `controller`, an `image` and an `animation` that defaults to a constant.

Once you have created the array of items, you can initialize the `TabbyController` like so:

```swift
let items = [
TabbyBarItem(controller: firstController, image: UIImage(named: "first")),
TabbyBarItem(controller: secondController, image: UIImage(named: "second"))
]
```

```swift
let controller = TabbyController(items: items)
```

#### Customization

As stated before, there are lots of customization points in **Tabby**, you can find the [constants](https://github.com/hyperoslo/Tabby/blob/master/Sources/Library/Constant.swift#L3) file with fonts, colors and animations.

A part from the typical constants, you'll be able to change the translucency, the indicator or the separator between the tab and the controller, with the possibility to add a shadow if you want.

```swift
controller.translucent = true
controller.showSeparator = false
controller.showIndicator = false
```

##### Behaviors

**Tabby** is built upon behaviors. As soon as we add more customization points within the source code, constants will emerge that will let you control more parts of the insights of **Tabby**. As for now, the first behavior dictates weather the title should be displayed, displayed only in the selected one, or not displayed at all.

To change that, you just set:

`Tabby.Constant.Behavior.labelVisibility = .ActiveVisible`

#### Animations

There are lots of default [animations](https://github.com/hyperoslo/Tabby/blob/master/Sources/Animations/TabbyAnimation.swift#L5) that you can use. We'll be adding more and more of those.

The default animations are:

```swift
Pop, Flip, Morph, Shake, Swing, PushUp, PushDown, None
```

#### Delegates

As for now, there is one delegate method that informs you which button was just pressed. This will let you rebuild the tab bar, reload it, add different items, etc.

```swift
func tabbyButtonDidPress(index: Int)
```

Be sure to check our [demo](https://github.com/hyperoslo/Tabby/tree/master/Demo/TabbyDemo) if you have any further questions! :)

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

Made by Hyper Oslo. Contact us at ios@hyper.no.

## Contributing

We would love you to contribute to **Tabby**, check the [CONTRIBUTING](https://github.com/hyperoslo/Tabby/blob/master/CONTRIBUTING.md) file for more info.

## License

**Tabby** is available under the MIT license. See the [LICENSE](https://github.com/hyperoslo/Tabby/blob/master/LICENSE.md) file for more info.
