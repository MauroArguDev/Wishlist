# 📱 WishList App – Powered by SwiftData ✨

> “Wishes don’t just come true. Someone has to store them in a database.” 😏  

This project is a hands-on demo to learn and apply **SwiftData** in iOS with SwiftUI.  
The idea: build a simple **WishList** app where each item is stored, queried, and synced with the UI thanks to SwiftData.  

---

## 🚀 What’s inside?
- **SwiftData in action**: define models with `@Model`.  
- **Magic containers** that manage your database behind the scenes.  
- **Context** to create, edit, delete, undo, and redo objects like a pro.  
- **Flexible configuration**: choose memory, disk, or iCloud storage.  
- **SwiftUI + @Query**: views that stay synced with your data automagically.  

---

## 🧩 The Anatomy of SwiftData
Think of SwiftData as a team of superheroes:  

1. **📝 Data Model**  
   The blueprint of your objects. Here we define what a *Wish* is (title, creation date, etc.).  

2. **📦 Model Container**  
   The guardian of your database. Created at app startup, it ensures nothing gets lost.  

3. **⚙️ Configuration**  
   Decide how and where your data is stored: on-device, in-memory, or in the cloud.  

4. **🔄 Context**  
   Tracks every object created, modified, or deleted. It also handles undo/redo operations.  

5. **👀 View (SwiftUI)**  
   Uses `@Query` to fetch data from the context and keep the UI always in sync.  

---

## 📚 Example Model
A simple *Wish* (because all dreams start small 😅):

```swift
import SwiftData

@Model
class Wish {
    var title: String

    init(title: String) {
        self.title = title
    }
}
```

✅ With @Model, SwiftData knows how to persist, load, and observe changes automatically.
💾 When you update title, SwiftData makes sure it gets saved without extra work.

🛠️ How to Run
Clone this repo.

Open in Xcode 15+.

Run on a simulator or real device.

Start saving your wishes… or delete the ones that no longer make sense. 😜

🌟 Next Steps
Enable persistent storage for wishes.

Add more properties (date, isCompleted).

Improve the UI with SwiftUI animations, accessibility, and localization.

Publish on TestFlight so others can manage their wishes too.

🤝 Contributing
If you have a feature wish, open a pull request.
If something breaks… well, open an issue too. 👀

📜 License
MIT License.
(Use this code to chase your dreams, not to steal someone else’s). ✌️
---
