import os, shutil
from pathlib import Path

def copy_projects (foldername, extension, project, mode):
    num_works = 0
    totalsize = 0
    amount = 0
    filepath = Path(".")
    for subpath in filepath.iterdir():
        if extension != "multiple" and extension in str(subpath) or check_extension(mode, subpath) == True:
            if amount == 0:
                if os.path.exists(foldername) == False:
                    os.mkdir(foldername)
            shutil.copy2(str(subpath), foldername)
            amount+=1
            totalsize+=os.path.getsize(subpath)

    if amount == 0:
        print("No " + project + " files have been found")
    else:
        if totalsize >= 1000000000:
            totalsize = totalsize / 1000000000; unit = " GB"
        elif totalsize >= 1000000:
            totalsize = totalsize / 1000000; unit = " MB"
        elif totalsize >= 1000:
            totalsize = totalsize / 1000; unit = " KB"
        else:
            unit = " bytes"
        print(str(amount) + " " + project + " files have been copied")
        print("Total data copied: " + str(totalsize) + str(unit))


def check_extension (mode, substring):
    if mode == 0:
        fmt_img = [".png", ".jpg", ".jpeg" ".bmp", ".tif", ".tiff", ".webp", ".avif", ".heif", ".heic", ".exr", ".hdr"]
        for i in range(len(fmt_img)):
            if fmt_img[i] in str(substring):
                return True
    elif mode == 1:
        fmt_code = [".c", ".cpp", ".rs", ".asm", "go", ".sh", ".lua", ".py", ".bat", ".rb", ".js", ".cs", ".html", ".ps1"]
        for i in range(len(fmt_code)):
            if fmt_code[i] in str(substring):
                return True


while True:
    print("0: Exit    1: Archive works     2: Archive images     3: Archive code")
    #print("4: Archive code")
    operation = int(input("Choose an operation: "))
    print("")
    if operation == 0:
        break
    elif operation == 1:
        copy_projects("Blender Archive", ".blend", "Blender", 0)
        copy_projects("Krita GIMP Archive", ".kra", "Krita", 0)
        copy_projects("Krita GIMP Archive", ".xcf", "GIMP", 0)
        copy_projects("Photoshop Archive", ".psd", "Photoshop", 0)
    elif operation == 2:
        copy_projects("Images", "multiple", "image", 0)
    elif operation == 3:
        copy_projects("Code", "multiple", "code", 1)
    else:
        print("You need to choose an operation")
    print("")
