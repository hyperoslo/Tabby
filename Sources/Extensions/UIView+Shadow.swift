import UIKit

extension UIView {

  func prepareShadow(color: UIColor = Constant.Color.shadow, height: CGFloat = -5) {
    layer.shadowColor = UIColor.blackColor().CGColor
    layer.shadowOffset = CGSize(width: 0, height: height)
    layer.shadowRadius = abs(height)
    layer.shadowOpacity = 1
  }
}
