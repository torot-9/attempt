# pythonでコマンドをつくる
#   windows用
#
# (テスト中)
# 
#

from cmd import Cmd
import subprocess

class PyCmd(Cmd):
   prompt = "pcmd>"
   intro=("--- python de command ---\n"
            "pdir - dir /b\n"
            "pdir2 - dir /ad /b\n"
            "終了はctrl+z enter\n")
   def __init__(self):
      Cmd.__init__(self)
   
   def do_pdir(self,arg):
      print("----------")
      subprocess.call("dir /b",shell=True)
      print("")
   def help_pdir(self):
      print("pdirのhelp")
   
   def do_pdir2(self,arg):
      print("----------")
      subprocess.call("dir /ad /b",shell=True)
      print("")
   def help_pdir2(self):
      print("pdir2のhelp")
   
   def do_EOF(self,arg):
      return True
   def emptyline(self):
      pass

if __name__ == '__main__':
    PyCmd().cmdloop()
