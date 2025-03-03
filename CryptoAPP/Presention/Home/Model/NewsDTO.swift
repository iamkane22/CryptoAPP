// NewsDTO.swift
import Foundation

// MARK: - NewsDTO (Top-level)
struct NewsDTO: Codable {
    let type: Int?
    let message: String?
    let data: [Datum]?
    let rateLimit: RateLimit?
    let hasWarning: Bool?

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case message = "Message"
        case data = "Data"
        case rateLimit = "RateLimit"
        case hasWarning = "HasWarning"
    }
}

// MARK: - Datum (Xəbər maddəsi)
struct Datum: Codable {
    let id: String?
    let guid: String?
    let publishedOn: Int?
    let imageurl: String?
    let title: String?
    let url: String?
    let body: String?
    let tags: String?
    let lang: String?
    let upvotes: String?
    let downvotes: String?
    let categories: String?
    let source: String?
    let sourceInfo: SourceInfo?

    enum CodingKeys: String, CodingKey {
        case id, guid
        case publishedOn = "published_on"
        case imageurl, title, url, body, tags, lang, upvotes, downvotes, categories, source
        case sourceInfo = "source_info"
    }
}

// MARK: - SourceInfo
struct SourceInfo: Codable {
    let name: String?
    let img: String?
    let lang: String?
}

// MARK: - RateLimit (Boş obyekt)
struct RateLimit: Codable {}

extension Datum: NewsProtocol {
    var thumbnailimage: String {
       imageurl ?? ""
    }
    
    var titleNews: String {
        title ?? ""

    }
    
    var domainNews: String {
        source ?? ""
    }
    
    var dateNews: String {
        guard let published = publishedOn else { return "" }
               let date = Date(timeIntervalSince1970: TimeInterval(published))
               let formatter = DateFormatter()
               formatter.dateFormat = "yyyy-MM-dd HH:mm"
               return formatter.string(from: date)
    }
    
    var  newsURL: String {
        url ?? ""
    }
    
    var sourceNews: String {
      sourceInfo?.name ?? ""

    }
    
    
}
