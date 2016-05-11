import UIKit

public struct Constant {

  public struct Font {
    public static var title = UIFont.systemFontOfSize(13)
  }

  public struct Color {
    public static var background = UIColor.blackColor()
    public static var disabled = UIColor.lightGrayColor()
    public static var enabled = UIColor.whiteColor()
    public static var selected = UIColor.whiteColor()
    public static var shadow = UIColor.blackColor()
  }

  public struct Image {
    
  }

  public struct Dimension {
    public static var width = UIScreen.mainScreen().bounds.width
    public static var height: CGFloat = 50
  }
}
