#!/usr/bin/env python

from nupic.frameworks.opf.modelfactory import ModelFactory
import matplotlib.pyplot as plt
from collections import deque
import os.path
import csv
from nupic.algorithms import anomaly_likelihood as al

# GENERAL PRESET

HEADERS = ["time_stamp", "function", "phase", "has_anomaly"]


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

        for i, records in enumerate(self.reader, start=1):
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

