import UIKit

class GeneralController: UIViewController {

  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFit

    return imageView
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFontOfSize(16)
    label.textColor = UIColor.lightGrayColor()
    label.textAlignment = .Center

    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.whiteColor()

    [imageView, titleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }

    setupConstraints()
  }

  // MARK: - Constraint methods

  func setupConstraints() {
    constraint(titleLabel, attributes: [.CenterX, .CenterY])
    constraint(imageView, attributes: [.CenterX])

    view.addConstraints([
      NSLayoutConstraint(
        item: imageView, attribute: .Bottom,
        relatedBy: .Equal, toItem: titleLabel,
        attribute: .Top, multiplier: 1, constant: -200),

      NSLayoutConstraint(
        item: titleLabel, attribute: .Width,
        relatedBy: .Equal, toItem: view,
        attribute: .Width, multiplier: 1, constant: -200)
    ])
  }

  // MARK: - Helper methods

  func constraint(subview: UIView, attributes: [NSLayoutAttribute]) {
    for attribute in attributes {
      view.addConstraint(NSLayoutConstraint(
        item: subview, attribute: attribute,
        relatedBy: .Equal, toItem: view,
        attribute: attribute, multiplier: 1, constant: 0)
      )
    }
  }
}
