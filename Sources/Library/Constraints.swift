import UIKit

// https://github.com/hyperoslo/Sugar/blob/master/Sources/iOS/Constraint.swift
public struct Constraint {
  static func on(constraints: [NSLayoutConstraint]) {
    constraints.forEach {
      ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
      $0.isActive = true
    }
  }

  static func on(_ constraints: NSLayoutConstraint ...) {
    on(constraints: constraints)
  }
}
