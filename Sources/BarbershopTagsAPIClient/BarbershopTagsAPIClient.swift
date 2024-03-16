import Foundation
import XMLCoder
import Chainable


/// Client class to make queries to barbershoptags.com
open class BarbershopTagsAPIClient {
    
    /// Errors thrown by the client
    public enum Error: Swift.Error {
        case malformedQuery
        case malformedURL
        case tagDoesNotExtist
        case badResponse
        case decodingError(Swift.Error)
        case badStatus(status: Int)
        case wrongRatingValue
    }
    
    /// Initialize a new client instance
    /// - Parameters:
    ///   - name: name used by this client in loggin and to identify to the server
    ///   - session: URLSession configured to be used for the API calls
    public init(name: String, session: URLSession = URLSession(configuration: .default)) {
        self.session = session
        clientName = name
    }
    
    /// Name used to instantiate this client
    public let clientName: String
    
    let session: URLSession
    let decoder = XMLDecoder(removeEmptyElements: true).then {
        $0.dateDecodingStrategy = .formatted(DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
            $0.locale = Locale(identifier: "en_US")
        })
    }
}


extension XMLDecoder: Chainable {}
