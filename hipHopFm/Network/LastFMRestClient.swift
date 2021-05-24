//
//  ISBNRestClient.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import Foundation

class LastFMRestClient {
    
    private lazy var baseUrl: URL = {
        return URL(string: "https://ws.audioscrobbler.com/2.0/")!
    }()
    
    private lazy var apiKey: String = "76572522dfda76783472feeab9ee7aff"

    func getAlbums(with request: AlbumListRequest, onResponseReceived: @escaping ([Album]) -> ()){
        
        let session = URLSession.shared
        let urlRequest = URLRequest(url: baseUrl)
        let parameters = ["api_key" : apiKey].merging(request.parameters, uniquingKeysWith: +)
        var encodedUrlRequest = urlRequest.encode(with: parameters)
        
        encodedUrlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: encodedUrlRequest, completionHandler: { data, response, error in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let serverResponse = try decoder.decode(AlbumListResponse.self, from: data)
                    onResponseReceived(serverResponse.albums.album)
                } catch let error {
                    print("ERROR: \(error)")
                }
            }
        })
        task.resume()

    }
}
