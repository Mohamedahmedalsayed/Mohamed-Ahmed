# 🖼️ Image Processing MATLAB Project

## 📌 Project Overview

This project is a **MATLAB-based Image Processing system** that implements most of the core concepts taught in **Digital Image Processing** courses.
The project includes spatial domain operations, frequency domain filtering, noise models, enhancement techniques, and a full **GUI** for interaction.

The goal of the project is to understand **how image processing algorithms work internally**, not just by using built-in MATLAB functions.

---

## 🧠 Features Implemented

### 🔹 Basic Image Conversions

* RGB to Grayscale
* Grayscale to Binary (Thresholding)
* RGB to Binary

### 🔹 Image Enhancement

* Brightness Adjustment (+, −, ×, ÷)
* Negative Transformation (Binary, Grayscale, RGB)
* Contrast Stretching
* Histogram Calculation
* Image Normalization

### 🔹 Intensity Transformations

* Gamma Correction
* Log Transformation
* Inverse Log Transformation

### 🔹 Edge Detection & Sharpening

* Sobel Operator
* Laplacian Operator
* Unsharp Masking
* High Boost Filtering

### 🔹 Noise Models

* Gaussian Noise
* Salt & Pepper Noise
* Uniform Noise

### 🔹 Spatial Filters

* Mean Filter
* Median Filter
* Max Filter
* Min Filter

### 🔹 Frequency Domain Processing

* Fourier Transform
* Inverse Fourier Transform
* Ideal Low Pass Filter (LPF)
* Gaussian Low Pass Filter
* Butterworth Low Pass Filter
* Ideal High Pass Filter (HPF)
* Gaussian High Pass Filter
* Butterworth High Pass Filter

### 🔹 GUI Operations

* Display images on axes
* Resize images
* Read user input from edit boxes
* Execute operations via buttons

---

## 🛠️ Technologies Used

* **MATLAB**
* MATLAB GUI (GUIDE / App Designer style callbacks)
* No built-in image processing shortcuts (manual implementation)

---

## 🗂️ Project Structure

```
📁 Project Folder
 ┣ 📜 rgbtogray.m
 ┣ 📜 graytobinary.m
 ┣ 📜 brightness.m
 ┣ 📜 negative_rgb.m
 ┣ 📜 histogram.m
 ┣ 📜 contrast.m
 ┣ 📜 gamma.m
 ┣ 📜 logTransform.m
 ┣ 📜 sobel.m
 ┣ 📜 laplacian.m
 ┣ 📜 meanFilter.m
 ┣ 📜 medianFilter.m
 ┣ 📜 fourierTransform.m
 ┣ 📜 idealLPF.m
 ┣ 📜 gaussianLPF.m
 ┣ 📜 butterworthLPF.m
 ┣ 📜 GUI.fig
 ┗ 📜 GUI.m
```

---

## ▶️ How to Run the Project

1. Open **MATLAB**
2. Set the project folder as the **Current Folder**
3. Run the GUI file:

```matlab
GUI
```

4. Load an image using the interface
5. Choose the desired operation
6. View the result on the GUI

---

## 📚 Educational Purpose

This project was developed for:

* Understanding **image processing fundamentals**
* Practicing **manual algorithm implementation**
* Learning **MATLAB GUI programming**
* Preparing for exams and practical evaluations

---

## ⚠️ Notes

* All pixel values are clipped between **0 and 255**
* Images are converted to `double` during processing
* Final results are converted back to `uint8`

---

## 👨‍💻 Author

**Mohsen**
Faculty Project – Digital Image Processing

---

## ⭐ Future Improvements

* Add real-time webcam processing
* Add more edge detectors (Prewitt, Canny)
* Optimize code using vectorization
* Convert project to MATLAB App Designer

---

✅ *This project demonstrates a full pipeline of classical image processing techniques implemented from scratch.*
