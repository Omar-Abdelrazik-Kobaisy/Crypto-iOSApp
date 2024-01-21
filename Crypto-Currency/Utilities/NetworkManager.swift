//
//  NetworkManager.swift
//  Crypto-Currency
//
//  Created by Omar on 19/01/2024.
//

import Foundation
import Combine
protocol NetworkProtocol{
    func download(fromURL url: URL) -> AnyPublisher<Data,Error>
    func handleCompletion(completion: Subscribers.Completion<Error>)
}

class NetworkManager: NetworkProtocol{
    
    enum NetworkingError: LocalizedError{
        case invalidResponse
        case badURLResponse(url: URL, statusCode: Int)
        case unKnown
        
        var errorDescription: String?{
            switch self{
            case .invalidResponse:
                return "[🧨] invalid Response"
            case .badURLResponse(let url, let statusCode):
                return "[🔥] bad Response from URL: \(url),\n statusCode: \(statusCode)"
            case .unKnown:
                return "[🐸] UnKnown Erro Occured"
            }
        }
    }
    
    func download(fromURL url: URL) -> AnyPublisher<Data,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkingError.invalidResponse
                }
                guard (200...299).contains(response.statusCode) else{
                    throw NetworkingError.badURLResponse(url: url, statusCode: response.statusCode)
                }
                print("🚀-> "+response.debugDescription)
                return output.data
            }
            .eraseToAnyPublisher()
    }
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("Successfully Decoded data into CoinModel")
        case .failure(let error):
            print("can't decode data into CoinModel ->"+error.localizedDescription)
        }
    }
}
