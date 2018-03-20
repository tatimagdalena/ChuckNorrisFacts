//
//  FeedViewCell.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 15/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

class FeedViewCell: UITableViewCell {

    @IBOutlet var phraseLabel: UILabel!
    @IBOutlet var caterogyLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
