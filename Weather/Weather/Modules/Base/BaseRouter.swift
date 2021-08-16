//
//  BaseRouter.swift
//  Weather
//
//  Created by Ted on 2021/08/16.
//

import UIKit

class BaseRouter {

    func show(from start: UIViewController, to destination: UIViewController, with type: TransitionType, animated: Bool = true) {
      switch type {
      case .push:
        guard let navigationController = start.navigationController else {
          fatalError("Can't push without a navigation controller")
        }
        navigationController.pushViewController(destination, animated: animated)
      case .present(let sender):
        sender.present(destination, animated: animated)
      }
    }
    
    func pop(from viewController: UIViewController, animated: Bool) {
      if let navigationController = viewController.navigationController {
        guard navigationController.popViewController(animated: animated) != nil else {
          if let presentingView = viewController.presentingViewController {
            return presentingView.dismiss(animated: animated)
          } else {
            fatalError("Can't navigate back")
          }
        }
      } else if let presentingView = viewController.presentingViewController {
        presentingView.dismiss(animated: animated)
      } else {
        fatalError("Neither modal nor navigation! Can't navigate back")
      }
    }
}
