#!/usr/bin/env python


from nupic.frameworks.opf.modelfactory import ModelFactory
import matplotlib.pyplot as plt
import modelParams
from collections import deque
import csv

#######

WINDOW = 60

# plt.ion()
# fig = plt.figure()
#
# plt.title('Testing the model')
# plt.xlabel('time [s]')
# plt.ylabel('Y axe')

NAME = "sin_30sec.csv"


_INPUT_PATH = "../data/datasets/" + NAME
_OUTPUT_PATH = "../results/" + NAME



def run():
    model = ModelFactory.create(modelParams.MODEL_PARAMS)
    model.enableInference({'predictedField': 'function'})

    # Asi neni potreba
    # shifter = InferenceShifter()

    # Initialize the plot lines that we will update with each new record.
    # actHistory = deque([0.0] * WINDOW, maxlen=60)
    # anomalyHistory = deque([0.0] * WINDOW, maxlen=60)
    # actline, = plt.plot(range(WINDOW), actHistory)
    # anomalyline, = plt.plot(range(WINDOW), anomalyHistory)
    # actline.axes.set_ylim(0, 100)
    # anomalyline.axes.set_ylim(0, 100)

    with open(_INPUT_PATH) as fin:
        reader = csv.reader(fin)
        csvWriter = csv.writer(open(_OUTPUT_PATH, "wb"))
        csvWriter.writerow(["time", "function", "anomaly_score"])

        headers = reader.next()
        reader.next()  # data type
        reader.next()  # empty line

        #START
        for i, record in enumerate(reader, start=1):
            modelInput = dict(zip(headers, record))
            modelInput["function"] = float(modelInput["function"])
            modelInput["time"] = float(modelInput["time"])

            # asi by zde melo byt i zpracovani sloupce period a anomaly ???
            # TODO

            result = model.run(modelInput)
            anomalyScore = result.inferences['anomalyScore']

            csvWriter.writerow([modelInput["time"], modelInput["function"], anomalyScore])


if __name__ == "__main__":
    run()
