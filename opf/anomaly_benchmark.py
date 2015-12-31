#!/usr/bin/env python

try:
  import matplotlib.pyplot as plt
except:
  print "Failed to import matplotlib, plotting will not work."
# from collections import deque
import os
import csv
try:
  from nupic.algorithms import anomaly_likelihood as al
  from nupic.frameworks.opf.modelfactory import ModelFactory
except:
  print "Cannot find nupic library!"
  raise

"""
Anomaly Tester:
The anomaly tester is a class that encapsulates opf codes. It makes handling with the opf easier.
All you need to do is set the input csv file with `set_input()`, set the output csv file with `et_output()` and run
the model with `run_model()`.

If you intend to train HTM on an anomaly free data set first and then test the model on anomalous data,
proceed the training as usual and then just reset the input file and run the model again.

Example is shown in __main__.

"""





# GENERAL PRESET

HEADERS = ["timestamp", "function", "phase", "has_anomaly"]


class AnomalyTester:
    def __init__(self, model_parameters, plotting=False):
        self.plotting = plotting
        self.reader = None
        self.writer = None
        self.al_helper = al.AnomalyLikelihood()
        self.model = None
        self.model = ModelFactory.create(model_parameters)

        self.model.enableInference({'predictedField': 'function'})

        if plotting:
            raise NotImplementedError('Not yet implemented')
# plt.ion()
# fig = plt.figure()
#
# plt.title('Testing the model')
# plt.xlabel('time [s]')
# plt.ylabel('Y axe')


    def set_input(self, path):
        # Checks whether data is properly set. If so, returns True. Otherwise, False.

        # If we even have a path...
        if not os.path.isfile(path):
            raise IOError("Directory does not exist")

        # Creates csv reader that will be used later.
        self.reader = csv.reader(open(path))

        # Checks whether the file headers correspond to defined headers.
        if not self.reader.next() == HEADERS:
            raise IOError("Data has different headers, please use those: " + str(HEADERS))

        # For now, we don't need those rows.
        self.reader.next()  # data type
        self.reader.next()  # empty line

    def set_output(self, path):
        # Creates output data in the same directory, potentially in a new folder 'results'.

        directory = os.path.dirname(path)
        if not os.path.exists(directory):
            os.makedirs(directory)

        # if not os.path.isfile(path):
        self.writer = csv.writer(open(path, "w"))
        self.writer.writerow(HEADERS + ["anomaly_score", "anomaly_likelihood"])

    def _write_row(self, row):
        self.writer.writerow(row)

    def run_model(self):
        # Runs the model set in the description file.

        for i, records in enumerate(self.reader, start=1):
    # Initialize the plot lines that we will update with each new record.
    # actHistory = deque([0.0] * WINDOW, maxlen=60)
    # anomalyHistory = deque([0.0] * WINDOW, maxlen=60)
    # actline, = plt.plot(range(WINDOW), actHistory)
    # anomalyline, = plt.plot(range(WINDOW), anomalyHistory)
    # actline.axes.set_ylim(0, 100)
    # anomalyline.axes.set_ylim(0, 100)

            model_input = dict(zip(HEADERS, records))
            model_input["function"] = float(model_input["function"])  # TODO: use it from HEADERS

            result = self.model.run(model_input)

            anomaly_score = result.inferences["anomalyScore"]
            anomaly_likelihood = self.al_helper.anomalyProbability(model_input["function"], anomaly_score)

            row = records + [anomaly_score, anomaly_likelihood]
            self._write_row(row)

            k = i % 1000
            if k == 0:
                print(str(i) + " iterations.")


def test_the_anomalies(directory, prefix, suffix):
    # Walk trough anomalous data with training on anomaly free data sets.
    # For example:
    #   directory = "../data/datasets/synthetic"
    #   prefix = "constant"
    #   suffix = "1hour"
    #
    #   This tests all anomalous data sets with pre-training on the `constantSet_1hour.csv`.
    #   Of course, only data sets containing the `constantSet` as a main function are considered.

    input_trainer_file = directory + "/clean/" + prefix + "Set_" + suffix + ".csv"
    output_trainer_file = directory + "/clean/results/" + prefix + "Set_" + suffix + "_RDSE.csv"

    ran_on = set()

    exclude = {'results', 'clean'}
    for route, dirs, files in os.walk(directory):
        # Only input data, get rid of the `exclude` set
        dirs[:] = [d for d in dirs if d not in exclude]

        # Walk trough all the files in a current `route` directory
        for filename in files:
            if filename.endswith('.csv'):
                # We have csv file, now we have to test whether this one was made from the given original
                # First, we have to deal we our creative naming which grinds the gears here.
                if "niceratio" not in suffix:
                    if "niceratio" in filename:
                        continue

                # Then we have to check whether the begging and the end of the filename consists of our prefix and suffix
                name = filename[0:-4]
                if name.startswith(prefix) and name.endswith(suffix):
                    # Now, we are sure that we have the data set based on the training set.
                    # First, we have to train the model.
                    tester = AnomalyTester(mpRDSE.MODEL_PARAMS)
                    tester.set_input(input_trainer_file)
                    tester.set_output(output_trainer_file)

                    print "Training the model on the initial file."
                    tester.run_model()
                    print "The model has been trained."

                    tester.set_input(os.path.join(route, filename))
                    tester.set_output(os.path.join(route + "/results", filename))

                    print "Testing the model on `" + filename + "`."
                    tester.run_model()
                    print "Testing done."
                    print "------------------------------------------------------"

                    ran_on.add(filename)

    print "Ran on:"
    print ran_on


def test_in_directory(directory):
    # Walk trough this directory
    # For instance: directory = "../data/datasets/synthetic/clean/"

    for filename in os.listdir(directory):
        if filename.endswith(".csv"):
            tester = AnomalyTester(mp.MODEL_PARAMS)

            tester.set_input(directory + filename)
            tester.set_output(directory + "results/" + filename)

            print "Training the: " + filename
            tester.run_model()


if __name__ == "__main__":
    import modelParamsRDSE as mpRDSE
    import modelParams as mp

    # directory = "../data/datasets/synthetic"
    # prefix = "trendSineOnSigmoid"
    # suffix = "10minute"
    #
    # test_the_anomalies(directory, prefix, suffix)
    #
    # prefix = "trendSineOnSigmoidBig"
    # test_the_anomalies(directory, prefix, suffix)
    #
    # prefix = "trendSineOnSine"
    # test_the_anomalies(directory, prefix, suffix)

    # Choose above which description you want to import.
    tester = AnomalyTester(mpRDSE.MODEL_PARAMS)

    # TRAINING
    trainingSet = "sineSet_10minute.csv"

    _INPUT_PATH = "../data/datasets/synthetic/clean/" + trainingSet
    _OUTPUT_PATH = "../data/datasets/synthetic/clean/results/sineSet_10minute_RDSE.csv"

    tester.set_input(_INPUT_PATH)
    tester.set_output(_OUTPUT_PATH)

    print("Training the HTM model.")
    tester.run_model()
    # TODO: Serialization

    # TESTING
    # Learning is always on.
    anomalySet = "trainNoiseFnCycle_10minute.csv"
    _INPUT_PATH = "../data/datasets/synthetic/anomalyTrend/" + anomalySet
    _OUTPUT_PATH = "../data/datasets/synthetic/anomalyTrend/results/trainNoiseFnCycle_10minute_RDSE.csv"
    tester.set_input(_INPUT_PATH)
    tester.set_output(_OUTPUT_PATH)
    print("Testing the HTM model.")
    tester.run_model()

