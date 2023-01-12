import unittest

#importing stuff
import sys
import os
import re
packagepath = os.path.abspath(__file__)
packagepath = re.sub(r'\/[^\/]*\/{1}[^\/]*(\.).*', '', packagepath)
if not packagepath in sys.path:
	sys.path.append(packagepath)

#import all test classes
#from unittesting import X
#from unittesting import Y


#run everything
# def my_suite():
#     suite = unittest.TestSuite()
#     result = unittest.TestResult()
#
#     #here is where you add your tests
#     suite.addTest(unittest.makeSuite(translation_testing.translation))
#
#
#     runner = unittest.TextTestRunner()
#     print(runner.run(suite))
# my_suite()
