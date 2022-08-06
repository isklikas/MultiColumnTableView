//
//  MultipleColumnCell.swift
//  MultiColumnTableView
//
//  Created by John Sklikas on 6/8/22.
//

import UIKit

@IBDesignable
class MultipleColumnCell: UICollectionViewCell {
    var textLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor;
        self.layer.cornerRadius = 5.0
    }
}
