📖 Real-time Sign Language Communication System
A cross-platform mobile and desktop application that enables real-time, bidirectional communication between hearing and hearing-impaired individuals using sign language recognition and speech synthesis.

This project bridges the communication gap by integrating machine learning, computer vision, and speech technologies into an intuitive mobile-first user experience.

🚀 Features
🔤 Real-time Sign Language Detection
Leverages ML models to detect and translate sign gestures into text and speech output.

🗣️ Speech-to-Text & Text-to-Sign
Enables hearing individuals to speak or type, and converts that to sign language visuals or text for the deaf.

📱 Cross-Platform UI
Built using Flutter to support Android, iOS, Web, Windows, macOS, and Linux.

🌐 Backend Communication via Ngrok
Python server enables seamless interaction and tunneling for remote inference and message handling.

🧠 Tech Stack
Frontend (equispeak/)

Flutter (Dart)

Multi-platform targets (mobile, web, desktop)

Asset-based animation or video for sign rendering

Backend (Backend implementation/)

Python 3.x

OpenCV, MediaPipe or TensorFlow (assumed for gesture recognition)

ngrok for exposing local servers over the internet

Flask/FastAPI-style server (likely based on server.py)

📁 Project Structure
bash
Copy
Edit
├── equispeak/                 # Flutter front-end
│   ├── lib/                   # Dart source code
│   ├── android/ ios/ web/     # Platform-specific code
│   ├── assets/                # Images, animations, etc.
│   └── pubspec.yaml           # Flutter dependencies

├── Backend implementation/    # Python-based ML backend
│   ├── models/                # ML models for recognition
│   ├── src/                   # Supporting modules/utilities
│   ├── main.py / server.py    # API endpoints, processing logic
│   └── requirements.txt       # Python dependencies
⚙️ Getting Started
Frontend Setup (Flutter)
bash
Copy
Edit
cd equispeak
flutter pub get
flutter run
Backend Setup (Python)
bash
Copy
Edit
cd "Backend implementation"
pip install -r requirements.txt
python server.py
To expose your backend over the internet, start ngrok:

bash
Copy
Edit
ngrok http 5000
📌 Use Case
This system is built to empower inclusive communication in educational institutions, customer service desks, public spaces, and personal conversations—anywhere that sign language users need to be understood instantly.

🧑‍💻 Author
Aashan Javed
GitHub: @Aashan47

