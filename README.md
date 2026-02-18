# Electricity Consumption Prediction Project

## Project Overview

This repository contains a Flutter mobile app and a Flask API that predicts electricity consumption using a trained machine learning model. Users can input voltage, sub-metering data, hour, and day of the week to get real-time predictions.

## Project Structure

* `app.py` – Flask API
* `linear_model.pkl` – Trained ML model
* `notebooks/` – Jupyter notebooks for experimentation

  * `model_training.ipynb`
* `flutter_app/` – Flutter project folder

  * `lib/`
  * `pubspec.yaml`
  * ...

## Features

* Predict electricity consumption (kW) using ML model.
* User-friendly Flutter app interface.
* Input validation and error handling in the Flask API.
* Supports:

  * Voltage
  * Sub_metering_1
  * Sub_metering_2
  * Sub_metering_3
  * Hour (0–23)
  * Day of week (0=Monday ... 6=Sunday)

## Requirements

### Flask API

1. Navigate to the project folder:

```
cd electricity-forecasting
```

2. Install Python dependencies:

```
pip install flask numpy scikit-learn joblib
```

3. Run the API:

```
python app.py
```

4. API will run at:

```
http://127.0.0.1:5050
```

Use this URL in your Flutter app for API calls.

### Flutter App

1. Navigate to Flutter folder:

```
cd flutter_app
```

2. Install dependencies:

```
flutter pub get
```

3. Run the app:

```
flutter run
```

4. Ensure the API URL in your `api_service.dart` points to the running Flask API.

## API Request Example

```
POST /predict HTTP/1.1
Content-Type: application/json

{
  "Voltage": 240.0,
  "Sub_metering_1": 1.2,
  "Sub_metering_2": 0.5,
  "Sub_metering_3": 0.0,
  "hour": 14,
  "day_of_week": 2
}
```

Response:

```
{
  "prediction": 2.35
}
```

## Notes

* Ensure the Flask API is running before using the Flutter app.
* Validate all inputs to avoid errors.
* For production deployment, consider using `gunicorn` or another WSGI server instead of Flask's development server.

## License

MIT License
