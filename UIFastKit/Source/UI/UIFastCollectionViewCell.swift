//
//  UIFastCollectionViewCell.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/21.
//

import UIKit

open class UIFastCollectionViewCell: UICollectionViewCell {
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        contentView.box.layout(mode: .fitContainer)
    }
}
