//
//  Dictionary+ConvertedValues.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


extension Dictionary  {
    /** returns value for key if it's of type T or empty value of type T if not.
     If T is optional and value is not T the nil will be returned */
    func any<T>(_ key: Key) -> T where T: NMLAnyValuable {
        return (self[key] as? T) ?? T.createValue()
    }
}

/** Any type that can have default empty value */
protocol NMLAnyValuable {
    static func createValue() -> Self
}

extension Optional: NMLAnyValuable {
    static func createValue() -> Optional<Wrapped> {
        return .none
    }
}

extension String: NMLAnyValuable {
    static func createValue() -> String {
        return ""
    }
}

extension Int: NMLAnyValuable {
    static func createValue() -> Int {
        return 0
    }
}

extension Array: NMLAnyValuable {
    static func createValue() -> Array<Element> {
        return []
    }
}

extension Dictionary: NMLAnyValuable {
    static func createValue() -> Dictionary<Key, Value> {
        return [:]
    }
}
