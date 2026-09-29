# ML Dataset Provenance

## Crop yield

The yield training pipeline expects `crop_yield.csv` with Crop, Crop_Year, Season, State, Area, Annual_Rainfall, Fertilizer, Pesticide, and Yield columns. The public Indian crop-yield dataset mirrored on Hugging Face documents these fields and covers Indian states/UTs from 1997-2020.

Source reference: https://huggingface.co/datasets/jason1966/akshatgupta7_crop-yield-in-indian-states-dataset

The production pipeline intentionally requires a bundled local copy. It never downloads the dataset during training or inference. The dataset license must be verified before redistribution inside the application repository.

Before using predictions for agronomic decisions, validate the trained model against locally collected, agronomist-reviewed field data for the target region and crops.
