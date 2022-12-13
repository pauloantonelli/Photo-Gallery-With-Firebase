//
//  MockImageWeb.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 13/12/22.
//

import Foundation
import UIKit

struct MockImageWeb {
    static func mockImageWeb(quantity: Int = 10) -> Array<UIImage> {
        let num = Int.random(in: 3...4)
        print("num is \(num)")
        let isPair = num / 2 == 2 ? true : false
        print("isPair: \(isPair)")
        let resolution = isPair == true ? "350" : "150"
        var urlList: Array<URL> = []
        var imageList: Array<UIImage> = []
        for _ in 0...quantity {
            urlList.append(URL(string: "https://via.placeholder.com/\(resolution)")!)
        }
        urlList.forEach { url in
            let data = NSData(contentsOf: url)
            let image = UIImage(data: data! as Data)!
            imageList.append(image)
        }
        return imageList
    }
}
