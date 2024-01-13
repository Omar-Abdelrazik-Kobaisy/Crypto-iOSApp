//
//  CoinDataService.swift
//  Crypto-Currency
//
//  Created by Omar on 13/01/2024.
//

import Foundation
import Combine

protocol CoinDataServiceProtocol{
    func getCoins() -> AnyPublisher<[CoinModel],NetworkError>
}
class CoinDataService: CoinDataServiceProtocol {
    
//    @Published var allCoins: [CoinModel] = []
//    var coinSubscription: AnyCancellable?
    init(){
//        getCoins()
    }
    func getCoins() -> AnyPublisher<[CoinModel],NetworkError>{
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en") else{
            print("bad URL")
            return AnyPublisher(Fail<[CoinModel],NetworkError>(error: NetworkError.badURL("inValid URl")))
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    print("inValid Response")
                    throw URLError(.badServerResponse)
                }
                print(response.statusCode)
                return output.data
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .mapError({ error in
                self.errorHandling(error)
            })
            .eraseToAnyPublisher()
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("Successfully Decoded data into CoinModel")
//                case .failure(let error):
//                    print("can't decode data into CoinModel ->"+error.localizedDescription)
//                }
//            } receiveValue: {[weak self] coins in
//                guard let self else{return}
//                self.allCoins = coins
//                self.coinSubscription?.cancel()
//            }

    }
    private func errorHandling(_ error: Error) -> NetworkError {
        
        let networkError = error as? NetworkError
        switch networkError {
        case .invalidJSON:
            return NetworkError.invalidJSON(String(describing: "invalid Json"))
        case .unauthorized:
            return NetworkError.unauthorized(code: 401, error: "Unauthorized Need Token")
        default:
            print(error)
            return NetworkError.unknown(code: 0, error: error.localizedDescription)
        }
    }
}

public enum NetworkError:Error, Equatable{
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}
