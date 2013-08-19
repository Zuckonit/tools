#!/usr/local/python/bin
# coding=utf-8

##This is a copy from https://gist.github.com/dangoakachan/3855920,
##Which is a wrapper of ConfigParser

'''A simple wrapper of ConfigParser to allow attribute access.

This module defines a wrapper named DictConfig of ConfigParser, to allow
access sections/options with attribute operator (.), like cf.section.value.
These ideas are taken from ConfigObject library.

Example:
    $ from pypet.common import confparse
    $ cp = DictConfig('sample.conf')
    $ print cp.section.option

    # Check whether 'test' is a section defined
    $ 'test' in cp
    # Check whether 'opt' is a option defined in section 'test'
    $ 'opt' in cp.test
'''

# Can be 'Prototype', 'Development', 'Product'
__status__ = 'Development'
__author__ = 'tuantuan.lv <dangoakachan@foxmail.com>'

import os
from ConfigParser import ConfigParser

__all__ = ['DictConfig']

# Only for debug use
_debug = False

if _debug:
    def _debug_msg(msg):
        if _debug: print msg
else:
    def _debug_msg(msg): pass

class _DictSection(object):
    '''Dictionary section.'''

    def __init__(self, config, section):
        object.__setattr__(self, '_config', config)
        object.__setattr__(self, '_section', section)

    def __getattr__(self, attr):
        _debug_msg('__getattr__(%s) in DictSection' % attr)
        return self.get(attr, None)

    __getitem__ = __getattr__

    def get(self, attr, default = None):
        _debug_msg('get(%s) in DictSection' % attr)
        if attr in self:
            return self._config.get(self._section, attr)
        else:
            return default

    def __setattr__(self, attr, value):
        _debug_msg('__setattr__(%s, %s) in DictSection' % (attr, value))
        if attr.startswith('_'):
            object.__setattr__(self, attr, value)
        else:
            self.__setitem__(attr, value)

    def __setitem__(self, attr, value):
        _debug_msg('__setitem__(%s, %s) in DictSection' % (attr, value))
        if self._section not in self._config:
            self._config.add_section(self._section)

        self._config.set(self._section, attr, str(value))

    def __delattr__(self, attr):
        if attr in self:
            self._config.remove_option(self._section, attr)

    __delitem__ = __delattr__

    def __contains__(self, attr):
        config = self._config
        section = self._section

        return config.has_section(section) and config.has_option(section, attr)

class DictConfig(ConfigParser, object):
    '''Dictionary config parser.'''

    def __init__(self, filename, *args, **kwargs):
        object.__setattr__(self, '_filename', filename)
        ConfigParser.__init__(self, *args, **kwargs)

        if self._filename and os.path.isfile(self._filename):
            self.read(self._filename)

    def write(self, filename = None):
        '''Write config to file.'''
        fd = open(self._filename if filename is None else filename, 'w')
        ConfigParser.write(self, fd)
        fd.close()

    def __getattr__(self, attr):
        _debug_msg('__getattr__(%s) in DictConfig' % attr)
        return _DictSection(self, attr)

    __getitem__ = __getattr__

    def __setattr__(self, attr, value):
        _debug_msg('__setattr__(%s, %s) in DictConfig' % (attr, value))
        if attr.startswith('_') or attr:
            object.__setattr__(self, attr, value)
        else:
            self.__setitem__(attr, value)

    def __setitem__(self, attr, value):
        _debug_msg('__setitem__(%s, %s) in DictConfig' % (attr, value))
        if isinstance(value, dict):
            section = self[attr]

            for k, v in value.items():
                section[k] = v
        else:
            raise TypeError('Value must be a dict')

    def __delattr__(self, attr):
        if attr in self:
            self.remove_section(attr)

    __delitem__ = __delattr__

    def __contains__(self, attr):
        return self.has_section(attr)
