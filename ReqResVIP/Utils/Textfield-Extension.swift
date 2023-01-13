//
//  Textfield-Extension.swift
//  ReqResVIP
//
//  Created by user on 10/12/22.
//

import UIKit

extension UITextField {
    
    func isValid() -> Bool {
        guard let text = self.text,
              !text.isEmpty else {
            return false
        }
        return true
    }
    
}
