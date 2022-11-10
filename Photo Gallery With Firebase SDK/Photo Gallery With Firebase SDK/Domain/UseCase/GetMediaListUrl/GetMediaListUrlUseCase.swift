//
//  GetMediaListUrl.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

struct GetMediaListUrlUseCase: IGetMediaListUrlUseCase {
    let drive: IGetMediaListUrlDrive
    
    init(drive: IGetMediaListUrlDrive = GetMediaListUrlDrive()) {
        self.drive = drive
    }
    
    func execute() async -> Result<Array<URL>, GetMediaListUrlErrorUseCase> {
        let result = await self.drive.execute()
        return result
    }
}
