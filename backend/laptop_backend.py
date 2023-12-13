import cv2
import numpy as np
import tensorflow as tf
import time

# Load your TFLite model
interpreter = tf.lite.Interpreter(model_path='new_model.tflite')
interpreter.allocate_tensors()

# Get input and output details
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Labels for your classes
class_labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'del','nothing', 'space']

# Initialize the webcam
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()

    # Preprocess the frame (resize to model's input size, normalize, etc.)
    resized_frame = cv2.resize(frame, (224, 224))
    preprocessed_frame = resized_frame / 255.0  # Normalize
    preprocessed_frame = np.expand_dims(preprocessed_frame, axis=0)
    preprocessed_frame = np.array(preprocessed_frame, dtype=np.float32)

    # Set the input tensor
    interpreter.set_tensor(input_details[0]['index'], preprocessed_frame)

    # Measure inference time
    start_time = time.time()

    # Run inference
    interpreter.invoke()

    end_time = time.time()
    inference_time = end_time - start_time

    # Get the output tensor
    output_data = interpreter.get_tensor(output_details[0]['index'])
    predicted_label = class_labels[np.argmax(output_data)]

    # Display the predicted label and inference time on the video frame
    display_text = f"Prediction: {predicted_label} | Inference Time: {inference_time:.5f} seconds"
    cv2.putText(frame, display_text, (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)

    cv2.imshow("Sign Language Recognition", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
