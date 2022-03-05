//
//  item.swift
//  Todoey
//
//  Created by Arhab Muhammad on 04/03/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

class Item: Encodable , Decodable {
    var title: String = ""
    var done: Bool = false
}
