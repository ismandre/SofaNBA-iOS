//
//  RadioButton.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 04.06.2022..
//

import UIKit

class RadioButton: UIButton {
    
    let checkedImage = UIImage(named: "radio_button_checked.png")! as UIImage
    let uncheckedImage = UIImage(named: "radio_button_unchecked.png")! as UIImage
    
    var isChosen = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initButton()
    }
    
    func initButton() {
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.setTitle("", for: .normal)
        
        self.setImage(UIImage(named: "radio_button_unchecked.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        // self.setImage(UIImage(named: "radio_button_checked.png")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        // self.setImage(UIImage(named: "radio_button_checked.png")?.withRenderingMode(.alwaysOriginal), for: .selected)
    }
    
    func switchSelected() {
        if isChosen {
            self.setImage(UIImage(named: "radio_button_unchecked.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            self.setImage(UIImage(named: "radio_button_checked.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        isChosen = !isChosen
    }

}
