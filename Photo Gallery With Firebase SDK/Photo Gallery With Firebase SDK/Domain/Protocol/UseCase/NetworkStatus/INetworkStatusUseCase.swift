//
//  NetworkStatusUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation

protocol INetworkStatusUseCase {
    func execute() async -> Result<Bool, NetworkStatusGetMediaErrorUseCase>
}
