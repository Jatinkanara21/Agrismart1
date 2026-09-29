# Disease Dataset / Model Provenance

The current AgriSmart disease classifier is a **synthetic development model**.

The trainer (train_disease.py) generates deterministic 64x64 RGB leaf-like images with four software-test classes: healthy, leaf_spot, rust, blight.

These images are not real plant photographs and the resulting accuracy must not be interpreted as agricultural diagnostic accuracy.

For a real benchmark, PlantVillage provides 54,306 labeled healthy/diseased leaf images covering multiple crops and diseases. Public documentation reports an open dataset and Creative Commons licensing, but downstream users should verify the original dataset terms before redistribution.

Source: https://github.com/spMohanty/PlantVillage-Dataset

Production requirement: obtain real image data with verified rights, train a validated CNN/TFLite model, evaluate on a held-out field-realistic test set, and replace this synthetic development classifier.
