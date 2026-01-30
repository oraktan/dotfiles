#!/bin/bash

kitty --class floating-calendar sh -c "
  cal -m;
  echo;
  read -n 1 -s -r -p 'Çıkmak için bir tuşa bas...'
"

