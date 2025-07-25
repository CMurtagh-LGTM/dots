import os
import io
import urllib.request
import tarfile
import bz2
import zipfile
import shutil

def download_if_needed(name, prefix, path, url, extration, namelist):
    path = os.path.expanduser(path)
    if os.path.isdir(path + name):
        print(f"skipped {name} as it was already downloaded")
        return

    print(f"downloading {name}")
    with urllib.request.urlopen(url) as resp:
        archive = extration(io.BytesIO(resp.read()))
        members = [
            file_name for file_name in namelist(archive) if file_name.startswith(prefix + name)
        ]
        print(f"extracing {name}")
        archive.extractall(path, members)

        if prefix != "./":
            print(f"copying {name} from {prefix}")
            shutil.copytree(path + prefix + name, path + name)
            shutil.rmtree(path + prefix)

### cursors ###
download_if_needed(
    "everforest-cursors/",
    "./",
    "~/.local/share/icons/",
    "https://github.com/talwat/everforest-cursors/releases/download/3212590527/everforest-cursors-variants.tar.bz2",
    lambda resp: tarfile.TarFile(fileobj = bz2.open(resp)),
    lambda archive: archive.getnames()
)

### icons ###
# TODO maybe also copy over the gtk theme
# download_if_needed(
#     "Everforest-Dark/",
#     "Everforest-GTK-Theme-55c9d11b409a14c98b3d343e0e04ea27397530c3/icons/",
#     "~/.local/share/icons/",
#     "https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme/archive/55c9d11b409a14c98b3d343e0e04ea27397530c3.zip",
#     lambda resp: zipfile.ZipFile(resp),
#     lambda archive: archive.namelist()
# )
# cleanup_dir = os.path.expanduser("~/.local/share/icons/Everforest-GTK-Theme-55c9d11b409a14c98b3d343e0e04ea27397530c3/")
# if os.path.isdir(cleanup_dir):
#     shutil.rmtree(cleanup_dir)
