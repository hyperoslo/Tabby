import UIKit

/**
 The tab bar delegate that will tell you when a button in the tab bar was pressed.
 */
public protocol TabbyBarDelegate: class {

  func tabbyButtonDidPress(_ index: Int)
}

/**
 The actual tab bar.
 */
open class TabbyBar: UIView {

  static let collectionObserver = "contentSize"
  static let KVOContext = UnsafeMutableRawPointer(mutating: nil)

  lazy var translucentView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

  lazy var layout: TabbyLayout = {
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
    view.layer.zPosition = 1

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

  var badges: [String : Int] = [:] {
    didSet {
      collectionView.reloadData()
    }
  }

  weak var delegate: TabbyBarDelegate?

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
      options: .old, context: TabbyBar.KVOContext)

    setupCollectionView()
    setupConstraints()
  }

  open override func observeValue(
    forKeyPath keyPath: String?, of object: Any?,
    change: [NSKeyValueChangeKey : Any]?,
    context: UnsafeMutableRawPointer?) {
      guard context == TabbyBar.KVOContext else { return }
      positionIndicator(selectedItem, animate: false)
  }

  /**
   Initializer.
   */
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    collectionView.removeObserver(self, forKeyPath: TabbyBar.collectionObserver)
  }

  // MARK: - Collection View setup

  func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.clipsToBounds = false
    collectionView.backgroundColor = Constant.Color.collection

    collectionView.register(
      TabbyCell.self, forCellWithReuseIdentifier: TabbyCell.reusableIdentifier)
  }

  // Animations

  func positionIndicator(_ index: Int, animate: Bool = true) {
    guard let source = collectionView.dataSource , index < items.count else { return }

    UIView.animate(
      withDuration: animate ? 0.7 : 0, delay: 0, usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
        self.indicator.center.x = source.collectionView(
          self.collectionView, cellForItemAt: IndexPath(row: index, section: 0)).center.x
      }, completion: nil)
  }

  // MARK: - Translucency

  func prepareTranslucency(_ translucent: Bool) {
    translucentView.removeFromSuperview()

    if translucent {
      translucentView.translatesAutoresizingMaskIntoConstraints = false
      insertSubview(translucentView, at: 0)
      constraint(translucentView, attributes: .width, .height, .top, .left)
      backgroundColor = Constant.Color.background.withAlphaComponent(0.85)
    } else {
      backgroundColor = Constant.Color.background
    }
  }

  // MARK: - Constraints

  func setupConstraints() {
    indicator.translatesAutoresizingMaskIntoConstraints = false
    addSubview(indicator)
    constraint(indicator, attributes: .left, .bottom)
    addConstraints([
      NSLayoutConstraint(item: indicator,
        attribute: .width, relatedBy: .equal,
        toItem: nil, attribute: .notAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Indicator.width),

      NSLayoutConstraint(item: indicator,
        attribute: .height, relatedBy: .equal,
        toItem: nil, attribute: .notAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Indicator.height)
      ])

    separator.translatesAutoresizingMaskIntoConstraints = false
    addSubview(separator)
    constraint(separator, attributes: .width, .top, .right)
    addConstraint(
      NSLayoutConstraint(item: separator,
        attribute: .height, relatedBy: .equal,
        toItem: nil, attribute: .notAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Separator.height)
    )

    collectionView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(collectionView)
    constraint(collectionView, attributes: .top, .bottom, .leading, .trailing)
  }
}

extension TabbyBar: UICollectionViewDelegate {

  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let position = indexPath.row
    let item = items[position]

    if item.selection == .systematic {
      UIView.animate(withDuration: 0.3, animations: {
        self.indicator.backgroundColor = Constant.Color.selected
      })

      selectedItem = position
    }

    delegate?.tabbyButtonDidPress(position)
  }
}

extension TabbyBar: UICollectionViewDataSource {

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  public func collectionView(_ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TabbyCell.reusableIdentifier, for: indexPath)
      as? TabbyCell else { return UICollectionViewCell() }

    let item = items[indexPath.row]

    cell.configureCell(item, selected: selectedItem == indexPath.row,
                       count: badges[item.image])

    return cell
  }
}
