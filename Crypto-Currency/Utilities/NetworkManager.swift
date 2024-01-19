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
        case badURLResponse(url: URL)
        case unKnown
        
        var errorDescription: String?{
            switch self{
            case .badURLResponse(let url):
                return "[🔥] bad Response from URL: \(url)"
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
                guard let response = output.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else{
                    print("inValid Response")
                    throw NetworkingError.badURLResponse(url: url)
                }
                print("🚀-> "+output.response.debugDescription)
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
