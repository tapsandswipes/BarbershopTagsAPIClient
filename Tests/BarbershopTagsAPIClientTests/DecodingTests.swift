import Foundation
import XCTest
@testable import BarbershopTagsAPIClient
import XMLCoder


final class DecodingTests: XCTestCase {
    func testDecodingTagInfo() throws {
        let sut = try Data(contentsOf: Bundle.module.url(forResource: "tag54", withExtension: "xml")!)
        
        let decoder = XMLDecoder(removeEmptyElements: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US")
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let tag = try decoder.decode(TagInfo.self, from: sut)
        
        XCTAssertEqual(tag.id, "54")
        XCTAssertEqual(tag.key, Key.major(.flat(.B)))
        XCTAssertEqual(tag.numberOfVoices, 4)
        XCTAssertEqual(tag.style, .barbershop)
        XCTAssertEqual(tag.youTubeID, "y6eX9UzdJZo")
        XCTAssertEqual(tag.arrangeYear, 1983)
        XCTAssertNotNil(tag.quartetWebsite)
        XCTAssertEqual(tag.quartetWebsite, URL(string: "http://www.vocalharmonies.com"))
        XCTAssertEqual(tag.videos?.count, 3)
        XCTAssertNotNil(tag.sheetMusic)
        XCTAssertEqual(tag.sheetMusic, URL(string: "https://www.barbershoptags.com/dbaction.php?action=DownloadFile&dbase=tags&id=54&fldname=SheetMusic"))
    }
    
    func testDecodingTags() throws {
        let sut = try Data(contentsOf: Bundle.module.url(forResource: "tags", withExtension: "xml")!)
        
        let decoder = XMLDecoder(removeEmptyElements: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US")
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let result = try decoder.decode(QueryResult.self, from: sut)
        
        XCTAssertEqual(result.available, 5823)
        XCTAssertEqual(result.lastIndex, 20)
        XCTAssertFalse(result.tags.isEmpty)
        XCTAssertEqual(result.tags.count, 20)
    }
    
    func testDecodingVideoInfo() throws {
        let sut = videoXML.data(using: .utf8)!
        
        let decoder = XMLDecoder(removeEmptyElements: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        decoder.dateDecodingStrategy = .formatted(formatter)
        let video = try decoder.decode(VideoInfo.self, from: sut)
        
        XCTAssertEqual(video.id, "766")
        XCTAssertEqual(video.key, Key.major(.flat(.E)))
    }
    
    func testDecodingVideos() throws {
        let sut = videosXML.data(using: .utf8)!
        
        let decoder = XMLDecoder(removeEmptyElements: true)
        let videos = try decoder.decode(Videos.self, from: sut).videos
        
        XCTAssertFalse(videos.isEmpty)
        XCTAssertEqual(videos.count, 3)
        XCTAssertTrue(videos[0].isMultiTrack)
        XCTAssertFalse(videos[1].isMultiTrack)
    }
    
    func testDecodingKey1() throws {
        let sut = #"{"key": "Major:A#"}"#.data(using: .utf8)!
        
        let key = try JSONDecoder().decode(KeyD.self, from: sut)
        
        XCTAssertEqual(key.key, .major(.sharp(.A)))
    }

    func testDecodingKey2() throws {
        let sut = #"{"key": "Minor:E&#9837;"}"#.data(using: .utf8)!
        
        let key = try JSONDecoder().decode(KeyD.self, from: sut)
        
        XCTAssertEqual(key.key, .minor(.flat(.E)))
    }

}

struct KeyD: Decodable {
    var key: Key
}

