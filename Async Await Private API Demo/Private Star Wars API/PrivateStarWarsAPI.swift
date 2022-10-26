//
//  PrivateStarWarsAPI.swift
//  Async Await Demo
//
//  Created by Trevor Whittingham on 9/22/22.
//

import Foundation

class PrivateStarWarsAPI {
    
    typealias PersonAPIResult = Result<[StarWarsPerson], Error>
    
    let peopleURL = URL(string: "https://swapi.dev/api/people")!
    
    func loadPeople(completion: @escaping (PersonAPIResult) -> ()) {
        let request = URLRequest(url: peopleURL)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure("No data was returned"))
                return
            }
            
            let personResponse: StarWarsPersonResponse
            
            do {
                personResponse = try JSONDecoder().decode(StarWarsPersonResponse.self, from: data)
            } catch {
                completion(.failure(error))
                return
            }
            
            completion(.success(personResponse.results))
        }
        .resume()
    }
}
