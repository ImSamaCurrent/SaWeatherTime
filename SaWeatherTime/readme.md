# 🌦️ SaWeatherTime - Gestion du Temps & de la Météo pour FiveM

**SaWeatherTime** est un script simple, fluide et personnalisable développé pour **FiveM**. Il permet de gérer dynamiquement le **temps** et la **météo** en jeu, tout en offrant une **animation immersive** pour les transitions.  
Parfait pour les serveurs RP cherchant à renforcer le réalisme sans compromettre la performance.

---

## ✨ Fonctionnalités

- 🌤️ Changement dynamique ou manuel de la météo
- 🕒 Synchronisation du temps (jour/nuit, gel de l'heure, etc.)
- 🎬 Animation intégrée lors des transitions météo est du temps
- 🛠️ Interface facile à intégrer (ESX, QBCore ou standalone)
- ⚙️ Configuration complète dans un fichier `config.lua`
- 🧠 Optimisé pour les serveurs performants (faible consommation)

---

## 📦 Installation

1. Téléchargez le script.
2. Placez-le dans votre dossier `resources/`.
3. Ajoutez ceci à votre `server.cfg` : 
```cfg
  ensure SaWeatherTime
```
4. Modifiez `config.lua` selon vos préférences.

---

## 🔧 Commandes & Exports

### 🧾 Commandes (configurables dans `config.lua`)

| Commande          | Description                                         |
|-------------------|-----------------------------------------------------|
| `/settime`        | Définit l'heure manuellement (ex : `/settime 22:00`) |
| `/setweather`     | Change la météo (ex : `/setweather CLEAR`)          |
| `/freezetime`     | Active ou désactive le gel de l’heure               |
| `/freezeweather`  | Active ou désactive le gel de la météo              |
| `/blackout`       | Active ou désactive le blackout électrique          |



> Toutes les commandes peuvent être configurer dans le fichier `Config.lua`.

---

### 📦 Exports

#### 🌓 `IsNight()`

- **Type** : export client & serveur  
- **Description** : Vérifie si le temps actuel est la nuit (utile pour des scripts externe)  
- **Retourne** : `true` ou `false`

```lua
local isNight = exports["SaWeatherTime"]:IsNight()
```

#### 🔄 ToggleWeatherTimeSync(bool enable)

- Type : export client

- Description : Permet de désactiver la synchronisation automatique du temps côté client si un autre système doit en prendre le contrôle (ex. script de propriétés, intérieurs, etc.)

- Paramètre : true pour activer, false pour désactiver
```lua
-- Pour désactiver la synchro temps météo de SaWeatherTime :
exports["SaWeatherTime"]:ToggleTimeSync(false)

-- Pour la réactiver plus tard :
exports["SaWeatherTime"]:ToggleTimeSync(true)
```

---

## 🔗 Liens Utiles

- 🎥 **Vidéo Démo YouTube** : [Clique ici](https://youtu.be/Z08pjXYr51E)
- 💬 **Serveur Discord Support** : [Rejoins-nous](https://discord.gg/FAZBexrgtx)
- 🧑‍💻 **GitHub du projet** : [Voir le code](https://github.com/ImSamaCurrent/SaWeatherTime)

---

## 👤 Auteur

Développé par **ImSama**

---

## 📜 Licence

Ce projet est sous licence **Creative Commons Attribution - ShareAlike 4.0 (CC BY-SA 4.0)**.

Vous pouvez :
- ✅ Utiliser, modifier, partager ou vendre ce script
- ⚠️ À condition de :
  - Me **mentionner** clairement (`ImSama`)
  - Garder la **même licence (CC BY-SA 4.0)** dans toute redistribution

🔗 [Lire la licence complète](https://creativecommons.org/licenses/by-sa/4.0/)

