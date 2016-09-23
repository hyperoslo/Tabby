import UIKit

public struct TabbyBarItem: Equatable {

  public var controller: UIViewController
  public var image: String
  public var animation: TabbyAnimation.Kind
  public var selection: Behavior.Selection

  public init(controller: UIViewController, image: String,
              animation: TabbyAnimation.Kind = Constant.Animation.initial,
              selection: Behavior.Selection = .systematic) {

    self.controller = controller
    self.image = image
    self.animation = animation
    self.selection = selection
  }
}

public func ==(lhs: TabbyBarItem, rhs: TabbyBarItem) -> Bool {
  return lhs.controller == rhs.controller
    && lhs.image == rhs.image
    && lhs.animation == rhs.animation
}
