import pickle
import numpy as np
from flask import Flask, request, jsonify, render_template

app = Flask(__name__)
model = pickle.load(open('Pickle_Cosmos_Model.pkl', 'rb'))

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    # Convert form values to floats
    float_features = [float(x) for x in request.form.values()]
    final_features = [np.array(float_features)]
    prediction = model.predict(final_features)
    output = round(prediction[0], 2)

    if output == 1:
        prediction_text = "Asteroid is hazardous"
    else:
        prediction_text = "Asteroid is not hazardous"

    return render_template('index.html', prediction_text=prediction_text)

@app.route('/results', methods=['POST'])
def results():
    data = request.get_json(force=True)
    # Convert JSON values to floats
    prediction = model.predict([np.array(list(map(float, data.values())))])
    output = prediction[0]

    if output == 1:
        prediction_text = "Asteroid is hazardous"
    else:
        prediction_text = "Asteroid is not hazardous"

    return jsonify(prediction_text)

if __name__ == "__main__":
    app.run(debug=True)
