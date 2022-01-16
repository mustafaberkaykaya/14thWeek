//
//  CustomTableViewCell.swift
//  14thWeek
//
//  Created by Mustafa Berkay Kaya on 16.01.2022.
//

import UIKit
import TinyConstraints

class CustomTableViewCell: UITableViewCell {
    
    var myImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(myImageView)
    
        setImageViewConstraints()
    }
    // swiftlint:disable all
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable all
    
    func setImageViewConstraints() {
        myImageView.topToSuperview()
        myImageView.leadingToSuperview()
        myImageView.trailingToSuperview()
        myImageView.bottomToSuperview().constant = -5
    }
    
}
