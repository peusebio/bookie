//
//  ISBNRestClient.swift
//  Bookie
//
//  Created by Pedro Eusébio on 19/05/2021.
//

import Foundation

class LastFMRestClient {
    
    static let shared: LastFMRestClient = LastFMRestClient()
    
    private init(){}
    
    private lazy var baseUrl: URL = {
        return URL(string: "https://ws.audioscrobbler.com/2.0/")!
    }()
    
    private lazy var apiKey: String = "76572522dfda76783472feeab9ee7aff"
    private lazy var format: String = "json"
    
    func getTopAlbums(with request: TopAlbumListRequest, onResponseReceived: @escaping (AlbumListResponse) -> ()){
        performGetRequest(parameters: request.parameters, onResponseReceived: onResponseReceived)
    }
    
    func getAlbumInfo(with request: AlbumRequest, onResponseReceived: @escaping (AlbumResponse) -> ()) {
        performGetRequest(parameters: request.parameters, onResponseReceived: onResponseReceived)
    }
    
    func getArtistInfo(with request: ArtistRequest, onResponseReceived: @escaping (ArtistResponse) -> ()) {
        performGetRequest(parameters: request.parameters, onResponseReceived: onResponseReceived)
    }
    
    private func performGetRequest<T: Decodable>(parameters: [String:String], onResponseReceived: @escaping(T) -> ()){
        let session = URLSession.shared
        let urlRequest = URLRequest(url: baseUrl)
        let parameters = ["api_key" : apiKey, "format" : format].merging(parameters, uniquingKeysWith: +)
        var encodedUrlRequest = urlRequest.encode(with: parameters)
        encodedUrlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: encodedUrlRequest, completionHandler: { data, response, error in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let serverResponse = try decoder.decode(T.self, from: data)
                    onResponseReceived(serverResponse)
                } catch let error {
                    print("ERROR: \(error)")
                }
            }
        })
        task.resume()
    }
}
