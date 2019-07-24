//
//  Results.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import Foundation

struct ArticleSectionResults : Decodable {
	let name : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}

}
