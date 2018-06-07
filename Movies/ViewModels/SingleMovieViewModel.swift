//
//  SingleMovieViewModel.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

class SingleMovieViewModel {
    
    let movie: MovieModel
    
    init(movie: MovieModel) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title.uppercased()
    }
    
    var year: String {
        return movie.year
    }
    
    var imageUrl: URL? {
        if let urlString = movie.poster {
            return URL(string: urlString)
        }
        return nil
    }
    
}
