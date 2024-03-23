//
//  Note.swift
//  Notes Watch App
//
//  Created by Артем Кривдин on 23.03.2024.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
