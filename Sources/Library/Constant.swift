import UIKit

public struct Constant {

  /// This is the font that will be displayed in the tab bar. For your controller's title.
  public struct Font {
    /// The font of the title.
    public static var title = UIFont.systemFont(ofSize: 9)
    /// The font of the badge.
    public static var badge = UIFont.boldSystemFont(ofSize: 9)
  }

  /// This represents multiple colors of the tab bar.
  public struct Color {
    /// The background of the tab bar.
    public static var background = UIColor.black

    /// The color of the disabled icon, the icon that is not tapped.
    public static var disabled = UIColor.lightGray

    /// The color of the enabled state.
    public static var enabled = UIColor.white

    /// The color of the selected state.
    public static var selected = UIColor.white

    /// The color of the separator between the tab bar and the controller.
    public static var separator = UIColor.lightGray

    /// The color of the collection view.
    public static var collection = UIColor.clear

    /// The color of the indicator in the tab bar.
    public static var indicator = Color.selected

    /// The color of the shadow that will substitute the indicator.
    public static var shadow = UIColor.black.withAlphaComponent(0.1)

    public struct Badge {
      /// The color of the badge.
      public static var background = UIColor.red

      /// The color of the border of the badge.
      public static var border = UIColor.white

      /// The color of the text of the badge.
      public static var text = UIColor.white
    }
  }

  /// The dimensions of the tab bar.
  public struct Dimension {
    /// The height of the tab bar.
    public static var height: CGFloat = 50

    /// The dimensions of the icons inside the tab bar.
    public struct Icon {

      /// The width of the icon of the tab bar.
      public static var width: CGFloat = 30

      /// The height of the icon of the tab bar.
      public static var height: CGFloat = 22.5
    }

    /// This represents the dimensions of the indicator.
    public struct Indicator {
      /// The width of the indicator.
      public static var width: CGFloat = 25

      /// The height of the indicator.
      public static var height: CGFloat = 3
    }

    /// This represents the dimensions of the separator.
    public struct Separator {
      /// The height of the separator.
      public static var height: CGFloat = 0.25
    }

    /// This represents the badge size constants.
    public struct Badge {
      /// The size of the badge.
      public static var size: CGFloat = 18

      /// The size of the border radius.
      public static var border: CGFloat = 1.5
    }
  }

  /// The default animation the tab bar will have.
  public struct Animation {
    /// The initial animation the tab bar will have.
    public static var initial: TabbyAnimation.Kind = .pop
  }

  /// Different kinds of behaviors for the tab bar.
  public struct Behavior {
    /// Label visibility behavior.
    public static var labelVisibility: Tabby.Behavior.Label = .invisible
  }
}
