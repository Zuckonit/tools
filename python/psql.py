import os
import commands

class Connect(object):
    def __init__(self, server, username, password):
        self.server = server
        self.username = username
        self.password = password

    @staticmethod
    def is_root():
        return os.getuid() == 0 

    def get_sudo(self):
        return "" and self.is_root() or "sudo /usr/sbin/chroot / "

    def get_login_sql(self):
        return "%s psql -At -h %s -U %s %s" %(self.get_sudo(), self.server, self.username, self.password)

    def execute(self, strsql):
        login_sql = self.get_login_sql()
        cmd = 'echo -n \"%s\" | %s' % (strsql, login_sql)
        return commands.getoutput(cmd)

    @staticmethod
    def fetch_num(output):
        if not output:
            return 0, []
        out = output.split('\n')
        if 'ERROR' in out[0]:
            return 0, []
        return len(out), out
