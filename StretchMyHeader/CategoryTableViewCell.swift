//
//  CategoryTableViewCell.swift
//  StretchMyHeader
//
//  Created by Cameron Mcleod on 2019-07-09.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
