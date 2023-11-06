import Foundation
import XMLCoder
import Chainable


public
final class BarbershopTagsAPIClient {
    
    public enum Error: Swift.Error {
        case malformedQuery
        case malformedURL
        case tagDoesNotExtist
        case badResponse
        case decodingError(Swift.Error)
        case badStatus(status: Int)
    }

    public init(name: String) {
        clientName = name
    }
    
    public let clientName: String
    
    let session = URLSession(configuration: .default)
    let decoder = XMLDecoder().then {
        $0.dateDecodingStrategy = .formatted(DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
            $0.locale = Locale(identifier: "en_US")
        })
    }
}


extension XMLDecoder: Chainable {}
