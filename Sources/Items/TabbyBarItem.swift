import UIKit

public struct TabbyBarItem: Equatable {

  public var controller: UIViewController
  public var image: String
  public var selection: Behavior.Selection

  public init(controller: UIViewController, image: String,
              selection: Behavior.Selection = .systematic) {

    self.controller = controller
    self.image = image
    self.selection = selection
  }
}

public func ==(lhs: TabbyBarItem, rhs: TabbyBarItem) -> Bool {
  return lhs.controller == rhs.controller
    && lhs.image == rhs.image
}
