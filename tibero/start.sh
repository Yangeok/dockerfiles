docker run -it \
  -p 8629:8629 \
  --name tibero \
  --hostname localhost \
  --user="root" \
  tibero:0.5 /bin/bash
  # ubuntu:20.04 /bin/bash