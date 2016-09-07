import UIKit

public struct TabbyBarItem {

  public var controller: UIViewController
  public var image: UIImage?

  public init(controller: UIViewController, image: UIImage?) {
    self.controller = controller
    self.image = image
  }
}
