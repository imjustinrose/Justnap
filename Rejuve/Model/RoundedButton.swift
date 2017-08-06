//
//  RoundedButton.swift
//  Rejuve
//
//  Created by Justin Rose on 7/4/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}
