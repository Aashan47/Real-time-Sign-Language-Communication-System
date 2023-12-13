from flask import Flask
from flask_socketio import SocketIO
import base64
import io
import numpy as np
from PIL import Image
import cv2
import mediapipe as mp
from mediapipe.tasks import python
from mediapipe.tasks.python import vision
from keras.models import load_model

# Flask and SocketIO setup
app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app)

# Load the trained model and setup labels
model = load_model('my_model.h5')
class_labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
                'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
                'del', 'nothing', 'space']

# Mediapipe Hand Detection setup
base_options = python.BaseOptions(model_asset_path='hand_landmarker.task')
options = vision.HandLandmarkerOptions(base_options=base_options, num_hands=2)
detector = vision.HandLandmarker.create_from_options(options)

def getHandCoordinates(hand_landmarks, image):
    """
    Calculate the bounding box coordinates for the hand in the image.
    """
    x_max = 0
    y_max = 0
    x_min = image.shape[1]
    y_min = image.shape[0]

    for landmark in hand_landmarks:
        x, y = int(landmark.x * image.shape[1]), int(landmark.y * image.shape[0])
        x_max, y_max = max(x, x_max), max(y, y_max)
        x_min, y_min = min(x, x_min), min(y, y_min)

    # Adjust bounding box size
    x_min, y_min = max(0, x_min - 70), max(0, y_min - 70)
    x_max, y_max = min(image.shape[1], x_max + 70), min(image.shape[0], y_max + 70)

    return [x_min, y_min, x_max, y_max]

def predict(image):
    """
    Predict the hand gesture in the given image.
    """
    image_mp = mp.Image(image_format=mp.ImageFormat.SRGB, data=image)
    detection_result = detector.detect(image_mp)

    if detection_result.hand_landmarks:
        h = getHandCoordinates(detection_result.hand_landmarks[0], image)
        cropped_image = image[h[1]:h[3], h[0]:h[2]]
        resized_frame = cv2.resize(cropped_image, (64, 64))
        resized_frame = resized_frame / 255.0
        resized_frame = [resized_frame]
        resized_frame = np.array(resized_frame)

        pred = model.predict(resized_frame)
        output_data = pred[0]
        predicted_label = class_labels[np.argmax(output_data)]
        return predicted_label
    else:
        return "No Hand Found"

# SocketIO event handlers
@socketio.on('connect')
def handle_connect():
    print('Client connected')

@socketio.on('disconnect')
def handle_disconnect():
    print('Client disconnected')

@socketio.on('frame')
def handle_frame(data):
    image_data = base64.b64decode(data)
    image = Image.open(io.BytesIO(image_data))
    image = np.array(image)
    prediction = predict(image)
    socketio.emit('prediction', {'result': prediction})

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0')
