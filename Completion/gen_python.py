#!/usr/bin/env python

from genzshcomp import ZshCompletionGenerator
from optparse import OptionParser

parser = OptionParser()

commands = [
    'python',
    'pstr',
    'pygmentize',
    'markdown',
]

for command in commands:
    generator = ZshCompletionGenerator('python', parser)
    text = generator.get()
    f = open('_'+command, 'w')
    f.write(text)
    f.close()
