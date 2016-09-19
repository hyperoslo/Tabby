import UIKit

extension UIView {

  func prepareShadow(_ color: UIColor = Constant.Color.shadow, height: CGFloat = -5) {
    layer.shadowColor = color.cgColor
    layer.shadowOffset = CGSize(width: 0, height: height)
    layer.shadowRadius = abs(height)
    layer.shadowOpacity = 1
  }
}
