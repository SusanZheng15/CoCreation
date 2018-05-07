//
//  Animation.swift
//  VideoCoCreation
//
//  Created by Susan Zheng on 5/3/18.
//  Copyright © 2018 Susan Zheng. All rights reserved.
//

import UIKit
import Foundation

class Animation {
    static let sharedInstance = Animation()
    
    func animateAgePickerView(_ view: UIView, fadeIn: Bool, completion: @escaping ()->()) {
        if fadeIn {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut], animations: {
                view.alpha = 1.0
            }, completion: { (success) in
                if success {
                    completion()
                }
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut], animations: {
                view.alpha = 0.0
            }, completion: { (success) in
                if success {
                    completion()
                }
            })
        }
    }
    
    func bounceButtonAnimation(for button: UIButton, completion: @escaping ()->()) {
        button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            button.transform = .identity
        }) { (success) in
            if success {
                completion()
            }
        }
    }
}
