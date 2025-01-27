# Online Shop

## Warum hast du dich für diese App entschieden?

Ich habe mich für diese App entschieden, weil ich in den letzten 10 Jahren intensiv mit Internetshops gearbeitet habe, jedoch nie die Gelegenheit hatte, einen eigenen zu erstellen. Diese Erfahrung hat mir gezeigt, wie wichtig es ist, eine benutzerfreundliche und effiziente Lösung für die Verwaltung und Bestellung von Produkten zu entwickeln. Die App soll meine Vision von einem einfach zu bedienenden und funktionalen Online-Shop verwirklichen.

## Was soll diese App für ein Problem lösen, warum sollte man diese App nutzen?

Die App löst das Problem der komplizierten und oft unübersichtlichen Verwaltung von Online-Shop-Produkten. Sie bietet eine benutzerfreundliche Plattform, um Produkte schnell und einfach hinzuzufügen, zu bearbeiten und zu verwalten, insbesondere aus der Sicht eines Administrators. Kunden können Produkte mühelos durchsuchen und bestellen, was das Einkaufserlebnis für sie erheblich verbessert. Die App ist besonders nützlich für Unternehmen, die eine effiziente und unkomplizierte Lösung für ihren Online-Shop suchen.

## Was kann die App?

Die App ermöglicht es, Produkte in wenigen Schritten hinzuzufügen und zu bearbeiten, mit Funktionen wie Preisgestaltung, Kategorisierung und Bestandsverwaltung. Sie bietet eine benutzerfreundliche Oberfläche sowohl für Administratoren als auch für Kunden. Darüber hinaus ermöglicht die App eine schnelle Bestellung und Verwaltung von Bestellungen, was den gesamten Verkaufsprozess vereinfacht.

## Funktionen:

Die Anwendung basiert auf der MVVM-Architektur und nutzt Firebase (Firestore Database) als Backend sowie die Imgur API für das Hochladen von Bildern.


## Modelle in der Anwendung:

### 1.	Produktmodell (Product):

Wird zur Erstellung von Produkten verwendet, die vom Administrator definiert werden. Jedes Produkt enthält grundlegende Informationen wie Name, Beschreibung, Preis, Bilder und Verfügbarkeit.

