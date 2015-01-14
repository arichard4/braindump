#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys

lines = [[float(x) for x in l.strip().split()] for l in open(sys.argv[1]).readlines()]


print 'decision boundary\texpected coverage'

tot_covered = 0.0

# Record the decision boundary and expected new covered mentions
coverages = []
for l in lines:
  plow, phigh, extnum, pos, neg = l
  avg_exp = (plow + phigh) / 2.0
  # calculate expected number of newly covered true mentions
  new_covered = extnum * avg_exp
  coverages.append((plow, new_covered))

# Print the decision boundary and expected coverage
tot_covered = sum(x[1] for x in coverages)
now_covered = tot_covered
for plow, this_covered in coverages:
  coverage = now_covered / tot_covered
  print '%.2f\t%.3f' % (plow, coverage)
  now_covered -= this_covered
