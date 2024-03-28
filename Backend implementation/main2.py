from src.backbone import TFLiteModel, get_model
from src.landmarks_extraction import mediapipe_detection, draw, extract_coordinates, load_json_file 
from src.config import SEQ_LEN, THRESH_HOLD
import numpy as np
import cv2
import time
import pyttsx3
import mediapipe as mp
import tensorflow as tf

mp_holistic = mp.solutions.holistic 
mp_drawing = mp.solutions.drawing_utils

s2p_map = {k.lower():v for k,v in load_json_file("src/sign_to_prediction_index_map.json").items()}
p2s_map = {v:k for k,v in load_json_file("src/sign_to_prediction_index_map.json").items()}
encoder = lambda x: s2p_map.get(x.lower())
decoder = lambda x: p2s_map.get(x)

models_path = [
                './models/islr-fp16-192-8-seed_all42-foldall-last.h5',
]
models = [get_model() for _ in models_path]

# Load weights from the weights file.
for model,path in zip(models,models_path):
    model.load_weights(path)

engine = pyttsx3.init()

def real_time_asl():

    sentence = ""
    tflite_keras_model = TFLiteModel(islr_models=models)
    sequence_data = []
    cap = cv2.VideoCapture(0)
    
    start = time.time()
    last_sign_time = start
    last_sign = None
    
    with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
        # The main loop for the mediapipe detection.
        while cap.isOpened():
            ret, frame = cap.read()
            
            start = time.time()
            
            image, results = mediapipe_detection(frame, holistic)
            draw(image, results)
            
            try:
                landmarks = extract_coordinates(results)
            except:
                landmarks = np.zeros((468 + 21 + 33 + 21, 3))
            sequence_data.append(landmarks)
            
            sign = ""
            
            # Generate the prediction for the given sequence data.
            if len(sequence_data) % SEQ_LEN == 0:
                prediction = tflite_keras_model(np.array(sequence_data, dtype = np.float32))["outputs"]

                if np.max(prediction.numpy(), axis=-1) > THRESH_HOLD:
                    sign = np.argmax(prediction.numpy(), axis=-1)
                
                sequence_data = []
            
            image = cv2.flip(image, 1)
            
            cv2.putText(image, f"{len(sequence_data)}", (3, 35),
                                cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)
            
            image = cv2.flip(image, 1)
            
            # Insert the sign in the result set if sign is not empty and is different from the last recognized sign.
            if sign != "" and decoder(sign) != last_sign:
                current_time = time.time()
                if current_time - last_sign_time > 1.0:  # Wait at least 1 second between consecutive signs
                    if decoder(sign) == "moon":
                        sentence = ""
                    else:
                        if cv2.getTextSize(sentence + decoder(sign), cv2.FONT_HERSHEY_SIMPLEX, 1, 1)[0][0] > image.shape[1] - 10:
                            sentence = sentence[sentence.find(" ") + 1:]
                        sentence += decoder(sign) + " "
                        
                        # Convert the sign to speech if it's not "moon"
                        engine.say(decoder(sign))
                        engine.runAndWait()
                        
                    last_sign_time = current_time
                    last_sign = decoder(sign)
            
            # Get the height and width of the image
            height, width = image.shape[0], image.shape[1]

            # Create a white column
            white_column = np.ones((height // 8, width, 3), dtype='uint8') * 255

            # Flip the image vertically
            image = cv2.flip(image, 1)
            
            # Concatenate the white column to the image
            image = np.concatenate((white_column, image), axis=0)
            
            # Display the part of the sentence that fits within the screen width with a smaller font size
            text_width, _ = cv2.getTextSize(sentence, cv2.FONT_HERSHEY_SIMPLEX, 1, 1)[0]
            if text_width > width - 10:
                sentence_to_display = sentence[-int((width - 10) / (text_width / len(sentence))):]
            else:
                sentence_to_display = sentence
            
            cv2.putText(image, sentence_to_display, (3, 50),
                                cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 0), 2, cv2.LINE_AA)
                            
            cv2.imshow('Webcam Feed',image)
            
            # Wait for a key to be pressed.
            if cv2.waitKey(10) & 0xFF == ord("q"):
                break

        cap.release()
        cv2.destroyAllWindows()

real_time_asl()
