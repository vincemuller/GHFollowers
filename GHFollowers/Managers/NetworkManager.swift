
import UIKit

class NetworkManager {
    static let shared   = NetworkManager()  //Every NetworkManager call will have this variable
    private let baseURL         = "https://api.github.com/users/"      //The static url for the api http(s) request
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}  //This combined with the static variable creates the singleton
    
    //Function to execute the sending of a network request
    //username is a parameter variable, page is the parameter for pagination, completed is a completion handler....@escping is used because this function needs to wait for a api response.  [Follower] is the expected array of followers that will be in the response or an ErrorMessage...both are optionals.
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        //basically an if statement to account for the optional failure due to invalid username
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        //If the username is valid, then the url can be used and a response will be returned
        //The error has several error options...guard statements help to manage this and communicate the errors to the user/developer
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
                          
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            //If the network connection is good, the response is 200 or ok, and the data is valid, then the JSON can be decoded.
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
}
