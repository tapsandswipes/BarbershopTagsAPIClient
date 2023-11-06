import Foundation

extension QueryResult {
    enum CodingKeys: String, CodingKey {
        case available = "available"
        case tags = "tag"
    }
}

extension TagInfo {
    enum CodingKeys: String, CodingKey {
        case index = "index"
        case id = "id"
        case title = "Title"
        case alternateTitle = "AltTitle"
        case version = "Version"
        case key = "WritKey"
        case numberOfVoices = "Parts"
        case style = "Type"
        case recordingMethod = "Recording"
        case youTubeID = "TeachVid"
        case notes = "Notes"
        case arranger = "Arrenger"
        case arrangerWebsite = "ArrWebsite"
        case arrangeYear = "Arranged"
        case sungBy = "SungBy"
        case singerWebsite = "SungWebsite"
        case sungYear = "SungYear"
        case quartet = "Quartet"
        case quartetWebsite = "QWebsite"
        case teacher = "Teacher"
        case teacherWebsite = "TWebsite"
        case provider = "Provider"
        case providerWebsite = "ProvWebsite"
        case postDate = "Posted"
        case classicID = "Classic"
        case collection = "Collection"
        case averageRating = "Rating"
        case numberOrRatings = "RatingCount"
        case numberOfDownloads = "Downloaded"
        case updateDate = "stamp"
        case sheetMusic = "SheetMusic"
        case alternateSheetMusic = "SheetMusicAlt"
        case notation = "Notation"
        case lyrics = "Lyrics"
        case allVoices = "AllParts"
        case bassVoice = "Bass"
        case bariVoice = "Bari"
        case leadVoice = "Lead"
        case tenorVoice = "Tenor"
        case other1Voice = "Other1"
        case other2Voice = "Other2"
        case other3Voice = "Other3"
        case other4Voice = "Other4"
        case _videos = "videos"
    }
}

extension Videos {
    enum CodingKeys: String, CodingKey {
        case videos = "video"
    }
}

extension VideoInfo {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case desc = "Desc"
        case key = "SungKey"
        case isMultiTrack = "Multitrack"
        case youTubeID = "Code"
        case sungBy = "SungBy"
        case singerWebsite = "SungWebsite"
        case postDate = "Posted"
    }
}

extension Key {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        let parts = string.replacingCharacterEntities().split(separator: ":")
        
        guard parts.count == 2 else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Wrong Key format")
        }
        
        switch parts.first?.lowercased() {
        case "major":
            guard let note = Note(from: parts[1]) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Wrong Key format")
            }
            
            self = .major(note)
        case "minor":
            guard let note = Note(from: parts[1]) else {             
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Wrong Key format")
            }
            
            self = .minor(note)
        default:
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Wrong Key format")
        }
    }
}

extension Note {
    init?(from string: any StringProtocol) {
        guard string.count <= 2 else { return nil }
        
        guard var note = string.first?.naturalNote else { return nil }
        
        if string.count > 1 {
            if string.last?.isFlat == true {
                note = .flat(note)
            }
            
            if string.last?.isSharp == true {
                note = .sharp(note)
            }
        }
        
        self = note
    }
    
    
}

extension Character {
    var naturalNote: Note? {
        switch self.lowercased() {
        case "a":
            return .A
        case "b":
            return .B
        case "c":
            return .C
        case "d":
            return .D
        case "e":
            return .E
        case "f":
            return .F
        case "g":
            return .G
        default:
            return nil
        }
    }
    
    var isFlat: Bool {
        self == "b" || self == "♭"
    }
    
    var isSharp: Bool {
        self == "#" || self == "♯"
    }
}
