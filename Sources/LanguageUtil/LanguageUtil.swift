//
//  LangManager.swift
//  githubtrending
//
//  Created by 马兴驰 on 2021/11/11.
//

import Foundation
import SwiftyJSON

public struct LanguageUtil {
    let languages: [(lang: String, color: String)]
    private let maps: [String: String]
    private let icons: JSON

    public static let shared = LanguageUtil()
    public static let defaultColor = "#eee"

    init() {
        var lang: JSON = []
        if let bundle = Bundle.module.url(forResource: "color", withExtension: ".json"), let data = try? JSON(data: Data(contentsOf: bundle)) {
            lang = data
        }
        languages = lang.arrayValue.map({ item in
            (item[0].stringValue, item[1].stringValue)
        })
        maps = languages.reduce(into: [:], { partialResult, lang in
            partialResult[lang.lang.lowercased()] = lang.color
        })
        icons = {
            do {
                let file = Bundle.module.url(forResource: "vsicons", withExtension: "json")!
                let data = try Data(contentsOf: file)
                return try JSON(data: data)
            } catch {
                print("LanguageUtil vsicons json Error", error)
                return JSON()
            }
        }()
    }

    // filter language color
    public func langWith(filter: String) -> [(lang: String, color: String)] {
        if filter.isEmpty {
            return languages
        }
        return languages.filter { item in
            item.lang.lowercased().contains(filter.lowercased())
        }
    }

    public func color(forLang lang: String) -> String {
        if let color = maps[lang], !color.isEmpty {
            return color
        }
        return Self.defaultColor
    }

    public func icon(forLang lang: String) -> String {
        let f = lang.lowercased()

        if let icon = icons["languageIds"][f].string {
            return icon
        }

        return "default-file"
    }

    public func icon(forFile file: String) -> String {
        let f = file.lowercased()

        if let icon = icons["fileNames"][f].string {
            return icon
        }

        if let ext = URL(string: f)?.pathExtension {
            if let icon = icons["fileExtensions"][ext].string {
                return icon
            }

            if let icon = icons["languageIds"][ext].string {
                return icon
            }
        }

        return "default-file"
    }
}
