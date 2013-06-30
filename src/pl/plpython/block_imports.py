class ImportBlocker(object):

    def __init__(self, *args):
        self.allowed_module_names = args

    def find_module(self, fullname, path=None):
        if fullname in self.allowed_module_names:
            return None
        return self

    def load_module(self, name):
        raise ImportError("Module %s cannot be imported" % name)

import sys
try:
	from cdecimal import Decimal
except:
	try:
		from decimal import Decimal
	except:
		raise ImportError("Cannot import Decimal type using cdedimal and decimal packages")

sys.meta_path = [ImportBlocker('decimal', 'cdecimal')]
del sys

