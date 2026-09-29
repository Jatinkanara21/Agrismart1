from pathlib import Path
import joblib
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder

BASE = Path(__file__).resolve().parent
DATA = BASE / "data" / "fertilizer_recommendation.csv"
MODEL = BASE / "models" / "fertilizer_model.joblib"

FEATURES = [
    "Temparature", "Humidity", "Moisture", "Soil_Type", "Crop_Type",
    "Nitrogen", "Potassium", "Phosphorous"
]
TARGET = "Fertilizer"


def train_fertilizer_model(model_path: Path = MODEL) -> Path:
    if not DATA.exists():
        raise FileNotFoundError(
            f"Required bundled dataset is missing: {DATA}. "
            "The training pipeline never downloads data at runtime."
        )

    df = pd.read_csv(DATA)
    missing = [column for column in FEATURES + [TARGET] if column not in df.columns]
    if missing:
        raise ValueError(f"Fertilizer dataset is missing columns: {missing}")

    df = df.dropna(subset=FEATURES + [TARGET]).drop_duplicates()
    if len(df) < 100 or df[TARGET].nunique() < 2:
        raise ValueError("Fertilizer dataset is too small or has fewer than two classes.")

    X = df[FEATURES]
    y = df[TARGET].astype(str)

    categorical = ["Soil_Type", "Crop_Type"]
    numeric = [c for c in FEATURES if c not in categorical]

    preprocessor = ColumnTransformer(
        [
            ("categorical", OneHotEncoder(handle_unknown="ignore"), categorical),
            ("numeric", "passthrough", numeric),
        ]
    )

    pipeline = Pipeline(
        [
            ("preprocessor", preprocessor),
            (
                "classifier",
                RandomForestClassifier(
                    n_estimators=300,
                    random_state=42,
                    class_weight="balanced",
                    n_jobs=-1,
                ),
            ),
        ]
    )

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )
    pipeline.fit(X_train, y_train)

    predictions = pipeline.predict(X_test)
    accuracy = accuracy_score(y_test, predictions)
    print(f"fertilizer_accuracy={accuracy:.4f}")
    print(classification_report(y_test, predictions, zero_division=0))

    model_path.parent.mkdir(parents=True, exist_ok=True)
    joblib.dump(pipeline, model_path)
    return model_path


if __name__ == "__main__":
    train_fertilizer_model()
