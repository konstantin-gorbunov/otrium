//
//  Array+Safe.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 02/12/2021.
//

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
