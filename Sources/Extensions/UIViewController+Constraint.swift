import UIKit

extension UIView {

  func constraint(subview: UIView, attributes: NSLayoutAttribute...) {
    for attribute in attributes {
      addConstraint(NSLayoutConstraint(
        item: subview, attribute: attribute,
        relatedBy: .Equal, toItem: self,
        attribute: attribute, multiplier: 1, constant: 0)
      )
    }
  }
}
