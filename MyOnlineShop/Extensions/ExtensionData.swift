//
//  Untitled.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.03.25.
//

/**
 * Erweiterung des Datentyps `Data`, um eine Methode zum Anhängen von Strings hinzuzufügen.
 *
 * Diese Erweiterung fügt dem `Data`-Typ eine `append`-Methode hinzu, die es ermöglicht, einen String direkt an ein bestehendes `Data`-Objekt anzuhängen. Der String wird dabei in UTF-8-kodierte Daten umgewandelt und an das `Data`-Objekt angefügt.
 *
 * @param string Der String, der an das `Data`-Objekt angehängt werden soll.
 *
 * Verwendungszweck:
 * Diese Funktion ist nützlich, wenn man Textdaten (Strings) in einem `Data`-Objekt sammeln möchte, ohne jedes Mal manuell die Konvertierung in `Data` durchführen zu müssen. Sie wird häufig bei der Erstellung von HTTP-Anfragen (z. B. multipart/form-data) verwendet, um Text und Binärdaten zu kombinieren.
 *
 * Beispiel:
 * ```swift
 * var body = Data()
 * body.append("Hallo, ")
 * body.append("Welt!")
 * // Ergebnis: Ein `Data`-Objekt, das die Bytes von "Hallo, Welt!" enthält
 * ```
 */

import SwiftUI

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
