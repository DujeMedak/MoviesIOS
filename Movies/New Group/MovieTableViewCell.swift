//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//
/*
import UIKit

class MovieTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
*/
import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.font = UIFont.systemFont(ofSize: 18)
        title.textColor = UIColor.brown
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
    }
    
    func setup(withMovie movie: MovieModel) {
        title.text = movie.title
    }
}
