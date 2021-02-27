//
//  ServiceLayer.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 24.02.2021.
//

import Foundation

class ServiceLayer {
    
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
                                    
        let url = URL.init(string: router.url)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
}
