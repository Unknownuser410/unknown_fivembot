# 🚀 FiveM Discord Bot

Ein Discord-Bot zur Interaktion mit einem FiveM-Server. Dieser Bot ermöglicht es, direkt von Discord aus FiveM Interaktionen und Befehle auszuführen (Komplett in Lua). 🎮

## ✨ Funktionen
- 🔹 Senden von Befehlen an den FiveM-Server
- 🔹 Empfang und Anzeige von Serverantworten in Discord
- 🔹 Verwaltung von Spielern und Serveraktionen über Discord
- 🔹 Anpassbare Berechtigungen für verschiedene Benutzerrollen
- 🔹 Unterstützung für ESX und OXMySQL (kann leicht auf Standalone angepasst werden)

## 📌 Voraussetzungen
- ✅ Ein Discord-Bot und seinen Token vom [Discord Developer Portal](https://discord.com/developers/applications)
- ✅ ESX und oxmysql (optional, für einige Funktionen erforderlich, kann aber einfach auf standalone geändert werden)

## 📥 Installation
1. **📂 Dateien einfügen**
   - Lade die Dateien herunter und verschiebe sie in deinen `resources`-Ordner von FiveM.
   - Stelle sicher, dass der Ordner in der `server.cfg` als Ressource gestartet wird.

2. **🔑 Bot einrichten**
   - Erstelle einen neuen Bot im [Discord Developer Portal](https://discord.com/developers/applications)
   - Stelle sicher, dass der Bot `Presence Intent, Server Members Intent und Message Content Intent` hat.
   - Kopiere den Token und füge ihn in die `config.lua` ein.
   - Kopiere deine Discord Server ID und die Channel ID für den Bot in die `config.lua`.
   - Fülle die `config.lua` zu deinen Wünschen aus.

3. **▶️ Server starten**
   - Starte deinen FiveM-Server, und der Bot wird automatisch gestartet.

## 🎮 Nutzung
- 📝 `prefix <befehl>` - Führe einen bestimmten Befehl mit eurem Prefix aus der Config aus.
- 🔍 `Spieler ID (Meistens)` - Gib den betreffenden Spieler an.
- ❌ `Zusatzparamter (Command abhängig)` - Gebe Zusatzparamter an.
![grafik](https://github.com/user-attachments/assets/e8f409ed-41d7-486b-98c3-9004a1ca7478)


## 🤖 Bot Commands
### 📌 Allgemein
- `!test` - Printet Test Nachrichten
- `!status` - Zeigt alle Spieler des Servers

### 👥 Spieler
- `!info [ID]` - Zeigt die Informationen eines Spielers an
- `!kill [ID]` - Tötet den Spieler mit der ID
- `!revive [ID]` - Wiederbelebt den Spieler mit der ID
- `!reviveall` - Wiederbelebt alle Spieler
- `!heal [ID]` - Heilt einen Spieler
- `!dm [ID] [TEXT]` - Sendet eine Direktnachricht an den Spieler
- `!kick [ID] [GRUND]` - Kickt den Spieler mit Grund
- `!giveitem [ID] [ITEM] [ANZAHL]` - Gib dem Spieler ein Item
- `!removeitem [ID] [ITEM] [ANZAHL]` - Entferne dem Spieler ein Item
- `!clearinv [ID]` - Lösche das Inventar des Spielers
- `!givemoney [ID] [ACCOUNT] [BETRAG]` - Gib dem Spieler Geld
- `!removemoney [ID] [ACCOUNT] [BETRAG]` - Entferne dem Spieler Geld
- `!setjob [ID] [JOB] [RANG]` - Gib dem Spieler einen Job
- `!setgroup [ID] [GRUPPE]` - Setze dem Spieler eine Rolle
- `!setname [ID] [NAME]` - Setze den Spielernamen

### 🚗 Auto
- `!dv [PLATE]` - Lösche das Auto mit dem Kennzeichen auf dem Server (Nicht in der Datenbank)
- `!car [ID] [AUTO]` - Spawne dem Spieler ein Auto
- `!givecar [ID] [AUTO]` - Gebe dem Spieler ein Auto (Mit Datenbank Speicherung)

## 🛠️ Developer Docs
Hier sind die verfügbaren Funktionen für Entwickler, falls ihr Commands ändern oder hinzufügen wollt:

### 🔍 checkifhasrole(src, rolename)
- **Parameter:** Spieler ID, gesuchter Rollenname aus der Config
- **Beschreibung:** Prüft, ob ein Spieler eine bestimmte Discord-Rolle besitzt.

### 📜 getRoles(src)
- **Parameter:** Spieler ID
- **Beschreibung:** Gibt alle Discord-Rollen eines Spielers zurück.

### ✉️ senddiscordmsg(title, msg, type, author)
- **Parameter:** Titel, Nachricht, Farbe aus der Config, Discord ID des Absenders (abfragbar mit GetDiscordId)
- **Beschreibung:** Sendet eine Nachricht an einen Discord-Channel.


### 📩 senddiscorddmmsg(src, title, msg, type, author)
- **Parameter:** Spieler ID des Empfängers, Titel, Nachricht, Farbe aus der Config, Discord ID des Absenders (abfragbar mit GetDiscordId)
- **Beschreibung:** Sendet eine Direktnachricht an einen bestimmten Discord-Nutzer.

### 🆔 GetDiscordId(src)
- **Parameter:** Spieler ID
- **Beschreibung:** Gibt die Discord ID des Spielers zurück.

### 🆔 checkifonline(src)
- **Parameter:** Spieler ID
- **Beschreibung:** Gibt true zurück wenn der Spieler Online ist.

### 🖥️ sendcmd(msg, type)
- **Parameter:** Nachricht, Error oder Success
- **Beschreibung:** Sendet eine Nachricht in die Server-Konsole.
