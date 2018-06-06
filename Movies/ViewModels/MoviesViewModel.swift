//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Duje Medak on 06/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//


class MoviesViewModel {
    var movies: [Film]? {
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let context = AERecord.Context.main
        let review = try? context.fetch(request)
        return review
    }
    
    let baseUrl = "https://api.nytimes.com/svc/movies/v2/reviews/search.json"
    let apiKey = "677da7a230e64c11bdd9c25072e1b0d1"
    
    init() {
    }
    
    func fetchReviews(completion: @escaping (([Review]?) -> Void)) -> Void {
        guard let url = URL(string: baseUrl) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          parameters: ["api-key": apiKey])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion(nil)
                    return
                }
                
                if
                    let value = response.result.value as? [String: Any],
                    let results = value["results"] as? [[String: Any]] {
                    let reviews = results.map({ json -> Review? in
                        let review = Review.createFrom(json: json)
                        return review
                    }).filter { $0 != nil } .map { $0! }
                    
                    
                    try? AERecord.Context.main.save()
                    
                    completion(reviews)
                    return
                } else {
                    completion(nil)
                    return
                }
        }
    }
    
    func review(atIndex index: Int) -> Review? {
        guard let reviews = reviews else {
            return nil
        }
        
        return reviews[index]
    }
    
    func numberOfReviews() -> Int {
        return reviews?.count ?? 0
    }
    
    func createReview(withText title: String, date: String, summary: String) -> Void {
        let json: [String: Any] = [
            "display_title": title,
            "summary_short": summary,
            "publication_date": date
        ]
        
        if let _ = Review.createFrom(json: json) {
            try? AERecord.Context.main.save()
        }
    }
}

