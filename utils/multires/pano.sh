#!/bin/bash

# Loop through every JPEG file in the current directory
for file in *.jpg; do
  # Set the output filename to the input filename with "_pano.png" appended
  output=$(echo $file | sed 's/\.jpg$/_pano.png/')
  # Run the Docker container and pass in the current file and output filename as arguments
  sudo docker run -it -v $PWD:/data generate-panorama --png -f 1080 -H 180 -V 180 -F 120 --output /data/$output /data/$file
done

# Remove the Docker container with the ancestor image named 'generate-panorama'
sudo docker rm $(sudo docker ps -a -q --filter ancestor=generate-panorama --format="{{.ID}}")
