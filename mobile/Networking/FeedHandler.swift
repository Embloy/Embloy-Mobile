//
//  FeedHandler.swift
//  mobile
//
//  Created by cb on 06.09.23.
//

import Foundation

class FeedHandler {
    
    /// Queries jobs based on search criteria and access token.
    ///
    /// This function initiates a network request to query jobs based on the specified search criteria, including query keywords,
    /// job type, and sorting options. It constructs the request URL with query parameters for search criteria and access token,
    /// then delegates the request to the `performRequest` function for execution. The response is processed, and the result is
    /// returned in the completion closure.
    ///
    /// - Parameters:
    ///   - query: The query string containing search keywords.
    ///   - jobType: The type of jobs to search for (e.g., "full-time," "part-time").
    ///   - sortBy: The sorting criteria for search results (e.g., "relevance," "date").
    ///   - accessToken: The access token required for authentication with the API.
    ///   - completion: A closure that receives a `Result` containing either a `JobsResponse` or an API error.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let query = "software engineer"
    /// let jobType = "full-time"
    /// let sortBy = "relevance"
    /// let accessToken = "your_access_token"
    ///
    /// FeedHandler.queryJobs(query: query, jobType: jobType, sortBy: sortBy, accessToken: accessToken) { result in
    ///     switch result {
    ///     case .success(let jobs):
    ///         // Handle successful response data (e.g., display job listings)
    ///     case .failure(let error):
    ///         // Handle API error (e.g., display error message to the user)
    ///         print("API Error: \(error)")
    ///     }
    /// }
    /// ```
    ///
    /// - SeeAlso: `performRequest` for the underlying request implementation.
    /// - SeeAlso: `JobsResponse` for the response that contains the decoded `Job` array.
    /// - SeeAlso: `APIError` for the possible API error types.
    /// - SeeAlso: `Result` for the result type that contains either the decoded response data or an API error.
    static func queryJobs(query: String, jobType: String, sortBy: String, accessToken: String, completion: @escaping (Result<JobsResponse, APIError>) -> Void) {
        print("Started querying jobs with: \nquery: \(query)\njobType: \(jobType)\nsortBy: \(sortBy)\naccess_token: \(accessToken)")
        guard var urlComponents = URLComponents(string: Routes.ROOT_URL + Routes.JOBS_FIND_PATH) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "job_type", value: jobType),
            URLQueryItem(name: "sortBy", value: sortBy)
        ]
        guard let url = urlComponents.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        print("URL: \(url)")

        RequestHandler.performRequest(url: url, httpMethod: HTTPMethod.GET, accessToken: accessToken, responseType: JobsResponse.self, completion: completion)
    }

    /// Fetches a feed of jobs based on geographical coordinates and access token.
    ///
    /// This function initiates a network request to retrieve a feed of jobs near the specified latitude and longitude.
    /// It constructs the request URL with query parameters for geographical location and access token, then delegates
    /// the request to the `performRequest` function for execution. The response is processed, and the result is
    /// returned in the completion closure.
    ///
    /// - Parameters:
    ///   - longitude: The longitude coordinate for the job search location.
    ///   - latitude: The latitude coordinate for the job search location.
    ///   - page: The page number for paginating results (currently not implemented).
    ///   - accessToken: The access token required for authentication with the API.
    ///   - completion: A closure that receives a `Result` containing either a `FeedResult` or an API error.
    ///
    /// - Note: This function does not currently implement pagination with the `page` parameter, but the TODO comment
    ///         indicates the intent to add pagination in the future. Ensure that the API supports pagination when
    ///         implementing this feature.
    ///
    /// Example usage:
    ///
    /// let longitude: Float = 123.456
    /// let latitude: Float = 45.678
    /// let page: Int = 1
    /// let accessToken = "your_access_token"
    ///
    /// FeedHandler.fetchFeed(longitude: longitude, latitude: latitude, page: page, accessToken: accessToken) { result in
    ///     switch result {
    ///     case .success(let jobs):
    ///         // Handle successful response data (e.g., display job listings)
    ///     case .failure(let error):
    ///         // Handle API error (e.g., display error message to the user)
    ///         print("API Error: \(error)")
    ///     }
    /// }
    ///
    /// - SeeAlso: `performRequest` for the underlying request implementation.
    /// - SeeAlso: `FeedResponse` for the response that contains the decoded `Job` array.
    /// - SeeAlso: `APIError` for the possible API error types.
    /// - SeeAlso: `Result` for the result type that contains either the decoded response data or an API error.
    static func fetchFeed(longitude: Float, latitude: Float, page: Int, accessToken: String, completion: @escaping (Result<FeedResponse, APIError>) -> Void) {
        print("Started fetching feed with: \npage: \(page)\naccess_token: \(accessToken)")
        guard var urlComponents = URLComponents(string: Routes.ROOT_URL + Routes.JOBS_FEED_PATH) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            // TODO: Add pagination for /jobs to Rails API:
            // URLQueryItem(name: "page", value: "\(page)")
        ]
        guard let url = urlComponents.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        print("URL: \(url)")

        RequestHandler.performRequest(url: url, httpMethod: HTTPMethod.GET, accessToken: accessToken, responseType: FeedResponse.self, completion: completion)
    }
}
