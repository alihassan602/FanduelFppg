//
//  PlayersWebService.swift
//  Created by Ali Hassan on 16/12/2018.
//

import Foundation
import Alamofire
import CodableAlamofire

protocol IPlayerssWebService {
    func requestPlayers(success: @escaping (_ players: [Player]) -> Void,
                        failure: @escaping (_ error: Error) -> Void)
}

class PlayersWebService: BaseWebService, IPlayerssWebService {
    
    func requestPlayers(success: @escaping ([Player]) -> Void, failure: @escaping (Error) -> Void) {
        let url = URL(string: "https://gist.githubusercontent.com/liamjdouglas/bb40ee8721f1a9313c22c6ea0851a105/raw/6b6fc89d55ebe4d9b05c1469349af33651d7e7f1/Player.json")
        
        guard let playerUrl = url else { return }
        
        BaseWebService.sharedManager.request(playerUrl,
                                             method: .get,
                                             parameters: nil,
                                             encoding: URLEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "players") { (response:
                DataResponse<[Player]>) in
                switch response.result {
                case .success(let result):
                    success(result)
                case .failure(let error):
                    failure(error)
                }
        }
    }
    
}
