# 🤟 Real-time Sign Language Communication System

A cross-platform application that enables **real-time, bidirectional communication** between hearing and hearing-impaired individuals through **sign language recognition** and **speech synthesis**.

This system bridges the communication gap by combining **computer vision**, **machine learning**, and **speech technologies** within an intuitive, Flutter-powered user experience.

---

## 🚀 Features

- 🔤 **Real-time Sign Language Detection**  
  Detects hand gestures using machine learning and translates them to text and speech.

- 🗣️ **Speech-to-Text & Text-to-Sign Conversion**  
  Converts voice input to sign language visualizations for better accessibility.

- 📱 **Cross-Platform Support**  
  Built with Flutter to support Android, iOS, Web, Windows, macOS, and Linux.

- 🌐 **Ngrok-powered Backend Integration**  
  Python backend uses `ngrok` tunneling for seamless real-time interaction.

---

## 🧠 Tech Stack

### Frontend (`equispeak/`)
- [Flutter](https://flutter.dev/) (Dart)
- Platform Support: Android, iOS, Web, Desktop
- Asset-based animations or sign visuals

### Backend (`Backend implementation/`)
- Python 3.x
- Likely libraries: OpenCV, TensorFlow/MediaPipe
- Local server via Flask or FastAPI
- Ngrok for public URL tunneling

---

## 📁 Project Structure

├── equispeak/ # Flutter front-end
│ ├── lib/ # Dart source code
│ ├── android/ ios/ web/ # Platform-specific code
│ ├── assets/ # Images, animations, videos
│ └── pubspec.yaml # Flutter dependencies

├── Backend implementation/ # Python-based ML backend
│ ├── models/ # Pretrained or custom ML models
│ ├── src/ # Backend utilities and helpers
│ ├── main.py / server.py # API endpoints and inference logic
│ └── requirements.txt # Python dependencies

## ⚙️ Getting Started

### 🔧 Frontend Setup

```bash
cd equispeak
flutter pub get
flutter run

🧠 Backend Setup

cd "Backend implementation"
pip install -r requirements.txt
python server.py

To expose the backend using ngrok:
ngrok http 5000

## 📌 Use Cases
This system is ideal for:

Educational institutions

Customer service counters

Healthcare environments

Public-facing offices

One-on-one communication

Anywhere sign language users need instant understanding, this app ensures inclusive communication.

## 👤 Author
Aashan Javed
GitHub: @Aashan47

## 📌 License
This project is open source and available under the MIT License.

## 🙌 Future Improvements (Suggested)
Add support for multiple sign languages (e.g., BSL, ISL)

Train with real-world gesture datasets for higher accuracy

Implement offline mode using on-device ML

Include customizable avatars for animated sign display
