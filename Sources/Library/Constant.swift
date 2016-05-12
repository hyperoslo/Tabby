import UIKit

public struct Constant {

  public struct Font {
    public static var title = UIFont.systemFontOfSize(11)
  }

  public struct Color {
    public static var background = UIColor.blackColor()
    public static var disabled = UIColor.lightGrayColor()
    public static var enabled = UIColor.whiteColor()
    public static var selected = UIColor.whiteColor()
    public static var separator = UIColor.lightGrayColor()
    public static var indicator = Color.selected
    public static var shadow = UIColor.blackColor().colorWithAlphaComponent(0.1)
  }

  public struct Dimension {
    public static var width = UIScreen.mainScreen().bounds.width
    public static var height: CGFloat = 50

    public struct Indicator {
      public static var width: CGFloat = 25
      public static var height: CGFloat = 4
    }

    public struct Separator {
      public static var height: CGFloat = 0.25
    }
  }

  public struct Animation {
    public static var initial: TabbyAnimation.Kind = .Pop
  }
}
