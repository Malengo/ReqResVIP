//
//  UIViewControllerSpy.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 09/02/23.
//

import UIKit

class UIViewControllerSpy: UIViewController {
    
    var presentCompletionHandler: ((_ viewControllerToPresenter: UIViewController, _ animated: Bool, _ completion: (() -> Void)? ) -> Void)?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    presentCompletionHandler?(viewControllerToPresent,  flag, completion)
    }
}
