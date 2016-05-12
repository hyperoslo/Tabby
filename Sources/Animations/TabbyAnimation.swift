import UIKit
import Morgan
import Walker

public struct TabbyAnimation {

  public enum Kind {
    case Pop, Flip, Morph, Shake, Swing, PushUp, PushDown, None
  }

  public static func animate(view: UIView, kind: Kind) {
    switch kind {
    case .Pop:
      UIView.animateWithDuration(0.1, animations: {
        view.transform = CGAffineTransformMakeScale(0.8, 0.8)
        }, completion: { _ in
          UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0, options: [.CurveEaseInOut], animations: {
            view.transform = CGAffineTransformIdentity
            }, completion: nil)
      })
    case .Flip:
      view.flip(0.4)
    case .Morph:
      view.morph(0.075)
    case .Swing:
      view.swing(0.075)
    case .PushUp:
      view.pushUp()
    case .PushDown:
      view.pushDown()
    case .Shake:
      let duration = 0.075
      let x: CGFloat = 10
      let y: CGFloat = 0

      Walker.animate(view, duration: duration) {
        $0.transform = CGAffineTransformMakeTranslation(-x, -y)
      }.chain(duration: duration) {
        $0.transform = CGAffineTransformMakeTranslation(x, y)
      }.chain(duration: duration) {
        $0.transform = CGAffineTransformMakeTranslation(-x / 2, -y / 2)
      }.chain(duration: duration) {
        $0.transform = CGAffineTransformIdentity
      }
    case .None:
      break
    }
  }
}
