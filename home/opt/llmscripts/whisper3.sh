#!/bin/bash
set -e

if [ "$#" -ne 1 ]; then
  echo 'Usage whisper3.sh file.webm'
  exit 1
fi

if ! [ -f "$1" ]; then
  echo 'File nonexistent'
  exit 1
fi

if [[ "$1" =~ \.wav$ ]]; then
  exec 3<"$1"
else
  exec 3< <(ffmpeg -i "$1" -vn -ar 16000 -f wav -)
fi

model=~/opt/llmscripts/whisper-ggml-large-v3.bin
vm=~/opt/llmscripts/ggml-silero-v5.1.2.bin
# model=~/opt/llmscripts/whisper-ggml-large-v3-turbo.bin
# ~/CLionProjects/whisper.cpp/build/bin/whisper-cli -l auto -ovtt -m "$model" /dev/fd/3 -of /dev/fd/4
# ~/CLionProjects/whisper.cpp/build/bin/whisper-cli -l auto -ovtt -m "$model" - <&3 -of /dev/fd/4
#~/CLionProjects/whisper.cpp/build/bin/whisper-cli -l auto -mc 120 -et 2.8 -ovtt -m "$model" - <&3 > "${1%.*}".vtt
~/CLionProjects/whisper.cpp/build/bin/whisper-cli -l auto -mc 100 -et 2.8 -ovtt --vad -vm "$vm" -m "$model" - <&3 > "${1%.*}".vtt
# cachedel "$model"
