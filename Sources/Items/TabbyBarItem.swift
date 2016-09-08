import UIKit

public struct TabbyBarItem: Equatable {

  public var controller: UIViewController
  public var image: UIImage?
  public var animation: TabbyAnimation.Kind

  public init(controller: UIViewController, image: UIImage?, animation: TabbyAnimation.Kind = Constant.Animation.initial) {
    self.controller = controller
    self.image = image
    self.animation = animation
  }
}

public func ==(lhs: TabbyBarItem, rhs: TabbyBarItem) -> Bool {
  return lhs.controller == rhs.controller
    && lhs.image == rhs.image
    && lhs.animation == rhs.animation
}
