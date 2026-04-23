import os
import io
from PIL import Image
from supabase import create_client

SUPABASE_URL = "------------------------"
SUPABASE_KEY = "-----------------------"
BUCKET = "media"

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

INPUT_DIR = "input_images"

def upload(path, data):
    try:
        supabase.storage.from_(BUCKET).upload(path, data)
    except:
        pass

for file in os.listdir(INPUT_DIR):
    if not file.endswith(('jpg','png','jpeg')):
        continue

    img = Image.open(os.path.join(INPUT_DIR, file))
    name = file.split('.')[0]

    # RAW
    raw = io.BytesIO()
    img.save(raw, format="JPEG")
    upload(f"{name}_raw.jpg", raw.getvalue())

    # MOBILE
    mobile = img.copy()
    mobile.thumbnail((1080,1080))
    mob = io.BytesIO()
    mobile.save(mob, format="WEBP")
    upload(f"{name}_mobile.webp", mob.getvalue())

    # THUMB
    thumb = img.copy()
    thumb.thumbnail((300,300))
    th = io.BytesIO()
    thumb.save(th, format="WEBP")
    upload(f"{name}_thumb.webp", th.getvalue())

    # URLs
    raw_url = supabase.storage.from_(BUCKET).get_public_url(f"{name}_raw.jpg")
    mobile_url = supabase.storage.from_(BUCKET).get_public_url(f"{name}_mobile.webp")
    thumb_url = supabase.storage.from_(BUCKET).get_public_url(f"{name}_thumb.webp")

    supabase.table("posts").insert({
        "media_thumb_url": thumb_url,
        "media_mobile_url": mobile_url,
        "media_raw_url": raw_url,
    }).execute()

print("Done!")
