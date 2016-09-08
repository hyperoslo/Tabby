import UIKit

/**
 The tab bar delegate that will tell you when a button in the tab bar was pressed.
 */
public protocol TabbyBarDelegate {

  func tabbyButtonDidPress(index: Int)
}

/**
 The actual tab bar.
 */
public class TabbyBar: UIView {

  static let collectionObserver = "contentSize"

  lazy var translucentView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))

  lazy var layout: TabbyLayout = { [unowned self] in
    let layout = TabbyLayout()
    layout.minimumInteritemSpacing = 0

    return layout
  }()

  lazy var collectionView: UICollectionView =
    UICollectionView(frame: .zero, collectionViewLayout: self.layout)

  lazy var indicator: UIView = {
    let view = UIView()
    view.backgroundColor = Constant.Color.indicator

    return view
  }()

  lazy var separator: UIView = {
    let view = UIView()
    view.backgroundColor = Constant.Color.separator

    return view
  }()

  var items: [TabbyBarItem] {
    didSet {
      // TODO: Configure the did set and delete the reload.
      collectionView.reloadData()
    }
  }

  var selectedItem: Int = 0 {
    didSet {
      positionIndicator(selectedItem)
      collectionView.reloadData()
    }
  }

  var delegate: TabbyBarDelegate?

  // MARK: - Initializers

  /**
   Initializer
   */
  public init(items: [TabbyBarItem]) {
    self.items = items
    
    super.init(frame: .zero)

    backgroundColor = Constant.Color.background

    collectionView.addObserver(
      self, forKeyPath: TabbyBar.collectionObserver,
      options: .Old, context: nil)

    setupCollectionView()
    setupConstraints()
  }

  public override func observeValueForKeyPath(
    keyPath: String?, ofObject object: AnyObject?,
    change: [String : AnyObject]?,
    context: UnsafeMutablePointer<Void>) {
      positionIndicator(selectedItem)
  }

  /**
   Initializer.
   */
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    collectionView.removeObserver(self, forKeyPath: NSKeyValueChangeOldKey)
  }

  // MARK: - Collection View setup

  func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = Constant.Color.collection

    collectionView.registerClass(
      TabbyCell.self, forCellWithReuseIdentifier: TabbyCell.reusableIdentifier)
  }

  // Animations

  func positionIndicator(index: Int, animate: Bool = true) {
    guard let source = collectionView.dataSource where index < items.count else { return }

    UIView.animateWithDuration(
      animate ? 0.7 : 0, delay: 0, usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0, options: [.CurveEaseIn], animations: {
        self.indicator.center.x = source.collectionView(
          self.collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: index, inSection: 0)).center.x
      }, completion: nil)
  }

  // MARK: - Translucency

  func prepareTranslucency(translucent: Bool) {
    translucentView.removeFromSuperview()

    if translucent {
      translucentView.translatesAutoresizingMaskIntoConstraints = false
      insertSubview(translucentView, atIndex: 0)
      constraint(translucentView, attributes: [.Width, .Height, .Top, .Left])
      backgroundColor = Constant.Color.background.colorWithAlphaComponent(0.85)
    } else {
      backgroundColor = Constant.Color.background
    }
  }

  // MARK: - Constraints

  func setupConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(collectionView)
    constraint(collectionView, attributes: [.Top, .Bottom, .Leading, .Trailing])

    indicator.translatesAutoresizingMaskIntoConstraints = false
    addSubview(indicator)
    constraint(indicator, attributes: [.Left, .Bottom])
    addConstraints([
      NSLayoutConstraint(item: indicator,
        attribute: .Width, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Indicator.width),

      NSLayoutConstraint(item: indicator,
        attribute: .Height, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Indicator.height)
      ])

    separator.translatesAutoresizingMaskIntoConstraints = false
    addSubview(separator)
    constraint(separator, attributes: [.Width, .Top, .Right])
    addConstraint(
      NSLayoutConstraint(item: separator,
        attribute: .Height, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Separator.height)
    )
  }
}

extension TabbyBar: UICollectionViewDelegate {

  public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let position = indexPath.row

    selectedItem = position
    delegate?.tabbyButtonDidPress(position)
  }
}

extension TabbyBar: UICollectionViewDataSource {

  public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  public func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
      guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
        TabbyCell.reusableIdentifier, forIndexPath: indexPath) as? TabbyCell else { return UICollectionViewCell() }

      cell.configureCell(items[indexPath.row], selected: selectedItem == indexPath.row)

      return cell
  }
}
