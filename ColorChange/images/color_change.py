import os
from PIL import Image

input_folder = "input_images"
output_folder = "output_images"

os.makedirs(output_folder, exist_ok=True)

# Warm red tone parameters
max_red = 255
max_green = 120
max_blue = 60

for filename in os.listdir(input_folder):
    if not filename.lower().endswith((".png", ".jpg", ".jpeg", ".bmp", ".tiff")):
        continue

    input_path = os.path.join(input_folder, filename)
    output_path = os.path.join(output_folder, filename)

    img = Image.open(input_path)

    # Split alpha if present
    if img.mode in ("RGBA", "LA"):
        alpha = img.getchannel("A")
        gray = img.convert("L")
    else:
        alpha = None
        gray = img.convert("L")

    width, height = gray.size
    gray_pixels = gray.load()

    warm_img = Image.new("RGB", gray.size)
    warm_pixels = warm_img.load()

    for y in range(height):
        for x in range(width):
            v = gray_pixels[x, y]
            r = int(v * max_red / 255)
            g = int(v * max_green / 255)
            b = int(v * max_blue / 255)
            warm_pixels[x, y] = (r, g, b)

    # Reattach alpha if it existed
    if alpha is not None:
        warm_img = warm_img.convert("RGBA")
        warm_img.putalpha(alpha)

    warm_img.save(output_path)

print("Done")
