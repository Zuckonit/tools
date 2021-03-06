#!/usr/bin/env python
#-*- coding:utf-8 -*-

#copy from https://github.com/coderholic/easydb/
#this is a easy wrapper to handle the sqlite3

import os
import sqlite3

class EasyDB:
    def __init__(self, filename, schema = None, **kwargs):
        exists = os.path.exists(filename)
        if not exists and not schema:
            raise Exception, "The specified database file does not exist, and you haven't provided a schema"

        self.connection = sqlite3.connect(filename)
        if not exists:
            for table_name, fields in schema.items():
                query = "CREATE TABLE %s (%s)" % (table_name, ", ".join(fields))
                self.query(query)

    def __del__(self):
        self.connection.commit()
        self.connection.close()

    def query(self, *args, **kwargs):
        cursor = self.connection.cursor()
        result = cursor.execute(*args, **kwargs)
        return result
