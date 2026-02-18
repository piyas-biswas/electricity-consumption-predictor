from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

# Load model safely (we'll improve this below)
try:
    model = joblib.load('linear_model.pkl')
    print("Model loaded successfully")
except Exception as e:
    print("Model loading failed:", e)
    model = None


@app.route('/')
def home():
    return "Energy Prediction API Running"

@app.route('/predict', methods=['POST'])


def predict():
    if model is None:
        return jsonify({'error': 'Model not loaded'}), 500
    try:
        data = request.get_json()

        required_fields = [
            'Voltage',
            'Sub_metering_1',
            'Sub_metering_2',
            'Sub_metering_3',
            'hour',
            'day_of_week'
        ]

        # Check missing fields
        for field in required_fields:
            if field not in data:
                return jsonify({'error': f'Missing field: {field}'}), 400

        # Convert values safely
        voltage = float(data['Voltage'])
        sub1 = float(data['Sub_metering_1'])
        sub2 = float(data['Sub_metering_2'])
        sub3 = float(data['Sub_metering_3'])
        hour = int(data['hour'])
        day = int(data['day_of_week'])

        # Range validation
        if not (0 <= hour <= 23):
            return jsonify({'error': 'Hour must be between 0 and 23'}), 400

        if not (0 <= day <= 6):
            return jsonify({'error': 'Day of week must be between 0 and 6'}), 400

        features = np.array([[voltage, sub1, sub2, sub3, hour, day]])
        prediction = model.predict(features)

        return jsonify({'prediction': float(prediction[0])})

    except ValueError:
        return jsonify({'error': 'Invalid numeric value'}), 400

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5050, debug=True)