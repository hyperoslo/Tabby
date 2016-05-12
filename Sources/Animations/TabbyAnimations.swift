import UIKit

public struct TabbyAnimations {

  public enum Kind {
    case Pop, None
  }

  public static func animate(view: UIView, kind: Kind) {
    switch kind {
    case .Pop:
      UIView.animateWithDuration(0.1, animations: {
        view.transform = CGAffineTransformMakeScale(0.8, 0.8)
        }, completion: { _ in
          UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0, options: [.CurveEaseInOut], animations: {
            view.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
      })
    case .None:
      break
    }
  }
}
