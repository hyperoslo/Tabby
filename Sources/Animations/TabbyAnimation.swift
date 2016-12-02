import UIKit
import Morgan
import Walker

/**
 TabbyAnimation is the animation creator.
 */
public struct TabbyAnimation {

  /**
   The animation that will perform in the tap for the tab bar.
   */
  public enum Kind {
    case pop, flip, morph, shake, swing, pushUp, pushDown, none
  }

  /**
   This function will animate based on the default kind from the TabbyAnimation.
   - Parameter view: The view that will be animated.
   - Parameter kind: The kind of the animation from the TabbyAnimation struct.
   */
  public static func animate(_ view: UIView, kind: Kind) {
    switch kind {
    case .pop:
      UIView.animate(withDuration: 0.1, animations: {
        view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
          UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            view.transform = CGAffineTransform.identity
            }, completion: nil)
      })
    case .flip:
      view.flip(0.2)
    case .morph:
      view.morph(0.075)
    case .swing:
      view.swing(0.075)
    case .pushUp:
      view.pushUp()
    case .pushDown:
      view.pushDown()
    case .shake:
      let duration = 0.075
      let x: CGFloat = 10
      let y: CGFloat = 0

      Walker.animate(view, duration: duration) {
        $0.transform = CGAffineTransform(translationX: -x, y: -y)
      }.chain(duration: duration) {
        $0.transform = CGAffineTransform(translationX: x, y: y)
      }.chain(duration: duration) {
        $0.transform = CGAffineTransform(translationX: -x / 2, y: -y / 2)
      }.chain(duration: duration) {
        $0.transform = CGAffineTransform.identity
      }
    case .none:
      break
    }
  }
}
