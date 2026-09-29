from pathlib import Path
import joblib
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
from sklearn.model_selection import train_test_split

FEATURES = ["N", "P", "K", "temperature", "humidity", "ph", "rainfall"]


def train_crop_model(output=None):
    output = Path(output or Path(__file__).parent / "models" / "crop_model.joblib")
    csv = Path(__file__).parent / "data" / "Crop_recommendation.csv"

    if not csv.exists():
        raise FileNotFoundError(
            f"Local crop dataset not found: {csv}. "
            "The AgriSmart ML service does not download datasets from external APIs."
        )

    df = pd.read_csv(csv)
    df.columns = [c.strip() for c in df.columns]
    missing = [c for c in FEATURES + ["label"] if c not in df.columns]
    if missing:
        raise ValueError(f"Crop dataset missing columns: {missing}")

    df = df.dropna(subset=FEATURES + ["label"]).drop_duplicates()
    X, y = df[FEATURES], df["label"].astype(str)

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )

    model = RandomForestClassifier(
        n_estimators=300,
        random_state=42,
        n_jobs=-1,
        class_weight="balanced",
    )
    model.fit(X_train, y_train)

    predictions = model.predict(X_test)
    print("crop_accuracy=", accuracy_score(y_test, predictions))
    print(classification_report(y_test, predictions, zero_division=0))

    output.parent.mkdir(parents=True, exist_ok=True)
    joblib.dump(model, output)
    return model


if __name__ == "__main__":
    train_crop_model()
