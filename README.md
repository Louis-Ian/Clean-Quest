# 🧼 CleanQuest

**CleanQuest** is a fun, gamified chore-management app for families, turning daily tasks into a cooperative RPG adventure. Defeat room bosses by completing real-life chores, earn XP and rewards, and track progress as a family — all with a kid-friendly interface.

> 🛠 Built with Flutter · Firebase · Optional AI/LLM Extensions

---

## ✨ Features (Open Source Core)

- 🔄 Weekly Chore Drafting System
- 🐉 Boss Battles by Room (damage = chore difficulty × 1000)
- 🎭 Kid Avatars and XP/Reward Tracking
- 📱 Cross-platform UI (mobile-first)
- 🧾 Firestore backend schema included
- 🧰 Clean, documented architecture for contribution or extension

---

## 🧠 What’s NOT Included Here

This open-source core does **not** include:

- AI agents (e.g., chore fairness advisor, GPT-based summaries)
- Stripe billing system or parental reward gating
- Real-time sync dashboard for multi-device tracking

Those are part of the **CleanQuest Pro** (private) tier.

---

## 🚀 Want the Pro Version?

We offer:
- 🌟 Hosted version (just log in and go)
- 🧠 AI-powered features (chore coaching, gamemaster assistant)
- 🧾 Parental control dashboard and reward economy
- 💳 Stripe-based monetization and multi-family support

👉 [Contact us](mailto:louisian.silvadossantos@gmail.com)

---

## 🧱 Architecture Overview

```
client (Flutter) ───┐
│ Firebase (Auth, Firestore)
backend (Functions) ──► + Optional: Vertex AI, Stripe
│
AI agents (optional) ┘
```

---

## 💻 Local Setup

```bash
git clone https://github.com/your-user/cleanquest
cd cleanquest
cp .env.example .env
flutter pub get
flutter run
```

Requires:

 - Flutter SDK
 - Firebase CLI
 - Firebase project set up (see docs/setup.md)

## 👥 Contributing
We love contributions — especially around:

- Accessibility
- Localization (i18n)
- Bug fixes

See CONTRIBUTING.md for our guidelines.

## 📜 License
MIT — use freely, credit appreciated. Please do not repackage this as a paid product.

bash
Copy

---

## 🔁 2. How to Set Up `cleanquest-pro` (Private Wrapper Repo)

### Step-by-step:

```bash
# Clone your private repo
git clone git@github.com:your-user/cleanquest-pro.git
cd cleanquest-pro
```

# Add the public repo as a submodule
git submodule add https://github.com/Louis-Ian/cleanquest ./cleanquest

# Add your premium backend code
mkdir backend/functions/premium
mkdir lib/premium

# Your folder structure will now look like:
```
.
├── cleanquest/              # Submodule pointing to public core
├── lib/premium/             # AI, monetization, and pro-only Dart code
├── backend/functions/premium/
├── .env                     # Private keys
├── firebase.json
└── README.md
```

Bonus: In lib/main.dart, toggle premium:

```dart
import 'premium/features.dart' as premium;

void main() {
  if (isProUser) {
    premium.enableAIChoreOptimizer();
  }
}
```

Pro-only files stay out of the public repo entirely.
