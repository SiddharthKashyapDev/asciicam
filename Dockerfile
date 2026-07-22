FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# OpenCV requires the GL/GLib runtime libraries. DejaVu supplies the monospace
# font that ASCIICAM expects as consola.ttf, and kbd supports keyboard handling.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        fonts-dejavu-core \
        kbd \
        libgl1 \
        libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN python -m pip install --upgrade pip \
    && python -m pip install -r requirements.txt

COPY main.py font_utils.py helpers.py image_handler.py ./
COPY img ./img

# Do not rely on the currently empty source-tree font file.
RUN ln -s /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf /app/consola.ttf \
    && python -c "from PIL import ImageFont; ImageFont.truetype('consola.ttf', 28)"

ENTRYPOINT ["python", "main.py"]
