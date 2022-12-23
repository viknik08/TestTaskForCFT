//
//  TextField + Extension.swift
//  TestTaskForCFT
//
//  Created by Виктор Басиев on 23.12.2022.
//

import UIKit
import SnapKit

extension UITextField {
    func setLeftIcon(_ image: UIImage) {
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }

}
