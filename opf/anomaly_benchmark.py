#!/usr/bin/env python
import anomalyTester
import modelParamsRDSE as mp
# import modelParams as mp


def run():
    # Choose above which description you want to import.
    tester = anomalyTester.AnomalyTester(mp.MODEL_PARAMS)

    # TRAINING
    trainingSet = "sineSet_niceratio_10minute.csv"

    _INPUT_PATH = "../data/datasets/synthetic/clean" + trainingSet
    _OUTPUT_PATH = "../data/datasets/synthetic/clean/results/sineSet_niceratio_RDSE_10minute.csv"

    tester.set_input(_INPUT_PATH)
    tester.set_output(_OUTPUT_PATH)

    print("Training the HTM model.")
    tester.run_model()
    # TODO: Serialization

    # # TESTING
    # # Learning is always on.
    # anomalySet = "sinePointAnomalySet_niceratio_10minute.csv"
    # _INPUT_PATH = "../data/datasets/synthetic/anomalyPoint/amplitude/" + anomalySet
    #
    # tester.set_input(_INPUT_PATH)
    #
    # print("Testing the HTM model.")
    # tester.run_model()

if __name__ == "__main__":
    run()
