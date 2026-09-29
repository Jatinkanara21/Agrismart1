from pathlib import Path

import joblib
import numpy as np
from PIL import Image, ImageDraw
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
from sklearn.model_selection import train_test_split

BASE = Path(__file__).resolve().parent
MODEL = BASE / "models" / "disease_model.joblib"

CLASSES = ["healthy", "leaf_spot", "rust", "blight"]


def make_image(label: str, seed: int) -> np.ndarray:
    rng = np.random.default_rng(seed)
    img = np.full((64, 64, 3), [35, 110, 45], dtype=np.uint8)
    yy, xx = np.ogrid[:64, :64]
    leaf = ((xx - 32) / 27) ** 2 + ((yy - 32) / 30) ** 2 <= 1
    noise = rng.normal(0, 8, (64, 64, 1))
    arr = np.clip(img.astype(float) + noise, 0, 255)
    arr[~leaf] = [20, 20, 20]
    arr = arr.astype(np.uint8)
    pil = Image.fromarray(arr)
    draw = ImageDraw.Draw(pil)

    if label == "leaf_spot":
        for _ in range(8):
            x, y = int(rng.integers(12, 52)), int(rng.integers(10, 54))
            r = int(rng.integers(2, 5))
            draw.ellipse((x-r, y-r, x+r, y+r), fill=(125, 75, 35))
    elif label == "rust":
        for _ in range(12):
            x, y = int(rng.integers(10, 54)), int(rng.integers(10, 54))
            r = int(rng.integers(1, 4))
            draw.ellipse((x-r, y-r, x+r, y+r), fill=(180, 75, 25))
    elif label == "blight":
        for _ in range(7):
            x, y = int(rng.integers(8, 56)), int(rng.integers(8, 56))
            w, h = int(rng.integers(5, 12)), int(rng.integers(3, 9))
            draw.ellipse((x, y, x+w, y+h), fill=(75, 45, 25))

    return np.asarray(pil, dtype=np.float32).reshape(-1) / 255.0


def train_disease_model(model_path: Path = MODEL) -> Path:
    X, y = [], []
    for class_id, label in enumerate(CLASSES):
        for seed in range(150):
            X.append(make_image(label, class_id * 1000 + seed))
            y.append(label)

    X, y = np.asarray(X), np.asarray(y)
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )

    model = RandomForestClassifier(
        n_estimators=200,
        random_state=42,
        n_jobs=-1,
    )
    model.fit(X_train, y_train)

    pred = model.predict(X_test)
    print(f"disease_accuracy={accuracy_score(y_test, pred):.4f}")
    print(classification_report(y_test, pred, zero_division=0))

    model_path.parent.mkdir(parents=True, exist_ok=True)
    joblib.dump(model, model_path)
    return model_path


if __name__ == "__main__":
    train_disease_model()
