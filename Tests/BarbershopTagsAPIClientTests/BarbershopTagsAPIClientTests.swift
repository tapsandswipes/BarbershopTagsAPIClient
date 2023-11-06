import XCTest
@testable import BarbershopTagsAPIClient

final class BarbershopTagsAPIClientTests: XCTestCase {
    var client: BarbershopTagsAPIClient = .init(name: "Test Client")
    
    func testGetRequestFromParameters() throws {
        let sut: Parameters = [
            .collection: TagInfo.Collection.classic
        ]
        
        let request = try client.getRequest(from: sut)
        
        XCTAssertNotNil(request.url)
        XCTAssertEqual(request.url?.query(percentEncoded: false), "Collection=classic")
    }
    
    
}
