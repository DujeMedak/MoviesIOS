//
//  RestAPI.swift
//  Movies
//
//  Created by Duje Medak on 14/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation


protocol RestAPI{
    func getMovie(title: String) -> Movie?
    func fetchMovieModel(title:String) -> MovieModel?
    func fetchMovieModelList(search: String, completion: @escaping (([MovieModel]?) -> Void))
}
