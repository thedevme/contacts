//
//  API.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation
import Combine

struct API {
    enum Error: LocalizedError, Identifiable {
        var id: String { localizedDescription }

        case addressUnreachable(URL)
        case invalidResponse

        var errorDescription: String? {
            switch self {
                case .invalidResponse: return "The server responded with garbage."
                case .addressUnreachable(let url): return "\(url.debugDescription)"
            }
        }
    }
    
    enum EndPoint {
        static var baseURL = URL(string: "https://mobile.staging.listfly.com")!
            
        case contacts(Constants.SortType)
        case search(String, Constants.SortType)

        var url: URL {
            switch self {
            case .contacts(let sort):
                return EndPoint.baseURL.appendingPathComponent(Constants.APIPaths.contacts)
                    .appending(Constants.orderName, value: sort.rawValue)
                    .appending(Constants.limit, value: "50")
            
            case .search(let value, let sort):
                return EndPoint.baseURL.appendingPathComponent(Constants.APIPaths.contacts)
                    .appending(Constants.orderName, value: sort.rawValue)
                    .appending(Constants.limit, value: "50")
                    .appending(Constants.search, value: value)
            }
        }

        static func request(with url: URL) -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(Constants.ApiKeys.activeCampaignKey, forHTTPHeaderField: "Api-Token")

            return request
        }
    }

    private let decoder = JSONDecoder()
    
    func fetchContacts(sort: Constants.SortType) -> AnyPublisher<ContactResponse, Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.request(with: EndPoint.contacts(sort).url))
            .map { return $0.data }
            .decode(type: ContactResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.contacts(.desc).url)
                default: return Error.invalidResponse
                }
            }
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func search(_ value: String) -> AnyPublisher<ContactResponse, Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.request(with: EndPoint.search(value, .desc).url))
            .map { return $0.data }
            .decode(type: ContactResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.search(value, .desc).url)
                default: return Error.invalidResponse
                }
            }
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
