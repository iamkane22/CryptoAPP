import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let results: [NewsItem]
}

// MARK: - NewsItem
struct NewsItem: Codable {
    let title: String
    let url: String
    let domain: String
    let createdAt: String
    let source: NewsSource
    let thumbnails: Thumbnails?
    let currencies: [NewsCurrency]?
    
    enum CodingKeys: String, CodingKey {
        case title, url, domain
        case createdAt = "created_at"
        case source, thumbnails, currencies
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnail: String?
}

// MARK: - NewsSource
struct NewsSource: Codable {
    let title: String
}

// MARK: - NewsCurrency (əvvəlki Currency)
struct NewsCurrency: Codable {
    let code: String
    let title: String
    let slug: String
    let url: String
}

// MARK: - NewsProtocol
extension NewsItem: NewsProtocol {
    var thumbnailimage: String {
        thumbnails?.thumbnail ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmEljB7i2C_pSP088wDmugps0MKOovpU-XjA&s"
    }
    
    var titleNews: String { title }
    var domainNews: String { domain }
    var dateNews: String { createdAt }
    var sourceNews: String { source.title }
}

typealias NewsDTO = [NewsItem]
