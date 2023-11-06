import Foundation

public
struct TagInfo: Identifiable, Decodable {
    var index: Int
    public var id: String
    public var title: String?
    public var alternateTitle: String?
    public var version: String?
    public var key: Key?
    public var numberOfVoices: Int?
    public var style: Style?
    public var recordingMethod: String?
    public var youTubeID: String?
    public var notes: String?
    public var arranger: String?
    public var arrangerWebsite: URL?
    public var arrangeYear: Int?
    public var sungBy: String?
    public var singerWebsite: URL?
    public var sungYear: Int?
    public var quartet: String?
    public var quartetWebsite: URL?
    public var teacher: String?
    public var teacherWebsite: URL?
    public var provider: String?
    public var providerWebsite: URL?
    public var postDate: String?
    public var classicID: Int?
    public var collection: Collection?
    public var averageRating: Float?
    public var numberOrRatings: Int?
    public var numberOfDownloads: Int?
    public var updateDate: Date?
    public var sheetMusic: URL?
    public var alternateSheetMusic: URL?
    public var notation: URL?
    public var lyrics: String?
    public var allVoices: URL?
    public var bassVoice: URL?
    public var bariVoice: URL?
    public var leadVoice: URL?
    public var tenorVoice: URL?
    public var other1Voice: URL?
    public var other2Voice: URL?
    public var other3Voice: URL?
    public var other4Voice: URL?
    public var videos: [VideoInfo]? { _videos?.videos }
    var _videos: Videos?
    
    public
    enum Style: String, Decodable {
        case barbershop = "Barbershop"
        case sweetAdelines = "Sweet Adelines"
        case SATB = "SATB"
        case otherMale = "Other male"
        case otherFemale = "Other female"
        case otherMixed = "Other mixed"
    }
    
    public
    enum Collection: String, Decodable {
        case classic = "classic"
        case easy = "easytags"
        case days100 = "100"
    }
    

}

struct Videos: Decodable {
    public var videos: [VideoInfo]
}

public
struct VideoInfo: Identifiable, Decodable {
    public var id: String
    public var desc: String?
    public var key: Key?
    public var isMultiTrack: Bool = false
    public var youTubeID: String?
    public var sungBy: String?
    public var singerWebsite: URL?
    public var postDate: String?
}

public
enum Key: Decodable, Equatable {
    case major(Note)
    case minor(Note)
}

public
indirect enum Note: Decodable, Equatable {
    case C
    case D
    case E
    case F
    case G
    case A
    case B
    case flat(Note)
    case sharp(Note)
}
