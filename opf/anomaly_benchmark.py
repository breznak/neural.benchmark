#!/usr/bin/env python
import anomalyTester
import modelParams as mp


def run():
    tester = anomalyTester.AnomalyTester(mp.MODEL_PARAMS)

    NAME = "spikeTrainSet_10minute.csv"

    _INPUT_PATH = "../data/datasets/neatData/synthetic/" + NAME
    _OUTPUT_PATH = "../data/datasets/neatData/synthetic/results/" + NAME

    tester.set_input(_INPUT_PATH)
    tester.set_output(_OUTPUT_PATH)

    print("Starting the HTM model.")
    tester.run_model()

if __name__ == "__main__":
    run()
