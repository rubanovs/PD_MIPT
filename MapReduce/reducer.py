#!/usr/bin/env python3

import sys
import numpy as np

line_id_count = np.random.randint(1, 6)
id_line = []

for line in sys.stdin:
    try:
        id = line.strip().split('/')[1]

        id_line.append(id)
        line_id_count -= 1

        if line_id_count == 0:
            print(','.join(id_line))
            line_id_count = np.random.randint(1, 6)
            id_line = []
    except ValueError as e:
        continue

if len(id_line) != 0:
    print(','.join(id_line))
