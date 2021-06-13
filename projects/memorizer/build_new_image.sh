#!/bin/bash
# Given a linux kernel configuration, and patch file, create a new Linuxkit image.
# Each linuxkit image contains a vmlinux image.
# $1: Path to kernel configuration
# $2: Path to kernel patch file.

# Copy kernel configuration into directory:
mv $1 ./kernel-memorizer/kerner_config-4.10.x

# Make a patch directory if it doesn't exist
mkdir -p ./kernel-memorizer/patches-4.10.x

# Move patch in place
cp $2 ./kernel-memorizer/patches-4.10.x

# Make the new image:
make -C ./kernel-memorizer

if [ $? -eq 0 ]; then
       echo "BUILD SUCCESS!"
       img_name=$(tail -n 1 ./kernel-memorizer/image_name)
       echo "Image name: $img_name"
       # Update Memorizer yaml to use new build info 
       sed "s/\${IMAGE_PATH}/${IMAGE_PATH}/" memorizer_template.yml > memorizer.yml
       echo "Generated new memorizer.yml file"
   else
          echo "BUILD FAILED!"
fi



