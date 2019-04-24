//
//  MyCollectionViewCell.swift
//  TestDemo
//
//  Created by YASYUAN LINANG on 2018/12/19.
//  Copyright © 2018 Xuan. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func setStr(message:String) {
        lblMessage.text = message
    }

}
