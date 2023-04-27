//
//  memo.swift
//  database
//
//  Created by Motoki on 2023/04/27.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
