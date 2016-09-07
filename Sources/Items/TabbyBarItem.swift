import UIKit

public struct TabbyBarItem {

  public var controller: UIViewController
  public var image: UIImage?
  public var animation: TabbyAnimation.Kind = Constant.Animation.initial

  public init(controller: UIViewController, image: UIImage?) {
    self.controller = controller
    self.image = image
  }
}
