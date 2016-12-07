@testable import Tabby
import XCTest
import UIKit

class TabbyTests: XCTestCase {

  /**
   Test to know in which position the controller
   should be at every time in relation with the bar.
   */
  func testControllerPosition() {
    let constant = -Tabby.Constant.Dimension.height
    let firstController = UIViewController()
    let secondController = UIViewController()
    let thirdController = UIViewController()

    let items: [TabbyBarItem] = [
      TabbyBarItem(controller: firstController, image: "cow"),
      TabbyBarItem(controller: secondController, image: "donut"),
      TabbyBarItem(controller: thirdController, image: "fish")
    ]

    let tabbyController = TabbyController(items: items)

    tabbyController.translucent = true
    XCTAssertTrue(tabbyController.heightConstant == 0)

    tabbyController.translucent = false
    XCTAssertTrue(tabbyController.heightConstant == constant)

    tabbyController.barHidden = false
    XCTAssertTrue(tabbyController.heightConstant == constant)

    tabbyController.barVisible = true
    XCTAssertTrue(tabbyController.heightConstant == constant)

    tabbyController.barVisible = false
    XCTAssertTrue(tabbyController.heightConstant == 0)
  }
}
