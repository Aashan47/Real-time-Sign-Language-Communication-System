from flask import Flask
from flask_socketio import SocketIO
import base64
import io
import tensorflow as tf
from keras.models import load_model
from PIL import Image
import numpy as np
import cv2
import mediapipe as mp
from mediapipe.tasks import python
from mediapipe.tasks.python import vision
import os

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app)

# Load your model
model = load_model('vgg_model.h5')
class_labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'del','nothing', 'space']
base_options = python.BaseOptions(model_asset_path='hand_landmarker.task')
options = vision.HandLandmarkerOptions(base_options=base_options,
                                       num_hands=2)
detector = vision.HandLandmarker.create_from_options(options)

def getHandCoordinates(hand_landmarks, image):
    x_max = 0
    y_max = 0
    x_min = image.shape[1]
    y_min = image.shape[0]
    for landmark in hand_landmarks:
        x, y = int(landmark.x * image.shape[1]), int(landmark.y * image.shape[0])
        if x > x_max:
            x_max = x
        if y > y_max:
            y_max = y
        if x < x_min:
            x_min = x
        if y < y_min:
            y_min = y
            
    x_min = max(0, x_min-70)   
    y_min = max(0, y_min-70)   
    x_max = min(image.shape[1], x_max+70)
    y_max = min(image.shape[0], y_max+70)

    return [x_min, y_min, x_max, y_max]


def predict(image):
        
    # cv2.imwrite('test.png',image)
    # image_mp = mp.Image.create_from_file("test.png")
    image_mp = mp.Image(image_format=mp.ImageFormat.SRGB, data=image)
    # os.remove('test.png')
   
    # STEP 4: Detect hand landmarks from the input image.
    detection_result = detector.detect(image_mp)

    if detection_result.hand_landmarks:
        h = getHandCoordinates(detection_result.hand_landmarks[0], image)
        image = image[h[1]:h[3], h[0]:h[2]]
        resized_frame = cv2.resize(image, (64, 64))
        resized_frame = resized_frame/255.0
        resized_frame = [resized_frame]
        resized_frame = np.array(resized_frame)

        pred = model.predict(resized_frame)
        output_data = pred[0]
        predicted_label = class_labels[np.argmax(output_data)]
        return predicted_label

    else:
        return "No Hand Found"

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