![Bildschirmfoto 2025-01-27 um 13 41 04](https://github.com/user-attachments/assets/053eaed4-ba18-44a6-862e-90922a679dbb)

### 2.	Coupon-Modell (Coupone):
Ermöglicht die Erstellung von Rabatt-Coupons durch den Administrator. Diese können entweder als fester Betrag oder als prozentualer Rabatt definiert werden. Nutzer können diese Coupons bei der Bestellung einlösen.

![Bildschirmfoto 2025-01-27 um 13 43 26](https://github.com/user-attachments/assets/eb8c4c4b-d3f8-4943-bf10-fb6cc39babc1)

### 3.	Benutzer-Lieferinformationen (DeliveryUserInfo):
Dieses Modell gehört zum Nutzer und dient zur Verwaltung der Lieferadresse. Nutzer können ihre Adressinformationen jederzeit bearbeiten.

![Bildschirmfoto 2025-01-27 um 13 42 43](https://github.com/user-attachments/assets/dca3c337-eb0d-47ad-8a32-2c71d994453f)

### 4. Liefermethode und Zahlungsmethode (DeliveryMethod & PaymentMethod):
Beide Modelle werden zur finalen Erstellung einer Bestellung genutzt. Der Nutzer wählt die bevorzugte Liefer- und Zahlungsmethode aus den vom Administrator definierten Optionen.

![Bildschirmfoto 2025-01-27 um 13 42 33](https://github.com/user-attachments/assets/fb888a94-d358-407d-a37f-42911cb3461a)

![Bildschirmfoto 2025-01-27 um 13 42 56](https://github.com/user-attachments/assets/fe258e8e-8a3e-43c5-92c3-f2a360a34241)

### 5. Rechnungen (Receipts):
Dieses Modell wird nach der Bestellung generiert und enthält alle zuvor eingegebenen Daten. Es dient zur Speicherung und Nachverfolgung der Bestellung sowie ihres Status.

![Bildschirmfoto 2025-01-27 um 13 51 23](https://github.com/user-attachments/assets/fbe5952c-e61f-4c2b-a6b1-4067e74d4ba6)
![Bildschirmfoto 2025-01-27 um 13 51 30](https://github.com/user-attachments/assets/1ef0d8f2-c127-4b9d-8716-df9d0f27610e)

## Admin-Funktionen:

	•	Produkte erstellen, bearbeiten und löschen.
	•	Banner verwalten.
	•	Rabatt-Coupons erstellen, bearbeiten und löschen.
	•	Liefermethoden hinzufügen, bearbeiten und entfernen.
	•	Zahlungsmethoden verwalten (sichtbar/unsichtbar schalten).
	•	Bestellungen aller Nutzer einsehen und deren Status aktualisieren – die Änderungen sind für die Nutzer in Echtzeit sichtbar.

![Bildschirmfoto 2025-01-27 um 13 14 26](https://github.com/user-attachments/assets/f34b1bb9-70b2-4edf-be0c-979e7ce0fed8)
![Bildschirmfoto 2025-01-27 um 13 15 12](https://github.com/user-attachments/assets/5123b8a3-e688-4ce4-b3a3-be66c4ddc87b)
![Bildschirmfoto 2025-01-27 um 13 15 35](https://github.com/user-attachments/assets/773677de-d04a-4fb7-9856-7ec8ac6491ae)
![Bildschirmfoto 2025-01-27 um 13 16 09](https://github.com/user-attachments/assets/71ff58be-62c7-4bd3-a146-f6ffdded704d)
![Bildschirmfoto 2025-01-27 um 13 16 29](https://github.com/user-attachments/assets/4c10115f-90c6-4800-94c8-0f426bde4b3f)
![Bildschirmfoto 2025-01-27 um 13 16 55](https://github.com/user-attachments/assets/6b6a8d00-6427-4e38-90df-9a4eee64db75)
![Bildschirmfoto 2025-01-27 um 13 17 48](https://github.com/user-attachments/assets/b75d326c-bc05-4ba5-9e8e-501f7793fd50)
![Bildschirmfoto 2025-01-27 um 13 18 04](https://github.com/user-attachments/assets/5e05c0e8-ecad-4b20-b0c9-3167296f1382)
![Bildschirmfoto 2025-01-27 um 13 18 27](https://github.com/user-attachments/assets/7479e133-8c5f-4d84-84ea-e787151e9c83)
![Bildschirmfoto 2025-01-27 um 13 18 50](https://github.com/user-attachments/assets/c4b0dfe0-58d8-4dca-9e30-4982f4133f7a)


 ## Nutzer-Funktionen:
 
   	•	Produkte zu Favoriten hinzufügen.
	•	Produkte suchen.
	•	Produkte kaufen.
	•	Persönliche Daten bearbeiten, Liefermethoden wählen und Zahlungsmethoden auswählen.
	•	Bestellverlauf einsehen und den Status der Bestellungen verfolgen.
	•	Dark Mode, implementiert über Assets.
	•	Registrierung und Anmeldung über Firebase Authentication.
	•	Mehrsprachigkeit: Die App unterstützt zwei Sprachen, die sich automatisch an die Region des Nutzers anpassen.

![Bildschirmfoto 2025-01-27 um 13 07 25](https://github.com/user-attachments/assets/f5783a8c-c51f-4724-b9ab-68d87f4a5bc5)
![Bildschirmfoto 2025-01-27 um 13 08 02](https://github.com/user-attachments/assets/1cd5f74b-0e49-4b26-8463-9470f9618833)
![Bildschirmfoto 2025-01-27 um 13 09 03](https://github.com/user-attachments/assets/7476fa3e-56e1-46cb-9ef1-88fca43adcb2)
![Bildschirmfoto 2025-01-27 um 13 08 45](https://github.com/user-attachments/assets/ed18a037-9ebb-47ab-8edd-a421d0faee12)
![Bildschirmfoto 2025-01-27 um 13 11 01](https://github.com/user-attachments/assets/009fe738-6044-43aa-8c9f-2ea635b6b8ad)
![Bildschirmfoto 2025-01-27 um 13 11 19](https://github.com/user-attachments/assets/95906515-0102-4a0a-8584-6500565f9498)
![Bildschirmfoto 2025-01-27 um 13 11 37](https://github.com/user-attachments/assets/b5f49f8c-77b9-4771-9de5-38cf941cac52)
![Bildschirmfoto 2025-01-27 um 13 12 19](https://github.com/user-attachments/assets/8b99ad13-a86b-4e1f-a08c-27fb209f2603)
![Bildschirmfoto 2025-01-27 um 13 12 48](https://github.com/user-attachments/assets/da21a0b6-5410-4e73-9b2a-f59a6176a145)

![Bildschirmfoto 2025-01-27 um 13 44 02](https://github.com/user-attachments/assets/ea62aab9-63a5-4f6f-9483-6be7fe85b132)
![Bildschirmfoto 2025-01-27 um 13 44 18](https://github.com/user-attachments/assets/29fa0dac-6f79-48ee-a1ec-0bfc36720eb3)

![Bildschirmfoto 2025-01-27 um 13 45 08](https://github.com/user-attachments/assets/9d476e59-c056-43e7-9b08-018e628dae81)
![Bildschirmfoto 2025-01-27 um 13 44 34](https://github.com/user-attachments/assets/ba178fd8-c8d4-47f5-abae-e6ef781049dc)

