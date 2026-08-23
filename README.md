# 🌱 EcoCampus: Gamified Sustainability & Carbon Tracking Platform

EcoCampus is a full-stack mobile application and backend analytics solution designed to empower students to track their carbon footprints, adopt eco-friendly habits, and explore sustainable campus resources. Built as a modern MVP, it integrates a cross-platform mobile frontend with a Python machine learning prediction engine and a relational database.

---

## 🚀 Key Features
* **Interactive Impact Dashboard:** Real-time tracking of personal carbon reduction and habit logging.
* **Machine Learning CO₂ Prediction Engine:** Powered by Python and Scikit-learn to estimate carbon savings based on daily activities (transport modes, plastic avoidance, and energy conservation).
* **Green Campus Resource Map:** Directory of campus sustainability spots (water refill stations, e-bike hubs, solar charging benches).
* **Sustainability Challenges:** Gamified community initiatives to encourage eco-friendly student participation.
* **Full-Stack Architecture:** Seamless communication between a Flutter mobile app and a Python FastAPI backend server.

---

## 🛠️ Tech Stack
* **Frontend:** Flutter (Dart), Material Design (Dark Theme UI)
* **Backend:** Python, FastAPI, Uvicorn, Pydantic
* **Machine Learning:** Scikit-learn, NumPy (Linear Regression model for CO₂ estimation)
* **Database:** MySQL
* **Tools:** Android Studio, VS Code, Git/GitHub

---

## 📂 Project Structure
```text
ecocampus/
├── lib/                     # Flutter Mobile App Frontend
│   ├── main.dart            # Main UI, Navigation, and Screens
│   └── api_service.dart     # HTTP service bridging app to Python backend
├── backend