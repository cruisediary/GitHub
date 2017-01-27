//
//  CollectionHelper.swift
//  GitHub
//
//  Created by CruzDiary on 27/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
