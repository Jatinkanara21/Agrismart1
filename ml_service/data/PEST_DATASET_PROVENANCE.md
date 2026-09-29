# Pest Risk Dataset

This dataset is **synthetic and rule-derived for development/CI testing**. It is not a collection of real field observations.

The risk labels are generated from Economic Threshold Level (ETL) guidance published by the Agriculture Department, Government of Punjab. For example, the published cotton thresholds include Jassid at 1 adult/nymph per leaf, Whitefly at 5 per leaf, and Thrips at 8–10 per leaf.

Source guidance:
- https://www.agripunjab.gov.pk/pw_economic
- https://data.mendeley.com/datasets/2pntr3xvmb/1

The Mendeley dataset is a separate real-world survey dataset and is **not copied into this repository**.

Use this synthetic dataset only to validate the software pipeline. Do not use model predictions trained on it as agronomic advice or evidence of field accuracy. Replace it with licensed real field data and re-evaluate the model before production agricultural decisions.
