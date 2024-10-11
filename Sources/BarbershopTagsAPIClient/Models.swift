import Foundation


/// Object with the fields queried for each tag in the query call
public
struct TagInfo: Identifiable, Hashable, Decodable, Sendable {
    /// The tag's internal database ID
    public var id: Int
    /// The tag's primary title
    public var title: String?
    /// The tag's alternative title
    public var alternateTitle: String?
    /// The tag's version (e.g. "Realtime version")
    public var version: String?
    /// The key the tag was written in
    public var key: Key?
    /// The number of voice parts the tag was written for
    public var numberOfVoices: Int? { _parts.flatMap { Int($0)} }
    /// Either "Barbershop", "Sweet Adelines", "SATB", "Other male", "Other female" or "Other mixed"
    public var style: Style?
    /// The method by which the learning tracks (if any) were recorded
    public var recordingMethod: String?
    /// The YouTube video ID of the learning video - http://www.youtube.com/watch?v=[video ID here]
    public var youTubeID: String?
    /// Any notes or comments made by the person who uploaded the tag
    public var notes: String?
    /// The name of the tag's arranger
    public var arranger: String?
    /// The arranger's website
    public var arrangerWebsite: URL?
    /// The year the tag was arranged
    public var arrangeYear: Int?
    /// The artist that made the tag famous
    public var sungBy: String?
    /// The website of the artist that made the tag famous
    public var singerWebsite: URL?
    /// The year the tag was made famous
    public var sungYear: Int?
    /// The quartet or person that sung the learning tracks
    public var quartet: String?
    /// The website of the quartet or person that sung the learning tracks
    public var quartetWebsite: URL?
    /// The quartet or person that sung the learning video
    public var teacher: String?
    /// The website of the quartet or person that sung the learning video
    public var teacherWebsite: URL?
    /// The person that provided the tag or learning tracks
    public var provider: String?
    /// The website of the person that provided the tag or learning tracks
    public var providerWebsite: URL?
    /// The date the tag was added to the BarbershopTags.com website
    public var postDate: String?
    /// If the tag is part of David Wright's "Classic Tags" booklet, this is the tag number within that booklet
    public var classicID: Int?
    /// Which collection of tags this tag is a part of
    public var collection: Collection?
    /// The average of all the tag's 5-star ratings, as a decimal number (e.g. 3.451104)
    public var averageRating: Decimal?
    /// The number of people that have rated the tag
    public var numberOrRatings: Int?
    /// The number of times the tag has been downloaded
    public var numberOfDownloads: Int?
    /// The date and time the tag was last updated, in the format YYYY-MM-DD HH:MM:SS.
    /// Note that when a tag's rating or download count changes, this updates the tag's stamp value.  Note also that when a video is added to the list of videos available for a tag, the tag's stamp does not change
    public var updateDate: Date?
    /// URL of the tag's sheet music
    public var sheetMusic: URL?
    /// Alternate URL of the tag's sheet music
    public var alternateSheetMusic: URL?
    /// URL of the tag's music notation file
    public var notation: URL?
    /// The lyrics to the tag
    public var lyrics: String?
    /// URLs of each of the tag's learning tracks with all voices
    public var allVoices: URL?
    /// URLs of the tag's learning tracks with bass voice
    public var bassVoice: URL?
    /// URLs of the tag's learning tracks with baritone voice
    public var bariVoice: URL?
    /// URLs of the tag's learning tracks with lead voice
    public var leadVoice: URL?
    /// URLs of the tag's learning tracks with tenor voice
    public var tenorVoice: URL?
    /// URLs of the tag's learning tracks with other voce 1
    public var other1Voice: URL?
    /// URLs of the tag's learning tracks with other voce 2
    public var other2Voice: URL?
    /// URLs of the tag's learning tracks with other voce 3
    public var other3Voice: URL?
    /// URLs of the tag's learning tracks with other voce 4
    public var other4Voice: URL?
    /// Array of tag videos, arranged in descending order of the date the video was added to BarbershopTags.com
    public var videos: [VideoInfo]? { _videos?.videos }
    var index: Int
    var _videos: Videos?
    var _parts: String?
    
    /// Styles a tag can be arranged in
    public
    enum Style: String, Hashable, Decodable, Sendable {
        case barbershop = "Barbershop"
        case sweetAdelines = "Sweet Adelines"
        case SATB = "SATB"
        case otherMale = "Other male"
        case otherFemale = "Other female"
        case otherMixed = "Other mixed"
    }
    
    /// Collections where a tag can be classified in
    public
    enum Collection: String, Hashable, Decodable, Sendable {
        case classic = "classic"
        case easy = "easytags"
        case days100 = "100"
    }
}

struct Videos: Decodable, Hashable, Sendable {
    var videos: [VideoInfo]
}

/// Object with the info for each video
public
struct VideoInfo: Identifiable, Hashable, Decodable, Sendable {
    /// The video's unique ID
    public var id: Int
    /// The uploader's description of the video
    public var desc: String?
    /// The key the video is sung in
    public var key: Key?
    /// true iif the video has multiple tracks
    public var isMultiTrack: Bool = false
    /// The YouTube video ID - http://www.youtube.com/watch?v=[Code here]
    public var youTubeID: String?
    /// Name of singer or quartet in the video
    public var sungBy: String?
    /// Website of the above singer or quartet
    public var singerWebsite: URL?
    /// Date the video was added to BarbershopTags.com
    public var postDate: String?
}

/// Object to represent the key a tag is sung
public
enum Key: Decodable, Hashable, Sendable {
    case major(Note)
    case minor(Note)
}

/// Object to represent the key note
public
indirect enum Note: Decodable, Hashable, Sendable {
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
