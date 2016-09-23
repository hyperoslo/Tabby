import UIKit

/// Collection of behaviors within the app.
public struct Behavior {

  /// Label visibility behavior.
  public enum Label {
    case visible, invisible, activeVisible
  }

  /// Selected behavior.
  public enum Selection {
    case systematic, custom
  }
}
