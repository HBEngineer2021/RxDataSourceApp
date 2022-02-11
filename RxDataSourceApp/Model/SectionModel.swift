//
//  SectionModel.swift
//  RxDataSourceApp
//
//  Created by Motoki Onayama on 2022/02/11.
//

import Foundation
import RxDataSources

struct SectionModel {
    var header: String
    var items: [Anime]
}

extension SectionModel: SectionModelType {
    init(original: SectionModel, items: [Anime]) {
        self = original
        self.items = items
    }
}
