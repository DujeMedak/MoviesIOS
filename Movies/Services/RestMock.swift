//
//  RestMock.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

class RestMock:RestAPI{
    
    var movies = [String: Movie]()
    
    
    init() {
        let author1 = Person(name: "Christopher", surname: "Nolan")
        let movie1 = Movie(title: "Inception", uri:"https://ia.media-imdb.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_UY1200_CR90,0,630,1200_AL_.jpg", description: "A thief, who steals corporate secrets through the use of dream-sharing technology, is given the inverse task of planting an idea into the mind of a CEO.", year: 2010, genre: Genre.action, author: author1)
        
        
        let author2 = Person(name: "Damien", surname: "Chazelle")
        let movie2 = Movie(title: "Whiplash", uri:"https://upload.wikimedia.org/wikipedia/en/0/01/Whiplash_poster.jpg", description: "A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are mentored by an instructor who will stop at nothing to realize a student's potential.", year: 2014, genre: Genre.drama, author: author2)
        
        movies[movie1.title]=movie1
        movies[movie2.title]=movie2
    }
    
    func getMovie(title: String) -> Movie? {
        //TODO handle exceptions
        let mov = movies[title]
        if  mov != nil{
            return mov
        }
        return nil
    }

    
    
}
