# ASCIICAM

TEST

A real-time webcam viewer that renders video as ASCII art directly in your terminal.

---

## Table of Contents

- [General Info](#general-info)
- [Features](#features)
- [Technologies](#technologies)
- [Setup](#setup)
- [Controls](#controls)
- [Sample](#sample)

---

## General Info

**ASCIICAM** transforms webcam video into dynamic ASCII art in real-time. Designed for terminal use, it maps pixel intensity to weighted characters for visual fidelity. Inspired by classic terminal art and built for modern terminals.

---

## Features

- 🖥️ Real-time ASCII rendering from webcam
- 🎚️ Adjustable contrast, brightness, and resolution
- ⌨️ Interactive controls using keyboard keys
- ⚙️ Custom font-based character weighting
- 📐 Efficient redraw using ANSI cursor repositioning
- 🧱 Modular structure for easy extension

---

## Technologies

Project is built with:

- Python ≥ 3.12
- [OpenCV](https://opencv.org/)
- [Pillow (PIL)](https://pillow.readthedocs.io/)
- [Keyboard](https://github.com/boppreh/keyboard)
- ANSI-compatible terminal (Windows Terminal, macOS Terminal, Linux)

Dependencies listed in `requirements.txt`.

---

## Setup

1. **Install dependencies:**

```bash
pip install -r requirements.txt
```

2. **Make sure `consola.ttf` is available** in the root directory. You can use any `.ttf` font, just update the filename in `main.py`.

3. **Run the application:**

```bash
python main.py
```

4. **(Optional)** Resize your terminal or reduce font size for higher visual resolution.

---

## Controls

| Key       | Action                         |
| --------- | ------------------------------ |
| `↑` / `↓` | Increase / decrease contrast   |
| `→` / `←` | Increase / decrease brightness |
| `+` / `-` | Increase / decrease size (×10) |
| `.` / `,` | Fine-tune size (×1)            |
| `r`       | Reset settings to default      |
| `h`       | Show help menu                 |
| `q`       | Quit                           |

> Tip: Press Enter to exit the help menu.

---

## Sample

![Sample Output](/img/sample.png?raw=true "Sample output from ASCIICAM")

---

## Notes

- Performance may vary depending on terminal rendering speed and resolution.

---

## License

MIT License © 2025 Isac Svensson
