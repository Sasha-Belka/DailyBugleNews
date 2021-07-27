//
//  TableViewCell.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 16.07.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var MyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TableViewCell {
    @discardableResult
    func configure(with model: Result) -> UITableViewCell {
        MyLabel.text = model.title
        return self
    }
}
