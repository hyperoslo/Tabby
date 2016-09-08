import UIKit

public struct Constant {

  /**
   This is the font that will be displayed in the tab bar. For your controller's title.
   */
  public struct Font {
    /**
     The title of the font.
     */
    public static var title = UIFont.systemFontOfSize(9)
  }

  /**
   This represents multiple colors of the tab bar.
   */
  public struct Color {
    /**
     The background of the tab bar.
     */
    public static var background = UIColor.blackColor()

    /**
     The color of the disabled icon, the icon that is not tapped.
     */
    public static var disabled = UIColor.lightGrayColor()

    /**
     The color of the enabled state.
     */
    public static var enabled = UIColor.whiteColor()

    /**
     The color of the selected state.
     */
    public static var selected = UIColor.whiteColor()

    /**
     The color of the separator between the tab bar and the controller.
     */
    public static var separator = UIColor.lightGrayColor()

    /**
     The color of the collection view.
     */
    public static var collection = UIColor.clearColor()

    /**
     The color of the indicator in the tab bar.
     */
    public static var indicator = Color.selected

    /**
     The color of the shadow that will substitute the indicator.
     */
    public static var shadow = UIColor.blackColor().colorWithAlphaComponent(0.1)
  }

  /**
   The dimensions of the tab bar.
   */
  public struct Dimension {
    /**
     The height of the tab bar.
     */
    public static var height: CGFloat = 50

    /**
     The dimensions of the icons inside the tab bar.
     */
    public struct Icon {

      /**
       The width of the icon of the tab bar.
       */
      public static var width: CGFloat = 22.5

      /**
       The height of the icon of the tab bar.
       */
      public static var height: CGFloat = Dimension.Icon.width
    }

    /**
     This represents the dimensions of the indicator.
     */
    public struct Indicator {
      /**
       The width of the indicator.
       */
      public static var width: CGFloat = 25

      /**
       The height of the indicator.
       */
      public static var height: CGFloat = 3
    }

    /**
     This represents the dimensions of the separator.
     */
    public struct Separator {
      /**
       The height of the separator.
       */
      public static var height: CGFloat = 0.25
    }
  }

  /**
   The default animation the tab bar will have.
   */
  public struct Animation {
    /**
     The initial animation the tab bar will have.
     */
    public static var initial: TabbyAnimation.Kind = .Pop
  }
}
